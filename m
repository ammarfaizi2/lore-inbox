Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270703AbTGNOSJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Jul 2003 10:18:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270695AbTGNOPi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Jul 2003 10:15:38 -0400
Received: from genius.impure.org.uk ([195.82.120.210]:60642 "EHLO
	deviant.impure.org.uk") by vger.kernel.org with ESMTP
	id S270680AbTGNON6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Jul 2003 10:13:58 -0400
Date: Mon, 14 Jul 2003 15:28:38 +0100
From: Dave Jones <davej@codemonkey.org.uk>
To: Anders Gustafsson <andersg@0x63.nu>
Cc: torvalds@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] XBox Gaming System subarchitecture.
Message-ID: <20030714142838.GA29413@suse.de>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
	Anders Gustafsson <andersg@0x63.nu>, torvalds@osdl.org,
	linux-kernel@vger.kernel.org
References: <20030714124933.GB20708@h55p111.delphi.afb.lu.se> <20030714135948.GA27930@suse.de> <20030714142152.GC20708@h55p111.delphi.afb.lu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030714142152.GC20708@h55p111.delphi.afb.lu.se>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 14, 2003 at 04:21:52PM +0200, Anders Gustafsson wrote:
 > > Notably the gcc 'workaround' and the HZ ifdef maze.
 > 
 > Ooops, wrong patch. I have a labyrinth of bitkeeper-trees here, all looking
 > almost the same.
 > 
 > The real patch contains cleaned up HZ-ifdefs.

good good..

 > Regarding the gcc "workaround" I said:
 > "I don't really know how to make clear it's not a gcc problem. But if it was,
 >  why doesn't it crash on pc and 1.0 xboxen? And why does it crash on kernels
 >  compiled with 2.95, with or without optimization? I really wish I had the
 >  explaination to this problem."
 >  
 > Or as Christoph answered: "Oh well, stupid crappy hardware..."

That's a possibility, but if that were the case, I'd expect other things
also to start randomly failing. It's unclear to me how -O2 would make
a hardware bug more aparent. If it did so, that would also mean you'd
have to ensure all your userspace was similarly compiled, which sounds
very suspect.  It's just a celeron based PC with nvidia nforce chipset right ?
If that combination caused such problems, I'd expect to see the
occasional problem report from non-Xbox regular home-built PC users too.

Might be one worth picking over on the gcc lists if you can identify
which part gets miscompiled ?

Tried different versions of binutils too ?

		Dave

