Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264138AbUECXAn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264138AbUECXAn (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 May 2004 19:00:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264147AbUECXAn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 May 2004 19:00:43 -0400
Received: from gprs214-205.eurotel.cz ([160.218.214.205]:9345 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S264138AbUECXAk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 May 2004 19:00:40 -0400
Date: Tue, 4 May 2004 01:00:31 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] 1/4 MMC layer
Message-ID: <20040503230031.GB19819@elf.ucw.cz>
References: <20040429134824.C16407@flint.arm.linux.org.uk> <20040502155226.B17905@flint.arm.linux.org.uk> <20040503134744.GD1188@openzaurus.ucw.cz> <20040503234710.B25413@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040503234710.B25413@flint.arm.linux.org.uk>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > As there haven't been any comments, can I assume that either people
> > > don't care, or people are happy for this to appear in Linus' tree?
> > 
> > Happy. i386 nx5k notebook contains mmc slot, and I assume
> > this will help me with a driver.
> 
> That depends on the kind of hardware interface you have - whether it
> gives you low level access to the MMC command/data streams, or whether
> it looks like a USB device / CF disk / whatever else.  (I've heard
> rumours that such games are played on laptops, but I've no idea how
> true this is.)

Its not USB disk, and it does not look like any device I recognize, so
I'm afraid your layer may be usefull. Interface is "TI PCI7420,
PCI7620 flash media controller", and there's datasheet on the web, but
I was not able to figure out how to control it.
								Pavel
-- 
934a471f20d6580d5aad759bf0d97ddc
