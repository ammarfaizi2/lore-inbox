Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264928AbTLWEOt (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Dec 2003 23:14:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264937AbTLWEOt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Dec 2003 23:14:49 -0500
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:45323 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP id S264928AbTLWEOs
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Dec 2003 23:14:48 -0500
Date: Mon, 22 Dec 2003 23:03:05 -0500 (EST)
From: Bill Davidsen <davidsen@tmr.com>
To: Andre Tomt <lkml@tomt.net>
cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.0 modules don't link properly
In-Reply-To: <1072136923.1088.249.camel@slurv.pasop.tomt.net>
Message-ID: <Pine.LNX.3.96.1031222225919.10205A-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 23 Dec 2003, Andre Tomt wrote:

> On Tue, 2003-12-23 at 00:17, bill davidsen wrote:
> > I tried building 2.6.0-final on a new whitebox-3.0-final install, and
> > the modules_install produced thousands of unresolved symbols. This built
> > on another machine I've been running and updating since the 2.5.3x days,
> > so there might be something I've missed, but I don't quite see what it
> > would be.
> > 
> > Whitebox is built from RH-ES-3.0 source, so the only things I updated
> > were the procps and modutils, using the last tar which didn't have "pre"
> > in the name. I see that there is a new tar, out nearly ten hours so it
> > must be stable, which has jumped from 0.9.15 to 3.0.15-pre1, but I'm
> > happily using something months old on other systems.
> > 
> > Can someone toss me a clue? Has anyone had a working build with
> > RH-ES-3.0? Yes, I know other things need to be done before I can
> > actually run the kernel, but being able to build would be nice, since I
> > got a new test system just for 2.6 test/demo use.
> 
> Sounds like a case of missing module-init-tools.

As noted, 0.9.15 was the latest available when I build, Rusty didn't
suggest needing anything newer, and other systems work with far older
versions.

A new "fixed" release of the O/S came out over the weekend, so I will try
doing the install all over again. Seems odd, may be a library or
something.

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

