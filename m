Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266296AbUAGU0N (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jan 2004 15:26:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266302AbUAGU0N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jan 2004 15:26:13 -0500
Received: from fw-us-hou19.bmc.com ([198.207.223.240]:2676 "EHLO
	babbler.bmc.com") by vger.kernel.org with ESMTP id S266296AbUAGU0L
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jan 2004 15:26:11 -0500
Date: Wed, 7 Jan 2004 14:25:44 -0600 (CST)
From: Richard Troth <rtroth@bmc.com>
To: Greg KH <greg@kroah.com>
Cc: Linus Torvalds <torvalds@osdl.org>, Andrey Borzenkov <arvidjaar@mail.ru>,
       linux-hotplug-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: removable media revalidation - udev vs. devfs or static /dev
In-Reply-To: <20040107195032.GB823@kroah.com>
Message-ID: <Pine.LNX.4.53.0401071418300.7097@rmt-desk.bmc.com>
References: <200401012333.04930.arvidjaar@mail.ru> <20040103055847.GC5306@kroah.com>
 <Pine.LNX.4.58.0401071036560.12602@home.osdl.org> <20040107185656.GB31827@kroah.com>
 <Pine.LNX.4.58.0401071123490.12602@home.osdl.org> <20040107195032.GB823@kroah.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > NOTE! We do have an alternative: if we were to just make block device
> > nodes support "readdir" and "lookup", you could just do
> >
> > 	open("/dev/sda/1" ...)
> >
> > and it magically works right. I've wanted to do this for a long time, but
> > every time I suggest allowing it, people scream.

Nooo!!!   Resist the temptation!!   Don't give in!

> Hm, that would be nice.  I don't remember seeing it being proposed
> before, what are the main complaints people have with this?

Consider the long-range ramifications
if a device can also be a directory,  just "magically".
I'm not going to automatically diss the idea  (other than my
natural reaction above)  but please consider beyond the immediate hack.

It reminds me of AIX from the days when it ran on PCs.
They had this neat trick of  "hidden directories"  (for a different
purpose).   It looked like an executable,  but really was a
directory containing multiple executables for various platforms.
(This version of AIX also ran on the mainframe, AIX/386 and AIX/370.)
There were/are better ways of solving the problem they were addressing.

-- R;

