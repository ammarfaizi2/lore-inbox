Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263250AbTFXSHW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Jun 2003 14:07:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263176AbTFXSHL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Jun 2003 14:07:11 -0400
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:36369 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP id S262299AbTFXSEs
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Jun 2003 14:04:48 -0400
Date: Tue, 24 Jun 2003 14:12:20 -0400 (EDT)
From: Bill Davidsen <davidsen@tmr.com>
To: Helge Hafting <helgehaf@aitel.hist.no>
cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: O(1) scheduler & interactivity improvements
In-Reply-To: <20030623164743.GB1184@hh.idb.hist.no>
Message-ID: <Pine.LNX.3.96.1030624140933.6519A-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 23 Jun 2003, Helge Hafting wrote:

> On Mon, Jun 23, 2003 at 12:18:29PM +0200, Felipe Alfaro Solana wrote:

> > I don't consider compiling the kernel an interactive process as it's
> > done almost automatically without any user intervention. XMMS is not a
> > complete interactive application as it spends most of the time decoding
> > and playing sound.
> > 
> A kernel compile isn't interactive - sure.  It may get some boosts
> anyway for io waiting.  This quite correctly puts it above a
> pure cpu hog like a mandelbrot calculation.

Why? Not why does the scheduler do that, but why *should* a compile be in
any way more deserving that a Mandelbrot? It isn't obvious to me that
either are interacting with the user, and if they are it would be the
Mandelbrot doing realtime display.

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

