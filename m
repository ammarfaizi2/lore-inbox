Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261949AbREQPwu>; Thu, 17 May 2001 11:52:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261953AbREQPwl>; Thu, 17 May 2001 11:52:41 -0400
Received: from ams8uucp0.ams.ops.eu.uu.net ([212.153.111.69]:62343 "EHLO
	ams8uucp0.ams.ops.eu.uu.net") by vger.kernel.org with ESMTP
	id <S261949AbREQPwb>; Thu, 17 May 2001 11:52:31 -0400
Date: Thu, 17 May 2001 17:50:44 +0200 (CEST)
From: kees <kees@schoen.nl>
To: "Andrea Dell'Amico" <adellam@link.it>
cc: linux-kernel@vger.kernel.org
Subject: Re: smp hangs with 2.2.19 kernel
In-Reply-To: <990095136.29185.5.camel@altrove>
Message-ID: <Pine.LNX.4.21.0105171748120.2572-100000@schoen3.schoen.nl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I'm too chasing this one. I have only one IDE drive and an SCSI controller
which is mostly idle but sometimes used for a scanner. At first I thought
is was hardware but I'm going to believe it is a software problem. 
I replaced most of the hardware even the motherboard.
2.2.19 with PIII-667 Mhz/128MB MSI 594D mobo.

Kees

On 17 May 2001, Andrea Dell'Amico wrote:

> 
> Hallo, I have a problem with a dual processor machine. With Red Hat
> 2.2.19 kernel, but with every 2.2.1x kernel, from Red Hat or self
> compiled, the machine hangs with lot of processes in D state:
> 
> vmstat output is
> 
> procs       memory    swap          io     system         cpu
>  r  b  w swpd free  buff cache si  so    bi    bo   in    cs  us  sy  id
>  1 225 2   0  10632  10936  16456   0   0  6   3   14     9   6   3  14
> 
> 
> The memory situation:
> 
> [root@petra petra]# free
>              total       used       free     shared    buffers
> cached
> Mem:        523800     504688      19112          0      10620
> 31352
> -/+ buffers/cache:     462716      61084
> Swap:      2097136      35164    2061972
> 
> 
> The box has 5 scsi disks with a aic7xxx controller. 4 disks are in RAID
> 1, the fifth is only used for the swap partition (2 GB).
> 
> When the machine hangs there are no logs.
> 
> Is there a way I can debug the cause? 
> 
> Thanks in advance,
> andrea
> 
> 
> -- 
> Andrea Dell'Amico
> <adellam@link.it> - Link s.r.l. <http://www.link.it>
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

