Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264844AbTCCMbJ>; Mon, 3 Mar 2003 07:31:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264830AbTCCMbJ>; Mon, 3 Mar 2003 07:31:09 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:16393 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S264844AbTCCMbH>; Mon, 3 Mar 2003 07:31:07 -0500
Date: Mon, 3 Mar 2003 13:41:33 +0100
From: Pavel Machek <pavel@suse.cz>
To: bert hubert <ahu@ds9a.nl>, Nigel Cunningham <ncunningham@clear.net.nz>,
       Roger Luethi <rl@hellgate.ch>,
       ACPI mailing list <acpi-devel@lists.sourceforge.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [ACPI] Re: S4bios support for 2.5.63
Message-ID: <20030303124133.GH20929@atrey.karlin.mff.cuni.cz>
References: <20030226211347.GA14903@elf.ucw.cz> <20030302133138.GA27031@outpost.ds9a.nl> <1046630641.3610.13.camel@laptop-linux.cunninghams> <20030302202118.GA2201@outpost.ds9a.nl> <20030303003940.GA13036@k3.hellgate.ch> <1046657290.8668.33.camel@laptop-linux.cunninghams> <20030303113153.GA18563@outpost.ds9a.nl> <20030303122325.GA20929@atrey.karlin.mff.cuni.cz> <20030303123551.GA19859@outpost.ds9a.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030303123551.GA19859@outpost.ds9a.nl>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> [ pruned mr Grover from the CC list ]
> 
> On Mon, Mar 03, 2003 at 01:23:25PM +0100, Pavel Machek wrote:
> > Well, it does not happen on my machines, but I've already seen it
> > happen on computer with two harddrives.
> 
> This is a laptop with only one. Anything I can do to help, let me know. Alan
> has suggested that an IDE transaction was still in progress, perhaps a small
> wait could prove/disprove this assumption?

Start adding printks to see whats going on. Try going ext2. Try
killing sys_sync() from kernel/suspend.c.

									Pavel
-- 
Horseback riding is like software...
...vgf orggre jura vgf serr.
