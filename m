Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267807AbUHUUj7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267807AbUHUUj7 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Aug 2004 16:39:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267812AbUHUUj7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Aug 2004 16:39:59 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:38101 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S267807AbUHUUjy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Aug 2004 16:39:54 -0400
Date: Wed, 18 Aug 2004 15:53:15 +0200
From: Pavel Machek <pavel@suse.cz>
To: Michael Clark <michael@metaparadigm.com>
Cc: jeremy@goop.org, davej@codemonkey.org.uk,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] - Initial dothan speedstep support
Message-ID: <20040818135314.GJ467@openzaurus.ucw.cz>
References: <41131120.5060202@metaparadigm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41131120.5060202@metaparadigm.com>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> So here's a patch on top of the above patch that adds all of the
> dothan frequency/voltages for processors 715, 725, 735, 745, 755
> 
> Tested and working as it should so far with a 745. The stepping in the
> model table for the others may need to be tweaked.
> 
> The Dothan processor datasheet 30218903.pdf defines 4 voltages for
> each frequency (VID#A through VID#D) whereas Banias only suggests a
> typical voltage and no min or max for each freq so i've used the OP
> macro to allow definition of all voltages (A through D) but the macro
> currently just uses VID#C at compile time (the second lowest voltage
> profile).

I thought that whether to use VID#A, B, C or D depends on
your concrete chip? Not all chips are certified to run on VID#C...
				Pavel
-- 
64 bytes from 195.113.31.123: icmp_seq=28 ttl=51 time=448769.1 ms         

