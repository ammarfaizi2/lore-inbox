Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265311AbUAYWEO (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Jan 2004 17:04:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265288AbUAYWEO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Jan 2004 17:04:14 -0500
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:50139 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S265310AbUAYWDd
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Jan 2004 17:03:33 -0500
Date: Sun, 25 Jan 2004 23:03:20 +0100 (CET)
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: Andi Kleen <ak@muc.de>
cc: Fabio Coatti <cova@ferrara.linux.it>, Andrew Morton <akpm@osdl.org>,
       bunk@fs.tum.de, eric@cisu.net, linux-kernel@vger.kernel.org
Subject: Re: [patch] Re: Kernels > 2.6.1-mm3 do not boot. - SOLVED
In-Reply-To: <20040125214653.GB28576@colin2.muc.de>
Message-ID: <Pine.GSO.4.58.0401252259411.22132@mion.elka.pw.edu.pl>
References: <200401232253.08552.eric@cisu.net> <20040125174837.GB16962@colin2.muc.de>
 <20040125131153.16bb662b.akpm@osdl.org> <200401252221.01679.cova@ferrara.linux.it>
 <20040125214653.GB28576@colin2.muc.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sun, 25 Jan 2004, Andi Kleen wrote:

> On Sun, Jan 25, 2004 at 10:21:01PM +0100, Fabio Coatti wrote:
> > Alle Sunday 25 January 2004 22:11, Andrew Morton ha scritto:
> >
> > > >
> > > > I disagree with that change.
> > >
> > > Well there doesn't seem much doubt that -funit-at-a-time causes Fabio's
> > > kernel to fail.  Do we know exactly which compiler he is using?
> >
> > Well,  I'm using gcc (GCC) 3.3.1 (Mandrake Linux 9.2 3.3.1-2mdk), provided
> > with Mandrake 9.2. If more details about configuration are needed please let
> > me know.
>
> Let's take this from the start:
>
> what kernel version are you running exactly?
> what oops are you seeing?
> does official 2.6.2rc1 (not mm) with -funit-at-a-time enabled in the Makefile
> work?

I remember trying 2.6.1-mm4 + your sort extable patch (i386 specific
version) on Mandrake 9.2 -> no boot.  Removing -funit-at-a-time cured
problem.  I didn't have time to investigate it more (like trying
patched vanilla).  Just FYI.

--bart
