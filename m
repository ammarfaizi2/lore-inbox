Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278145AbRJLVWp>; Fri, 12 Oct 2001 17:22:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278147AbRJLVWe>; Fri, 12 Oct 2001 17:22:34 -0400
Received: from dial249.pm3abing3.abingdonpm.naxs.com ([216.98.75.249]:50698
	"EHLO ani.animx.eu.org") by vger.kernel.org with ESMTP
	id <S278145AbRJLVWY>; Fri, 12 Oct 2001 17:22:24 -0400
Date: Fri, 12 Oct 2001 17:29:55 -0400
From: Wakko Warner <wakko@animx.eu.org>
To: Mike Panetta <mpanetta@applianceware.com>, linux-kernel@vger.kernel.org,
        andre@linux-ide.org
Subject: Re: IDE Hot-Swap, does it work?, Conspiracy is afoot!
Message-ID: <20011012172955.B12857@animx.eu.org>
In-Reply-To: <20011011131042.A2780@tetsuo.applianceware.com> <20011012132802.B6355@tetsuo.applianceware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.95.3i
In-Reply-To: <20011012132802.B6355@tetsuo.applianceware.com>; from Mike Panetta on Fri, Oct 12, 2001 at 01:28:02PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've done this with my IDE cdrom in my laptop.  It's hot swappable and I
asked about this at one time.  In the source package for hdparm (i know it's
in the debian's source package) there's a script for hot add/remove of ide
devices.  there's a nice warning attached about ide hotswap

> Ok, I have played with this a bit since I have recieved no
> real respose other than one other person having the same
> question, here is what I have found out...
> 
> I have a piece of hardware that does have hot-swap IDE
> chassis on it, so atleast the IDE bus xcvers should be
> able to handle the swapping, as the connection to the
> drive is disabled before the can comes all the way out
> of the slot.
> 
>  - I can remove a drive while the system is on and I have
>    a software raid 5 on the 4 drives, everything is ok
>    after about 2 minutes the system recovers and the software
>    raid fails the drive I removed.  This makes sense.
>  - After a few minutes I replace the drive I had just failed
>    by removing it, and I try to readd it to the system via
>    raidhotadd.  One of 2 things happens in this instance,
>    depending on what kernel I have loaded.  
>     - If I have kernel 2.4.2-2 loaded (a stock redhat 7.1
>       kernel), the drive reappears, and can be added back
>       to the raid (and is added back).
>     - If I am running kernel 2.4.10 or any later (AC or non)
>       the machine fails to ever be able to read from the disk
>       again.  I cannot readd the disk to the arry, nor can I
>       fdisk it (or access it in any other way).
>  - None of this solves the adding of a drive to the system
>    where there was none before boot...  I tried the hdparm -R
>    stuff but its useless and hangs my box no matter what I give
>    it as paramaters.  This of course may be because I do not
>    know how to use it very well...
> 
> If anyone can help it would be greatly appreciated.  I am
> really beginning to believe that IDE will never be as capable
> as SCSI in this reguard, atleast not in linux, espically as
> any (even if it was broken) support that used to be in the
> kernel has disappeared. Please someone convince me otherwise!
> Atleast point me in the correct direction as to what in the
> kernel would have to be changed to make this work...
> 
> Thanks,
> Mike
> 
> -- 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
-- 
 Lab tests show that use of micro$oft causes cancer in lab animals
