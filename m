Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132006AbRAHTTn>; Mon, 8 Jan 2001 14:19:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132002AbRAHTTZ>; Mon, 8 Jan 2001 14:19:25 -0500
Received: from chaos.analogic.com ([204.178.40.224]:8323 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S131213AbRAHTTU>; Mon, 8 Jan 2001 14:19:20 -0500
Date: Mon, 8 Jan 2001 14:18:57 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Steven_Snyder@3com.com
cc: linux-kernel@vger.kernel.org
Subject: Re: Shared memory not enabled in 2.4.0?
In-Reply-To: <882569CE.0069993A.00@hqoutbound.ops.3com.com>
Message-ID: <Pine.LNX.3.95.1010108141616.23598A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 8 Jan 2001 Steven_Snyder@3com.com wrote:

> 
> 
> For some reason shared memory is not being enabled on my system running kernel
> v2.4.0 (on RedHat v6.2,  with all updates applied).
> 
> Per the documentation I have this line in my /etc/fstab:
> 
>      none  /dev/shm  shm defaults  0 0
> 
> Yes, I have created this subdirectory:
> 
>      # ls -l /dev | grep shm
>      drwxrwxrwt    1 root     root            0 Jan  7 11:54 shm
> 

[Snipped...]

You do have shared memory or else your shared libraries would not
work. The problem is that somebody decided that the CPU cost to
calculate the amount used was "too great", so it's not being shown.

Hopefully this will be resolved at a later date and we will again
be able to see shared memory activity.


Cheers,
Dick Johnson

Penguin : Linux version 2.4.0 on an i686 machine (799.54 BogoMips).

"Memory is like gasoline. You use it up when you are running. Of
course you get it all back when you reboot..."; Actual explanation
obtained from the Micro$oft help desk.


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
