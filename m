Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290309AbSAXVTV>; Thu, 24 Jan 2002 16:19:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290308AbSAXVTM>; Thu, 24 Jan 2002 16:19:12 -0500
Received: from ns1.baby-dragons.com ([199.33.245.254]:39828 "EHLO
	filesrv1.baby-dragons.com") by vger.kernel.org with ESMTP
	id <S290304AbSAXVS4>; Thu, 24 Jan 2002 16:18:56 -0500
Date: Thu, 24 Jan 2002 16:17:44 -0500 (EST)
From: "Mr. James W. Laferriere" <babydr@baby-dragons.com>
To: Wakko Warner <wakko@animx.eu.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.16
In-Reply-To: <20020124123558.A19899@animx.eu.org>
Message-ID: <Pine.LNX.4.44.0201241603420.17580-100000@filesrv1.baby-dragons.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


	Hello Wakko ,  I haven't seen that symptom here .  Do you want to
	trade .config's ?  Below are my stats for 11 days .  JimL

babydr@filesrv1:~$ free
             total       used       free     shared    buffers     cached
Mem:        898260     884620      13640          0      39312     730824
-/+ buffers/cache:     114484     783776
Swap:       656532          0     656532

babydr@filesrv1:~$ uptime
  4:03pm  up 11 days, 50 min,  5 users,  load average: 0.00, 0.00, 0.00

babydr@filesrv1:~$ uname -a
Linux filesrv1 2.4.18-pre3 #1 SMP Sun Jan 13 15:00:08 EST 2002 i686 unknown


On Thu, 24 Jan 2002, Wakko Warner wrote:

> recent 2.4 kernels seem to love eating away at memory.  After 2 weeks of
> uptime, 2.2.19 would normally consume about 120mb of ram and maybe 1mb of
> swap.  With 2.4.16 it's more than doubled.  Swap usage is 128mb, memory
> useage about 230mb.  Nothing is different between what I ran with 2.2 and
> what I run now with 2.4.
>
> Is linux trying to do memory consumtion like windows now?
>
> The other odd thing is, when I go to single user (init 1), I still have
> 100-120mb memory used.  Only thing running is the shell init and kernel
> processes.  This is after all modules have been unloaded as well (my kernel
> only has what it takes to mount / and nothing more)  Where is this memory
> going?  I shouldn't have THAT much used with nothing running.
>
> memory: 512mb
> swap:   130mb (2 65mb partitions on scsi)
>
> --
>  Lab tests show that use of micro$oft causes cancer in lab animals
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

       +------------------------------------------------------------------+
       | James   W.   Laferriere | System    Techniques | Give me VMS     |
       | Network        Engineer |     P.O. Box 854     |  Give me Linux  |
       | babydr@baby-dragons.com | Coudersport PA 16915 |   only  on  AXP |
       +------------------------------------------------------------------+

