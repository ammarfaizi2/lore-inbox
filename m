Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265239AbTFVN5a (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Jun 2003 09:57:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265402AbTFVN53
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Jun 2003 09:57:29 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:53256 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S265239AbTFVN52 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Jun 2003 09:57:28 -0400
Date: Fri, 20 Jun 2003 23:25:12 +0200
From: Pavel Machek <pavel@suse.cz>
To: Florian-Daniel Otel <otel@ce.chalmers.se>
Cc: EricAltendorf@orst.edu,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       swsusp-devel@lists.sourceforge.net
Subject: Re: [Swsusp-devel] Re: RTC causes hard lockups in 2.5.70-mm8
Message-ID: <20030620212512.GG1261@zaurus.ucw.cz>
References: <Pine.LNX.4.55L-032.0306122205210.4915@unix48.andrew.cmu.edu> <1055492730.5162.0.camel@dhcp22.swansea.linux.org.uk> <200306171232.27887.EricAltendorf@orst.edu> <200306190031.54686.EricAltendorf@orst.edu> <16113.30505.519963.233275@solen.ce.chalmers.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <16113.30505.519963.233275@solen.ce.chalmers.se>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> On less extatic but more useful note: It seems that if I start the
> suspending process by hand (i.e. swsusp utility) while PCMCIA and USBs
> are stopped but __not__ networking, the resume process freezes. I can
> use SysRq+T at this point, but since this is a "legacy free" laptop, I

I guess you need to write suspend/resume
support for your network card...
				Pavel
-- 
				Pavel
Written on sharp zaurus, because my Velo1 broke. If you have Velo you don't need...

