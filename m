Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261908AbTCJXHZ>; Mon, 10 Mar 2003 18:07:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261928AbTCJXHY>; Mon, 10 Mar 2003 18:07:24 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:2321 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S261908AbTCJXHX>; Mon, 10 Mar 2003 18:07:23 -0500
Date: Tue, 11 Mar 2003 00:18:04 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Matthew Wilcox <willy@debian.org>
Cc: linux-kernel@vger.kernel.org, parisc-linux@parisc-linux.org
Subject: Re: ioctl32 cleanup -- rest of architectures
Message-ID: <20030310231804.GB8555@atrey.karlin.mff.cuni.cz>
References: <20030310172832.GG5278@parcelfarce.linux.theplanet.co.uk> <20030310185647.GA11310@atrey.karlin.mff.cuni.cz> <20030310195610.GJ5278@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030310195610.GJ5278@parcelfarce.linux.theplanet.co.uk>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > So I should take arch/parisc/kernel/syscall.S and change
> > ENTRY_DIFF(ioctl) into ENTRY_COMP(ioctl)? Great, thanx.
> 
> Exactly.

Thanx, applied, will do "silly name fix" when I get x86-64 back into
working state. [i2c support broke.]
								Pavel
-- 
Horseback riding is like software...
...vgf orggre jura vgf serr.
