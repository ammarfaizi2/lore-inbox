Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750760AbVLYAex@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750760AbVLYAex (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 Dec 2005 19:34:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750762AbVLYAex
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 Dec 2005 19:34:53 -0500
Received: from gate.crashing.org ([63.228.1.57]:10691 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S1750760AbVLYAex (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 Dec 2005 19:34:53 -0500
Subject: Re: PowerBook5,8 - TrackPad update
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Pavel Machek <pavel@ucw.cz>
Cc: Michael Hanselmann <linux-kernel@hansmi.ch>,
       Stelian Pop <stelian@popies.net>,
       Parag Warudkar <kernel-stuff@comcast.net>,
       debian-powerpc@lists.debian.org,
       linux-kernel <linux-kernel@vger.kernel.org>, linuxppc-dev@ozlabs.org,
       johannes@sipsolutions.net
In-Reply-To: <20051224231928.GC2183@elf.ucw.cz>
References: <111520052143.16540.437A5680000BE8A60000409C220076369200009A9B9CD3040A029D0A05@comcast.net>
	 <70210ED5-37CA-40BC-8293-FF1DAA3E8BD5@comcast.net>
	 <20051129000615.GA20843@hansmi.ch> <20051130223917.GA15102@hansmi.ch>
	 <20051130234653.GB15102@hansmi.ch>
	 <1133533712.23129.25.camel@localhost.localdomain>
	 <20051204224221.GA28218@hansmi.ch> <1135382385.4542.8.camel@gaston>
	 <20051224201753.GA26801@elf.ucw.cz>
	 <1135463271.5611.3.camel@localhost.localdomain>
	 <20051224231928.GC2183@elf.ucw.cz>
Content-Type: text/plain
Date: Sun, 25 Dec 2005 11:33:20 +1100
Message-Id: <1135470801.6387.1.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> It should be doable once in gpm, all other apps can use gpm's repeater
> mode...
> 
> > When it's in raw mode for use by the synaptics X driver, if course, it's
> > expected that those things are to be done by that driver.
> 
> ...but you are right, doing it in /dev/input/mice emulation layer
> makes some sense. OTOH I thought we were moving away from
> /dev/input/mice... Its Dmitry's call I guess.

Heh, yes, it is. No hurry anyway, I finally got synaptics working
properly in X ...

Why would we move away from the mouse mux ? It's proven to be very
useful to me at least :)

Ben

