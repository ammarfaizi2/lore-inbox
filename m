Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131213AbRAHT1N>; Mon, 8 Jan 2001 14:27:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131358AbRAHT0x>; Mon, 8 Jan 2001 14:26:53 -0500
Received: from jalon.able.es ([212.97.163.2]:56049 "EHLO jalon.able.es")
	by vger.kernel.org with ESMTP id <S131213AbRAHT0w>;
	Mon, 8 Jan 2001 14:26:52 -0500
Date: Mon, 8 Jan 2001 20:26:42 +0100
From: "J . A . Magallon" <jamagallon@able.es>
To: Steven_Snyder@3com.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: Shared memory not enabled in 2.4.0?
Message-ID: <20010108202642.A1227@werewolf.able.es>
In-Reply-To: <882569CE.0069993A.00@hqoutbound.ops.3com.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
In-Reply-To: <882569CE.0069993A.00@hqoutbound.ops.3com.com>; from Steven_Snyder@3com.com on Mon, Jan 08, 2001 at 20:11:19 +0100
X-Mailer: Balsa 1.0.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Try 'ipcs' and you'll see your shared mem segments info...

On 2001.01.08 Steven_Snyder@3com.com wrote:
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
> No complaints are seen at startup, yet I still have no shared memory:
> 
>      # cat /proc/meminfo
>              total:    used:    free:  shared: buffers:  cached:
>      Mem:  130293760 123133952  7159808        0 30371840 15179776
>      Swap: 136241152        0 136241152
>      MemTotal:       127240 kB
>      MemFree:          6992 kB
>      MemShared:           0 kB
>      Buffers:         29660 kB
>      Cached:          14824 kB
>      Active:           3400 kB
>      Inact_dirty:     37872 kB
>      Inact_clean:      3212 kB
>      Inact_target:        4 kB
>      HighTotal:           0 kB
>      HighFree:            0 kB
>      LowTotal:       127240 kB
>      LowFree:          6992 kB
>      SwapTotal:      133048 kB
>      SwapFree:       133048 kB
> 
> Is there some configuration option which I missed?  Some trick not mentioned
> in
> the doc?
> 
> Thank you.
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> Please read the FAQ at http://www.tux.org/lkml/
> 

-- 
J.A. Magallon                                                      $> cd pub
mailto:jamagallon@able.es                                          $> more beer

Linux werewolf 2.4.0-ac3 #2 SMP Sun Jan 7 02:13:37 CET 2001 i686

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
