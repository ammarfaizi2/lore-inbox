Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262121AbREMS2k>; Sun, 13 May 2001 14:28:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262324AbREMS2b>; Sun, 13 May 2001 14:28:31 -0400
Received: from virgo.cus.cam.ac.uk ([131.111.8.20]:53751 "EHLO
	virgo.cus.cam.ac.uk") by vger.kernel.org with ESMTP
	id <S262121AbREMS2U>; Sun, 13 May 2001 14:28:20 -0400
Message-Id: <5.1.0.14.2.20010513192639.00a8eec0@pop.cus.cam.ac.uk>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Sun, 13 May 2001 19:29:30 +0100
To: Art Boulatov <art@ksu.ru>
From: Anton Altaparmakov <aia21@cam.ac.uk>
Subject: Re: Linux support for Microsoft dynamic disks?
Cc: Guest section DW <dwguest@win.tue.nl>,
        "Jeff V. Merkey" <jmerkey@vger.timpanogas.org>,
        linux-kernel@vger.kernel.org
In-Reply-To: <01051322152601.00874@artsystems.ksu.ru>
In-Reply-To: <20010513124606.A7758@win.tue.nl>
 <5.1.0.14.2.20010513000214.00ab3810@pop.cus.cam.ac.uk>
 <20010512203445.A4194@vger.timpanogas.org>
 <20010513124606.A7758@win.tue.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 19:15 13/05/2001, Art Boulatov wrote:
>On Sunday 13 May 2001 02:46 pm, Guest section DW wrote:
> > On Sat, May 12, 2001 at 08:34:45PM -0600, Jeff V. Merkey wrote:
> > > What is your specific question?
> >
> > Well, my specific question would be: enough information to support
> > mounting filesystems that live on a dynamic disk.
>
>Understanding the layout of a dynamic disk is just a part of the problem
>as far as I can see it.
>What if I have two (three,four) dynamic disks with volumes organized into a
>software stripe (raid0) under Windows?
>There must be an implementation of MS' software raid in the linux kernel in
>order to access that "striped filesystem"  under linux, I'm I right?

That is a completely separate issue since NT4 software raid also exists but 
doesn't use dynamic disks at all. The existing md driver in Linux can be 
modified to make this work. No need for a full rewrite. There are problems 
with it at the moment which make it not work for ntfs software raid but 
they can be solved. It's just not on anyones high priority list at the 
moment...

Anton


-- 
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Linux NTFS Maintainer / WWW: http://sourceforge.net/projects/linux-ntfs/
ICQ: 8561279 / WWW: http://www-stu.christs.cam.ac.uk/~aia21/

