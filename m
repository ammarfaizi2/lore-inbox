Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288760AbSANE7D>; Sun, 13 Jan 2002 23:59:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288765AbSANE6y>; Sun, 13 Jan 2002 23:58:54 -0500
Received: from zeus.kernel.org ([204.152.189.113]:59289 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S288760AbSANE6g>;
	Sun, 13 Jan 2002 23:58:36 -0500
Date: Sun, 13 Jan 2002 20:40:37 -0800 (PST)
From: Andre Hedrick <andre@linuxdiskcert.org>
To: Anton Altaparmakov <aia21@cam.ac.uk>
cc: linux-kernel@vger.kernel.org
Subject: Re: IDE Patches bring amazing performance gain!!!
In-Reply-To: <5.1.0.14.2.20020114013246.04c1d330@pop.cus.cam.ac.uk>
Message-ID: <Pine.LNX.4.10.10201131940530.18550-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


There is one outstanding bad report in private.  This report effects the
Promise PDC20262 Ultra66 host only.  I tested it w/ a 1.13 BIOS and it
worked.  I suggested the individual upgrade to the lastest version from
Promise.  One should note this is a 48-bit addressing exception, for old
hardware.

Andre Hedrick
Linux Disk Certification Project                Linux ATA Development

On Mon, 14 Jan 2002, Anton Altaparmakov wrote:

> As a heads up, Andre Hedrick's (Andre sorry for the misspelling 
> previously!) IDE patch improved the performance of my 7200rpm ATA100 IBM 
> IDE hd from 28Mb/s to 38Mb/s as measured by hdparm -t /dev/hda, which is 
> quite an improvement by anyones standards! Also hitting the disk with a lot 
> of io maintains low latency and my mp3s aren't dropping out and my X 
> session maintains interactivity. (-:
> 
> Considering I have seen many good reports and ZERO bad reports about the 
> IDE patches it is really astonishing that the patches are not being applied 
> to the 2.4.x kernel series... (especially as they were in the -ac series 
> previously already)
> 
> Best regards,
> 
> Anton
> 
> At 01:07 14/01/02, Anton Altaparmakov wrote:
> >Alan's -ac series is back! To celebrate this I added in the IDE patches 
> >and an NTFS update which dramatically reduces the number of vmalloc()s and 
> >have posted the resulting (tested) patch (to be applied on top of 
> >2.4.18pre3-ac1) at below URL.
> >
> >http://www-stu.christs.cam.ac.uk/~aia21/linux/patch-2.4.18-pre3-ac1-aia1.bz2
> >http://www-stu.christs.cam.ac.uk/~aia21/linux/patch-2.4.18-pre3-ac1-aia1.gz
> >
> >
> >Linux 2.4.18pre3-ac1-aia1
> >
> >o       IDE patch (taskfile, lba-48, ata133, etc)       Andre Hedrick
> >o       Configure help entries for above                Andre Hedrick, Rob 
> >Radez
> >o       Small IDE cleanups (code beauty only)           Pavel Machek, me
> >o       Reduce NTFS vmalloc() use (NTFS 1.1.22)         me
> >
> >Enjoy,
> >
> >Anton
> 
> -- 
>    "I've not lost my mind. It's backed up on tape somewhere." - Unknown
> -- 
> Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
> Linux NTFS Maintainer / WWW: http://linux-ntfs.sf.net/
> ICQ: 8561279 / WWW: http://www-stu.christs.cam.ac.uk/~aia21/
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 


