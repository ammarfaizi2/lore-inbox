Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130060AbRBBUU7>; Fri, 2 Feb 2001 15:20:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129904AbRBBUUj>; Fri, 2 Feb 2001 15:20:39 -0500
Received: from chaos.analogic.com ([204.178.40.224]:1664 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S129487AbRBBUUf>; Fri, 2 Feb 2001 15:20:35 -0500
Date: Fri, 2 Feb 2001 15:20:03 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Delta <birtl00@dmi.usherb.ca>
cc: linux-kernel@vger.kernel.org
Subject: Re: System unresponsitive when copying HD/HD
In-Reply-To: <3A7B1129.2ED4CCE4@dmi.usherb.ca>
Message-ID: <Pine.LNX.3.95.1010202151335.218A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2 Feb 2001, Delta wrote:

> Hi,
> 
> I backup my linux partition once a month from my second IDE drive to an
> empty partition
> on the first IDE disk. I have about 2.8 Gig to copy, and I use <cp -ax /
> /mnt/hd> to do the copy.
> 


# cd / ; nice -n 20 tar -clf - . | (cd /mnt/hd; tar -xpf -)

Will probably do what you want.


Cheers,
Dick Johnson

Penguin : Linux version 2.4.1 on an i686 machine (799.53 BogoMips).

"Memory is like gasoline. You use it up when you are running. Of
course you get it all back when you reboot..."; Actual explanation
obtained from the Micro$oft help desk.


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
