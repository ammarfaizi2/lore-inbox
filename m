Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270155AbRIEDap>; Tue, 4 Sep 2001 23:30:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270168AbRIEDaf>; Tue, 4 Sep 2001 23:30:35 -0400
Received: from mail.webmaster.com ([216.152.64.131]:39316 "EHLO
	shell.webmaster.com") by vger.kernel.org with ESMTP
	id <S270155AbRIEDaX>; Tue, 4 Sep 2001 23:30:23 -0400
From: "David Schwartz" <davids@webmaster.com>
To: "Keith Owens" <kaos@ocs.com.au>, "Andrea Arcangeli" <andrea@suse.de>
Cc: <linux-kernel@vger.kernel.org>
Subject: RE: Linux 2.4.9-ac6 
Date: Tue, 4 Sep 2001 20:30:42 -0700
Message-ID: <NOEJJDACGOHCKNCOGFOMAEAPDLAA.davids@webmaster.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2911.0)
In-Reply-To: <16601.999654671@kao2.melbourne.sgi.com>
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> On Mon, 3 Sep 2001 15:05:29 +0200,
> Andrea Arcangeli <andrea@suse.de> wrote:

> The next version of insmod will warn about modules with no
> MODULE_LICENSE at all and inform about modules with proprietary
> licences.  Both cases will mark the kenrel as tainted which will show
> up on bug reports.

	That really doesn't make sense. Nothing changes in the kernel or the module
based upon whether you have the source or not. What should logically taint
the kernel are modules that weren't compiled for that exact kernel version
or are otherwise mismatched.

	One can make the argument that the kernel is tainted if a module wasn't
compiled on that machine with that kernel version. One can make the argument
that the kernel is tainted if the module was compiled against different
configuration or header files. Once can make the argument that the kernel is
tainted if a module is loaded whose source isn't part of the general Linux
distribution. One can make all sorts of logical arguments about what taints
the kernel, but how can the license of a module taint the kernel?

	You can't even argue that if it's GPL, anyone can get the source to debug
it. The GPL does not require that the source code be made available to the
general public. Perhaps the kernel is tainted if that module wasn't built
from source on that machine?

	What's the logic here?!

	DS

