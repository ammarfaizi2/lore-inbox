Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280987AbRKGVMo>; Wed, 7 Nov 2001 16:12:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280989AbRKGVMf>; Wed, 7 Nov 2001 16:12:35 -0500
Received: from leeor.math.technion.ac.il ([132.68.115.2]:30624 "EHLO
	leeor.math.technion.ac.il") by vger.kernel.org with ESMTP
	id <S280987AbRKGVMZ>; Wed, 7 Nov 2001 16:12:25 -0500
Date: Wed, 7 Nov 2001 23:11:59 +0200 (IST)
From: "Zvi Har'El" <rl@math.technion.ac.il>
To: Andreas Dilger <adilger@turbolabs.com>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Roy Sigurd Karlsbakk <roy@karlsbakk.net>,
        <linux-kernel@vger.kernel.org>, <nyh@math.technion.ac.il>
Subject: Re: ext3 vs resiserfs vs xfs
In-Reply-To: <20011107131930.H5922@lynx.no>
Message-ID: <Pine.GSO.4.33.0111072302460.12525-100000@leeor.math.technion.ac.il>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 7 Nov 2001, Andreas Dilger wrote:

> On Nov 07, 2001  17:28 +0200, Zvi Har'El wrote:
> > I get this countdown, but after 5 seconds fsck starts anyway, without me
> > hitting Y! Should I hit N, or should I change some config somewhere? Now each
> > time my battery runs out, I need fsck!
>
> Are you SURE you are using ext3?  Check /proc/mounts to be sure.  What it
> says in /etc/fstab is irrelevant for the root filesystem.
>
/proc/mounts has

/dev/root / ext2 rw 0 0
/dev/hda6 /home ext3 rw 0 0

However, tune2fs -l on both /dev/hda1 (the root filesystem) and /dev/hda6 gives
Filesystem features:      has_journal sparse_super


How do  fix the situation at this stage? I am using Redhat 7.2 with kernel
2.4.9-13

Thanks for your help,

Zvi.


-- 
Dr. Zvi Har'El     mailto:rl@math.technion.ac.il     Department of Mathematics
tel:+972-54-227607                   Technion - Israel Institute of Technology
fax:+972-4-8324654 http://www.math.technion.ac.il/~rl/     Haifa 32000, ISRAEL
"If you can't say somethin' nice, don't say nothin' at all." -- Thumper (1942)
                         Wednesday, 22 Heshvan 5762,  7 November 2001, 11:02PM

