Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265830AbSJSXkk>; Sat, 19 Oct 2002 19:40:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265831AbSJSXkk>; Sat, 19 Oct 2002 19:40:40 -0400
Received: from astound-64-85-224-253.ca.astound.net ([64.85.224.253]:9484 "EHLO
	master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S265830AbSJSXkj>; Sat, 19 Oct 2002 19:40:39 -0400
Date: Sat, 19 Oct 2002 16:44:32 -0700 (PDT)
From: Andre Hedrick <andre@linux-ide.org>
To: Brian Gerst <bgerst@quark.didntduck.org>
cc: Christian Borntraeger <linux@borntraeger.net>,
       linux-kernel@vger.kernel.org
Subject: Re: PROBLEM: ide-related kernel panic in 2.4.19 and 2.4.20-pre11
In-Reply-To: <3DB1E876.2000302@quark.didntduck.org>
Message-ID: <Pine.LNX.4.10.10210191627090.24031-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Did you consider the attempt to copy may invoke the device to attempt to
jam and crash the transport?  Did you consider the SCSI layer may not be
capable of handling the task management command? 

They are not broken if you have a device which is "Copy-protected" aware.
It will attempt to thwart your operation request and that can include
crashing a system.

> Copy-protected discs abuse the CD standards to the point where CDROM
> drives consider them defective and can't/won't read them, while less
> intelligent devices can.  Trying to read one of these discs should only
> cause the kernel to return an error, never an oops.

You admit that older dumber devices just work.
So much for new and improved, go find the old and lousy that works.

Asking me to make it so you or anyone else can bypass
copy-content-protection is out of the question.  If you do not ask the
device to do bad things, then it will not do bad things back at you.

If your memory is short, recall I was the only person to stand up and take
issue about having CPRM stuffed into your harddrives by default.

Make a note, DON"T BUY SONY CDRW Products. 

Now if you are serious about want to fix the issue and not rant about
issues that have no meaning because they are your opinion on how the world
should work as it relates to hardware, then we can move on.

Regards,

Andre Hedrick
LAD Storage Consulting Group

