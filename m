Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280707AbRKYE1d>; Sat, 24 Nov 2001 23:27:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280717AbRKYE1X>; Sat, 24 Nov 2001 23:27:23 -0500
Received: from dsl-65-186-161-49.telocity.com ([65.186.161.49]:13062 "EHLO
	nic.osagesoftware.com") by vger.kernel.org with ESMTP
	id <S280707AbRKYE1R>; Sat, 24 Nov 2001 23:27:17 -0500
Message-Id: <4.3.2.7.2.20011124231412.00b40c50@mail.osagesoftware.com>
X-Mailer: QUALCOMM Windows Eudora Version 4.3.2
Date: Sat, 24 Nov 2001 23:27:14 -0500
To: linux-kernel@vger.kernel.org
From: David Relson <relson@osagesoftware.com>
Subject: Kernel Releases
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greetings to All,

Over the past few months, I've been listening in on LKML, with occasional, 
minor comments - mostly to help newbies.  Now, I think it's time for a 
suggestion ...

As we all know, several of the recent releases have had defects that have 
__required__ patches before they could be built (or used safely).  Problems 
with symlinks, loopbacks, and unmount come to mind as being like 
this.  They are all show stoppers that required immediate fixes and the 
creation of a new release or of the next -pre1 version.

I have a tendency to tink that it's better to be running a released kernel, 
than a pre-release kernel.  I'd much rather be running a kernel named 2.4.x 
than a kernel named 2.4.y-pre?.  With the recent problems, the working 
versions tend to be the -pre1 or -pre2 releases, not the released 
one.  With a bit of QA, I think we can have 2.4.x releases be the stable 
releases.  Here's how...

When the kernel maintainer, now Marcelo for 2.4, is ready to release the 
next kernel, for example 2.4.16, I suggest he switch from "pre?" to "-rc1" 
(as in release candidate).  A day or two with -rc1 will quickly show if it 
has a show stopper.  If so, then the minor fixes (and nothing else) go into 
-rc2.  A day or two ..., and either -rc3 appears or we have a stable 
release and 2.4.16 is ready to be released.

Let's go the extra distance and have the releases be usable, stable 
kernels!  It's what users want and it's within the abilities of the 
developers to produce.  Let's do it :-)

David



