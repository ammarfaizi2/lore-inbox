Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130239AbRB1P5T>; Wed, 28 Feb 2001 10:57:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130240AbRB1P5K>; Wed, 28 Feb 2001 10:57:10 -0500
Received: from filesrv1.baby-dragons.com ([199.33.245.55]:21518 "EHLO
	filesrv1.baby-dragons.com") by vger.kernel.org with ESMTP
	id <S130239AbRB1P4u>; Wed, 28 Feb 2001 10:56:50 -0500
Date: Wed, 28 Feb 2001 07:56:41 -0800 (PST)
From: "Mr. James W. Laferriere" <babydr@baby-dragons.com>
To: "James A. Sutherland" <jas88@cam.ac.uk>
cc: Per Erik Stendahl <PerErik@onedial.se>,
        "'Linux Kernel'" <linux-kernel@vger.kernel.org>
Subject: Re: Unmounting and ejecting the root fs on shutdown.
In-Reply-To: <Pine.LNX.4.30.0102281529110.6716-100000@dax.joh.cam.ac.uk>
Message-ID: <Pine.LNX.4.32.0102280750320.24482-100000@filesrv1.baby-dragons.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


	Hello James ,  Yup that works alright .  But the difficulty
	Per & I were talking about is after the system (such as
	slackware's live-fs) is -shutdown- the CD drive bay is still
	locked ,  One has to hard-reset (or even power off for some)
	before the bay will open .  I am well aware why the bay does
	not open while the live-fs has it mounted .  But am quite
	baffled as to why the darn thing remains locked after system
	shutdown .  Again I am quite sure I know why that is happening
	as well .  The live-fs is hard read-only and the umount of the
	live-fs can not complete , so the CD drive never receives an
	unlock .  Sound about right ?  Twyl ,  JimL

On Wed, 28 Feb 2001, James A. Sutherland wrote:

> On Wed, 28 Feb 2001, Mr. James W. Laferriere wrote:
>
> >
> > 	Hello Per ,  Has anyone gotten back to you on this subject ?
> > 	I as well am very interested in any information about releiving
> > 	this difficulty .  Tia ,  JimL
>
> Such a CD would be very nice; one or two people do have this already,
> though. Have you tried using a ramdisk for root, and mounting the CD as
> /usr?
>
>
> James.
>

       +----------------------------------------------------------------+
       | James   W.   Laferriere | System  Techniques | Give me VMS     |
       | Network        Engineer | 25416      22nd So |  Give me Linux  |
       | babydr@baby-dragons.com | DesMoines WA 98198 |   only  on  AXP |
       +----------------------------------------------------------------+

