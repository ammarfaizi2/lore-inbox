Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266603AbUBLVwP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Feb 2004 16:52:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266613AbUBLVwP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Feb 2004 16:52:15 -0500
Received: from h24-76-142-122.wp.shawcable.net ([24.76.142.122]:2567 "HELO
	signalmarketing.com") by vger.kernel.org with SMTP id S266603AbUBLVwM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Feb 2004 16:52:12 -0500
Date: Thu, 12 Feb 2004 15:52:13 -0600 (CST)
From: Derek Foreman <manmower@signalmarketing.com>
To: Jesse Allen <the3dfxdude@hotmail.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.6, 2.4, Nforce2, Experimental idle halt workaround
 instead of apic ack delay.
In-Reply-To: <20040212214407.GA865@tesore.local>
Message-ID: <Pine.LNX.4.58.0402121544470.962@gonopodium.signalmarketing.com>
References: <200402120122.06362.ross@datscreative.com.au>
 <Pine.LNX.4.58.0402121118490.515@gonopodium.signalmarketing.com>
 <20040212214407.GA865@tesore.local>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 12 Feb 2004, Jesse Allen wrote:

> On Thu, Feb 12, 2004 at 12:17:12PM -0600, Derek Foreman wrote:
> > Some nforce2 systems work just fine.  Is there a way to distinguish
> > between systems that need it and those that don't?
> >
>
> Some nforce2 systems are fixed in certain bioses.  The problem is we
> don't know where/what it is in the bios.  C1 disconnect is a clue.

So a machine that locks up with stop grant enabled under one bios
revision might run just fine with stop grant enabled on another?

> > (if anyone's running a betting pool, my money's on nforce2+cpu with half
> > frequency multiplier ;)
>
> I don't know what your talking about.  My Shuttle AN35N nforce2 board
> can run vanilla kernels with the 12-5-2003 dated bios version and not
> lock up.  The frequencies I run are all the default/standard ones.

Some old (model 4, I think) athlons had a problem with disconnect, but
only in the half multiplier versions.

Carlos' athlon has a 12.5 multiplier, so my theory's bogus
