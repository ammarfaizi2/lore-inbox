Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132908AbRDJDOj>; Mon, 9 Apr 2001 23:14:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132907AbRDJDOa>; Mon, 9 Apr 2001 23:14:30 -0400
Received: from h24-65-193-28.cg.shawcable.net ([24.65.193.28]:30455 "EHLO
	webber.adilger.int") by vger.kernel.org with ESMTP
	id <S132906AbRDJDOW>; Mon, 9 Apr 2001 23:14:22 -0400
From: Andreas Dilger <adilger@turbolinux.com>
Message-Id: <200104100314.f3A3E4w8008349@webber.adilger.int>
Subject: Re: linux/scsi
In-Reply-To: <F902buW5RNB6HfMVur600001865@hotmail.com> "from Jim M. at Apr 10,
 2001 01:56:11 am"
To: "Jim M." <msg124@hotmail.com>
Date: Mon, 9 Apr 2001 21:14:04 -0600 (MDT)
CC: redhat-devel-list@redhat.com, gtk-app-devel-list@gnome.org,
        linux-kernel@vger.kernel.org
X-Mailer: ELM [version 2.4ME+ PL87 (25)]
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

You write:
> are there samples of linux codes that can talk to SCSI harddisk, scanners 
> and
> cameras in the Linux kernel.  Like in windows NT, one does not need to write
> driver for his scsi device. Just use some scsi interface libraries to talk 
> to the scsi device. Is there such examples in linux?.I need to learn this so 
> that i can develop the same thing for a scsi digital camera.

See the SANE project, which has support for lots of SCSI scanners, and is
the defacto standard for image acquisition for GIMP and such.  It has lots
of other good features already (dynamic loading of backends (i.e. "device
drivers"), network device access, GUI/text front ends, etc).  I believe it
is also being used for other high-end image acquisition devices, not just
scanners.

Cheers, Andreas
-- 
Andreas Dilger  \ "If a man ate a pound of pasta and a pound of antipasto,
                 \  would they cancel out, leaving him still hungry?"
http://www-mddsp.enel.ucalgary.ca/People/adilger/               -- Dogbert
