Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261763AbUKIXYg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261763AbUKIXYg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Nov 2004 18:24:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261764AbUKIXYf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Nov 2004 18:24:35 -0500
Received: from waste.org ([209.173.204.2]:28129 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S261763AbUKIXYU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Nov 2004 18:24:20 -0500
Date: Tue, 9 Nov 2004 15:24:02 -0800
From: Matt Mackall <mpm@selenic.com>
To: Grzegorz Kulewski <kangur@polcom.net>
Cc: Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] change Kconfig entry for RAMFS
Message-ID: <20041109232402.GA8040@waste.org>
References: <Pine.LNX.4.58.0411041544220.2187@ppc970.osdl.org> <20041105014146.GA7397@pclin040.win.tue.nl> <Pine.LNX.4.58.0411050739190.2187@ppc970.osdl.org> <20041105195045.GA16766@taniwha.stupidest.org> <Pine.LNX.4.58.0411051203470.2223@ppc970.osdl.org> <Pine.LNX.4.60.0411052242090.3255@alpha.polcom.net> <Pine.LNX.4.58.0411051406200.2223@ppc970.osdl.org> <Pine.LNX.4.60.0411052319160.3255@alpha.polcom.net> <Pine.LNX.4.58.0411051506590.2223@ppc970.osdl.org> <Pine.LNX.4.60.0411060027560.3255@alpha.polcom.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.60.0411060027560.3255@alpha.polcom.net>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 06, 2004 at 12:44:14AM +0100, Grzegorz Kulewski wrote:
> >So at the very least you'd need to make the Kconfig understand the
> >dependency on ramfs.
> 
> Should I add dependency to tmpfs on ramfs when building for embedded? Or 
> should I introduce new config option to stop registering ramfs as a 
> mountable filesystem?

Root is ramfs at early boot time, making it optional is tricky.

-- 
Mathematics is the supreme nostalgia of our time.
