Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132566AbRCZTMp>; Mon, 26 Mar 2001 14:12:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132564AbRCZTLE>; Mon, 26 Mar 2001 14:11:04 -0500
Received: from h24-65-193-28.cg.shawcable.net ([24.65.193.28]:27641 "EHLO
	webber.adilger.int") by vger.kernel.org with ESMTP
	id <S132563AbRCZTKz>; Mon, 26 Mar 2001 14:10:55 -0500
From: Andreas Dilger <adilger@turbolinux.com>
Message-Id: <200103261909.f2QJ95O19914@webber.adilger.int>
Subject: Re: 64-bit block sizes on 32-bit systems
In-Reply-To: <20010326190945.I31126@parcelfarce.linux.theplanet.co.uk> from Matthew
 Wilcox at "Mar 26, 2001 07:09:45 pm"
To: Matthew Wilcox <matthew@wil.cx>
Date: Mon, 26 Mar 2001 12:09:04 -0700 (MST)
CC: Andreas Dilger <adilger@turbolinux.com>, LA Walsh <law@sgi.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
X-Mailer: ELM [version 2.4ME+ PL66 (25)]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matthew Wilcox writes:
> On Mon, Mar 26, 2001 at 10:47:13AM -0700, Andreas Dilger wrote:
> > What do you mean by problems 5 years down the road?  The real issue is that
> > this 32-bit block count limit affects composite devices like MD RAID and
> > LVM today, not just individual disks.  There have been several postings
> > I have seen with people having a problem _today_ with a 2TB limit on
> > devices.
> 
> people who can afford 2TB of disc can afford to buy a 64-bit processor.

Get real.  If you buy (cheapest) 40GB IDE disks, I can have 2TB for
U$9200 (not including controllers).  In 1 year it will be half, etc.
I expect I will start moving my DVD collection to disk storage in an
ia32 system once price/GB falls by 50% from current levels.  This is
just for home use, let alone what large companies want to do.  I am
fully expecting hard drive price/GB to keep falling at its current rate.

This whole "64-bit" fallacy has got to stop.  First it was "anybody
who needs files > 2GB should use a 64-bit CPU", wrong.  Then it was
"anybody who needs > 1GB RAM should use a 64-bit CPU", wrong.  Now it is
"anybody who needs > 2TB disk should use a 64-bit CPU", soon to be wrong.
I don't think the millions of 32-bit systems will disappear overnight,
or even in 10 years, yet we already have single IDE disks > 100GB, and
in 2 or 3 years we will have single IDE disks > 1TB that people will
want to use in their 32-bit systems.

Cheers, Andreas
-- 
Andreas Dilger  \ "If a man ate a pound of pasta and a pound of antipasto,
                 \  would they cancel out, leaving him still hungry?"
http://www-mddsp.enel.ucalgary.ca/People/adilger/               -- Dogbert
