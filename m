Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315690AbSGNJJr>; Sun, 14 Jul 2002 05:09:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315708AbSGNJJq>; Sun, 14 Jul 2002 05:09:46 -0400
Received: from cambot.suite224.net ([209.176.64.2]:13579 "EHLO suite224.net")
	by vger.kernel.org with ESMTP id <S315690AbSGNJJp>;
	Sun, 14 Jul 2002 05:09:45 -0400
Message-ID: <001301c22b17$29261900$c0f583d0@pcs686>
From: "Matthew D. Pitts" <mpitts@suite224.net>
To: "Kernel Mailing List" <linux-kernel@vger.kernel.org>
References: <Pine.SOL.4.30.0207121611170.14389-100000@mion.elka.pw.edu.pl> <3D2EE7BA.8080805@evision-ventures.com> <3D313412.1030102@paulbristow.net>
Subject: Re: IDE/ATAPI in 2.5
Date: Sun, 14 Jul 2002 05:16:38 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="ISO-8859-2"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4133.2400
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paul, et al,

> So to me the problem is not to make everything work as SCSI, because
> that simply isn't true for ide-floppy devices.  They *nearly* work, so
> you can get kludgy, "good enough for command line gurus" working with
> ide-scsi, but there are some funnies.  Does it really make sense to have
> IDE/ATAPI kludges down in the SCSI tree?

If they arn't SCSI, don't treat them like they are.

> I much prefer Linus's suggestion of agreeing on the top level API.  I
> would like to see disks, and removeable media having a single unified
> namespace and set of ioctls so that the different user-space programs
> don't need to worry about if they are dealing with a SCSI, PPA,
> ATAPI-ish, USB, 1394 or whatever comes next drive.  Is that work? yes,
> but it's also about communication and keeping things in the appropriate
> place.  Let me hide the horrible things ide-floppy has to do from
> user-space, and if that means I/we have to completely re-write the
> ioctls etc so be it.

Amen to this... It is a very definite need. And if I may add my $0.02 US, a
unified IDE/ATA/ATAPI API for Linux will make Linux more likely to take its
place on the desktop. As it stands, I have to fiddle with things more than I
like to to get my CD-RW to work with both CD-R and Packet Writing.

Matthew D. Pitts.


