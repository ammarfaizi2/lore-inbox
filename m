Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263228AbUA3SwM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jan 2004 13:52:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263435AbUA3SwM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jan 2004 13:52:12 -0500
Received: from 81-2-122-30.bradfords.org.uk ([81.2.122.30]:19328 "EHLO
	81-2-122-30.bradfords.org.uk") by vger.kernel.org with ESMTP
	id S263228AbUA3SwK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jan 2004 13:52:10 -0500
Date: Fri, 30 Jan 2004 19:01:00 GMT
From: John Bradford <john@grabjohn.com>
Message-Id: <200401301901.i0UJ10xV000340@81-2-122-30.bradfords.org.uk>
To: Timothy Miller <miller@techsource.com>,
       Helge Hafting <helgehaf@aitel.hist.no>
Cc: John Bradford <john@grabjohn.com>, chakkerz@optusnet.com.au,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <401A8E0E.6090004@techsource.com>
References: <4017F2C0.4020001@techsource.com>
 <200401291211.05461.chakkerz@optusnet.com.au>
 <40193136.4070607@techsource.com>
 <200401291629.i0TGTN7S001406@81-2-122-30.bradfords.org.uk>
 <40193A67.7080308@techsource.com>
 <200401291718.i0THIgbb001691@81-2-122-30.bradfords.org.uk>
 <4019472D.70604@techsource.com>
 <200401291855.i0TItHoU001867@81-2-122-30.bradfords.org.uk>
 <40195AE0.2010006@techsource.com>
 <401A33CA.4050104@aitel.hist.no>
 <401A8E0E.6090004@techsource.com>
Subject: Re: [OT] Crazy idea:  Design open-source graphics chip
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> A BIOS ROM doesn't help you if you don't have a VGA core, and a VGA core 
> is not a trivial piece of logic.

We don't need a VGA core.

The primary markets for this card are going to be developers who don't
care about using a standard VGA card for pre-kernel-loaded stuff, the
embedded and server markets, where they can simply write a new system
BIOS that emulates 80x25 text mode on the framebuffer, and the
multi-head market, where the kernel or X will be responsible for the
extra heads anyway.

Once the kernel or X has taken over the framebuffer, there is
certainly no need for a VGA core.

As far as I am concerned, the first version of this card is going to
be more or less an expensive proof-of-concept thing.  It _will_ cost
more than a brand new off-the-shelf VGA card, and it _will_ cost more
than a second-hand VGA card with documented registers.  That doesn't
mean it isn't worth doing, though.

John.
