Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262486AbRENUqM>; Mon, 14 May 2001 16:46:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262484AbRENUqD>; Mon, 14 May 2001 16:46:03 -0400
Received: from h24-65-193-28.cg.shawcable.net ([24.65.193.28]:18172 "EHLO
	webber.adilger.int") by vger.kernel.org with ESMTP
	id <S262486AbRENUp7>; Mon, 14 May 2001 16:45:59 -0400
From: Andreas Dilger <adilger@turbolinux.com>
Message-Id: <200105142044.f4EKiSQY002195@webber.adilger.int>
Subject: Re: Linux support for Microsoft dynamic disks?
In-Reply-To: <01051322152601.00874@artsystems.ksu.ru> "from Art Boulatov at May
 13, 2001 10:15:26 pm"
To: Art Boulatov <art@ksu.ru>
Date: Mon, 14 May 2001 14:44:28 -0600 (MDT)
CC: Guest section DW <dwguest@win.tue.nl>,
        "Jeff V. Merkey" <jmerkey@vger.timpanogas.org>,
        Anton Altaparmakov <aia21@cam.ac.uk>, linux-kernel@vger.kernel.org
X-Mailer: ELM [version 2.4ME+ PL87 (25)]
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Art writes:
> Understanding the layout of a dynamic disk is just a part of the problem
> as far as I can see it.
> What if I have two (three,four) dynamic disks with volumes organized into a 
> software stripe (raid0) under Windows?
> There must be an implementation of MS' software raid in the linux kernel in 
> order to access that "striped filesystem"  under linux, I'm I right?

I think the correct place to start implementing this is in the framework
of the EVMS project (http://sourceforge.net/projects/evms).  It is doing
the work of a generalized block-remapping driver for Linux.  They already
have working Linux LVM kernel drivers, along with MS-DOS partition code,
etc.  Adding in the NT dynamic disk remapping would probably be welcome.

Cheers, Andreas
-- 
Andreas Dilger  \ "If a man ate a pound of pasta and a pound of antipasto,
                 \  would they cancel out, leaving him still hungry?"
http://www-mddsp.enel.ucalgary.ca/People/adilger/               -- Dogbert
