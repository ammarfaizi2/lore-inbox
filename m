Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265743AbTFNU4G (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Jun 2003 16:56:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265746AbTFNU4F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Jun 2003 16:56:05 -0400
Received: from adsl-63-198-182-124.dsl.snfc21.pacbell.net ([63.198.182.124]:58263
	"EHLO celine.comarre.com") by vger.kernel.org with ESMTP
	id S265743AbTFNU4A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Jun 2003 16:56:00 -0400
Message-Id: <5.1.0.14.1.20030614140335.01fc2260@celine>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Sat, 14 Jun 2003 14:10:12 -0700
To: <linux-kernel@vger.kernel.org>
From: Ray Olszewski <ray@comarre.com>
Subject: RE: reading links in proc - permission denied
In-Reply-To: <000b01c332b7$44c68250$1403a8c0@sc.tlinx.org>
References: <200306141905.h5EJ57mE024740@leija.fmi.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I am unclear what purpose the long rant about "[p]erfect capitalistic 
system" handling of software bugs has to do with an operating system and 
applications that most of  get for free, so I'll skip that part.

What governs access to a file is ownership and permissions on the file 
itself, not on symlinks to it (which are customarily lrwxrwxrwx on Linux 
filesystems). This is not mysterious. It's just old-hat Unix.

At 01:55 PM 6/14/2003 -0700, linda w. wrote:


> > -----Original Message-----
> > From: hurtta@leija.mh.fmi.fi [mailto:hurtta@leija.mh.fmi.fi]
> > Are you sure that 'top' uses that 'exe' ?
>---
>         Not at all...in fact was told it doesn't.  Apparently, though,
>the listed permissions on the links are arbitrary and the system
>fairly well ignores them.
>
>         I vaguely remember someone once saying that even if a symlink
>had permissions lrxw------, it could still be used by group and
>others.  I don't know if that was or is still true -- certainly doesn't
>seem consistent, but when dealing with computer systems made by
>many different humans, inconsistency seems inevitable -- even when
>made by 1 human, that person can be inconsistent over time.
>
>         And people wonder why computer security is so hard to 'get right'.
[rest deleted]


