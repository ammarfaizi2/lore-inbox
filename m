Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280976AbRKOSS1>; Thu, 15 Nov 2001 13:18:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280941AbRKOSSS>; Thu, 15 Nov 2001 13:18:18 -0500
Received: from darkwing.uoregon.edu ([128.223.142.13]:20165 "EHLO
	darkwing.uoregon.edu") by vger.kernel.org with ESMTP
	id <S280971AbRKOSSE>; Thu, 15 Nov 2001 13:18:04 -0500
Date: Thu, 15 Nov 2001 10:17:51 -0800 (PST)
From: Joel Jaeggli <joelja@darkwing.uoregon.edu>
X-X-Sender: <joelja@twin.uoregon.edu>
To: Roy Sigurd Karlsbakk <roy@karlsbakk.net>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: Linux i/o tweaking
In-Reply-To: <Pine.LNX.4.30.0111151535060.13411-100000@mustard.heime.net>
Message-ID: <Pine.LNX.4.33.0111151009380.28958-100000@twin.uoregon.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I guess the question I'd ask would be what kinda number do you expect from 
the raid 5 stripe. 107MB/s sounds like a reasonable number from a two 
channel u160 controller... 

my previous best is around 89MB/s with 4 cheetah 15K 18gb drives raid/0

On Thu, 15 Nov 2001, Roy Sigurd Karlsbakk 
wrote:

> Hi all
> 
> After three days at Compaq's lab in Oslo, testing their medium-level
> servers and storage systems with Linux, I've come to some sort of
> conclusions, although these may be wrong. I also have come over a few
> problems that I couln't find a good solution to.
> 
>  * When running RAID from a Compaq Smart 5302/64 controller, software
> RAID-5 is (slightly - ~15%) faster (on JBOD - each disk is configured as
> a RAID-0 device with max - 256kB - stripe size) than the
> hardware/controller based RAID-5. Both CPUs (1266MHz/512kB cache) are
> maxed out by reading from software RAID-5 (???), giving me >= 107MB/s on
> two SCSI-3 buses with six disks on each bus.
> 
>  * Even though I can get up to 25 MB/s from each disk, I can't get more
> than 107 MB/s on the whole bunch (12 drives). It doesn't help much to do
> RAID-0 either. Don't understand anything ...
> 
> Thanks for all help.
> 
> roy
> 
> --
> Roy Sigurd Karlsbakk, MCSE, MCNE, CLS, LCA
> 
> Computers are like air conditioners.
> They stop working when you open Windows.
> 
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

-- 
-------------------------------------------------------------------------- 
Joel Jaeggli				       joelja@darkwing.uoregon.edu    
Academic User Services			     consult@gladstone.uoregon.edu
     PGP Key Fingerprint: 1DE9 8FCA 51FB 4195 B42A 9C32 A30D 121E
--------------------------------------------------------------------------
It is clear that the arm of criticism cannot replace the criticism of
arms.  Karl Marx -- Introduction to the critique of Hegel's Philosophy of
the right, 1843.


