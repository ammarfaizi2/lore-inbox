Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271063AbRHTGoN>; Mon, 20 Aug 2001 02:44:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271092AbRHTGnx>; Mon, 20 Aug 2001 02:43:53 -0400
Received: from mail.spylog.com ([194.67.35.220]:24196 "HELO mail.spylog.com")
	by vger.kernel.org with SMTP id <S271063AbRHTGnl>;
	Mon, 20 Aug 2001 02:43:41 -0400
Date: Mon, 20 Aug 2001 10:43:50 +0400
From: Andrey Nekrasov <andy@spylog.ru>
To: linux-kernel@vger.kernel.org
Subject: 2.4.8/2.4.9 problem + 2.4.8-ac7
Message-ID: <20010820104350.A8278@spylog.ru>
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
User-Agent: Mutt/1.3.20i
Organization: SpyLOG ltd.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

 Why linux-kernel 2.4.8-ac7 has not next problems???


Once you wrote about "Re: 2.4.8/2.4.9 problem":
> Hello.
> 
> I am have problem with "kernel: __alloc_pages: 0-order allocation failed."
> 
> 1. syslog kern.*
> 
>    ...
> 	 Aug 19 12:28:16 sol kernel: __alloc_pages: 0-order allocation failed.
> 	 Aug 19 12:28:37 sol last message repeated 364 times
> 	 Aug 19 12:29:17 sol last message repeated 47 times
> 	 Aug 19 12:29:25 sol kernel: s: 0-order allocation failed.
> 	 Aug 19 12:29:25 sol kernel: __alloc_pages: 0-order allocation failed.
> 	 Aug 19 12:29:25 sol last message repeated 291 times
> 	 Aug 19 12:29:25 sol kernel: eth0: can't fill rx buffer (force 0)!
> 	 Aug 19 12:29:25 sol kernel: __alloc_pages: 0-order allocation failed.
> 	 Aug 19 12:29:25 sol kernel: eth0: Tx ring dump,  Tx queue 2928321 /
> 	 2928321:
> 	 Aug 19 12:29:25 sol kernel: eth0:     0 600ca000.
> 	 Aug 19 12:29:25 sol kernel: eth0:  *= 1 000ca000.
> 	 Aug 19 12:29:25 sol kernel: eth0:     2 000ca000.
>    ...
>    Aug 19 12:29:25 sol kernel: eth0:     8 200ca000.
> 	 Aug 19 12:29:25 sol kernel: __alloc_pages: 0-order allocation failed.
> 	 Aug 19 12:29:25 sol kernel: eth0:     9 000ca000.
>    ...
> 	 Aug 19 12:29:25 sol kernel: eth0:  * 31 00000000.
> 	 Aug 19 12:29:25 sol kernel: __alloc_pages: 0-order allocation failed.
> 	 Aug 19 12:29:59 sol last message repeated 75 times
> 	 Aug 19 12:31:10 sol last message repeated 32 times
> 	 Aug 19 12:32:07 sol last message repeated 153 times
> 	 Aug 19 12:32:35 sol last message repeated 131 times
> 
> 2. my configuration:
> 
> 	2CPU/1.5Gb RAM/Mylex Acceleraid 250/Intel PRO100/ Linux kernel 2.4.8/9-xfs /file system   is  xfs or ext2.
> 
> 3. NFS/NFSD kernel v3, and use nfs-root file system.
> 
> 4. Test 1: simple copy from/to another nfs-computer. _big_ file - up-to 4Gb
> 
>    Test 2: tiobench-0.3.1  on _local_ disk (Mylex RAID5) with support
> 	         "LARGEFILES" (>2Gb).
> 
> 
> Can your help me? 
> 
> 
> -- 
> bye.
> Andrey Nekrasov, SpyLOG.
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

-- 
bye.
Andrey Nekrasov, SpyLOG.
