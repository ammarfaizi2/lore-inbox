Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129116AbRB1SEr>; Wed, 28 Feb 2001 13:04:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129134AbRB1SEh>; Wed, 28 Feb 2001 13:04:37 -0500
Received: from mauve.csi.cam.ac.uk ([131.111.8.38]:19193 "EHLO
	mauve.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id <S129116AbRB1SEZ>; Wed, 28 Feb 2001 13:04:25 -0500
Date: Wed, 28 Feb 2001 18:06:55 +0000 (GMT)
From: "James A. Sutherland" <jas88@cam.ac.uk>
To: "Mr. James W. Laferriere" <babydr@baby-dragons.com>
cc: Per Erik Stendahl <PerErik@onedial.se>,
        "'Linux Kernel'" <linux-kernel@vger.kernel.org>
Subject: Re: Unmounting and ejecting the root fs on shutdown.
In-Reply-To: <Pine.LNX.4.32.0102280750320.24482-100000@filesrv1.baby-dragons.com>
Message-ID: <Pine.LNX.4.30.0102281806260.7011-100000@dax.joh.cam.ac.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 28 Feb 2001, Mr. James W. Laferriere wrote:

>
> 	Hello James ,  Yup that works alright .  But the difficulty
> 	Per & I were talking about is after the system (such as
> 	slackware's live-fs) is -shutdown- the CD drive bay is still
> 	locked ,  One has to hard-reset (or even power off for some)
> 	before the bay will open .  I am well aware why the bay does
> 	not open while the live-fs has it mounted .  But am quite
> 	baffled as to why the darn thing remains locked after system
> 	shutdown .  Again I am quite sure I know why that is happening
> 	as well .  The live-fs is hard read-only and the umount of the
> 	live-fs can not complete , so the CD drive never receives an
> 	unlock .  Sound about right ?  Twyl ,  JimL

The point is, if you mount the CD as /usr, you should then be able to
unmount it properly on shutdown...


James.

