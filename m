Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264273AbTLERGA (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Dec 2003 12:06:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264286AbTLERF7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Dec 2003 12:05:59 -0500
Received: from vir1.relay.fluke.com ([129.196.184.25]:354 "EHLO
	vir1.relay.fluke.com") by vger.kernel.org with ESMTP
	id S264273AbTLERFv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Dec 2003 12:05:51 -0500
Date: Fri, 5 Dec 2003 09:05:51 -0800 (PST)
From: David Dyck <david.dyck@fluke.com>
To: Jesse Pollard <jesse@cats-chateau.net>
cc: David Schwartz <davids@webmaster.com>, linux-kernel@vger.kernel.org
Subject: Re: Linux GPL and binary module exception clause?
In-Reply-To: <732BE51FE9901143AE04411A11CC465602F155F3@evtexc02.tc.fluke.com>
Message-ID: <Pine.LNX.4.51.0312050824270.9496@dd.tc.fluke.com>
References: <732BE51FE9901143AE04411A11CC465602F155F3@evtexc02.tc.fluke.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 05 Dec 2003 17:05:50.0492 (UTC) FILETIME=[08BE7DC0:01C3BB52]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 5 Dec 2003 at 07:06 -0800, Jesse Pollard <jesse@cats-chateau.net>
wrote:

> Quite simple. If you include the Linux kernel include files you get a derived
> program that must be released under GPL if you distribute that program.

When I first read this out out of context, I wondered if you were saying
that any executable that I write on my libc5 linux system (and those that
were compiled on libc5 systems long ago - like my copy of Adobe acrobat,
and RealNetworks real audio) must have been distributed under GPL?

    [ Please recall that the kernel header files were included in users
    programs (since /usr/include/asm and /usr/include/linux were symlinks
    into the kernel sources) and common include files like dirent.h,
    errno.h, and signal.h.  This still works with libc5 and todays
    Linux 2.4.23. ]

You must not be saying that, since Linus said:

    "There's a clarification that user-space programs that use the standard
    system call interfaces aren't considered derived works, but even that
    isn't an "exception" - it's just a statement of a border of what is
    clearly considered a "derived work". User programs are _clearly_
    not derived works of the kernel, and as such whatever the kernel
    license is just doesn't matter."

And after re-reading more of the thread, you must be refering to modules
that include kernel include files, right?

 David

