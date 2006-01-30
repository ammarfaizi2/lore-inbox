Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932206AbWA3Kpf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932206AbWA3Kpf (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Jan 2006 05:45:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932207AbWA3Kpf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Jan 2006 05:45:35 -0500
Received: from inutil.org ([193.22.164.111]:14545 "EHLO
	vserver151.vserver151.serverflex.de") by vger.kernel.org with ESMTP
	id S932206AbWA3Kpe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Jan 2006 05:45:34 -0500
Date: Mon, 30 Jan 2006 11:45:11 +0100
To: Pavel Machek <pavel@ucw.cz>
Cc: Moritz Muehlenhoff <jmm@inutil.org>, linux-kernel@vger.kernel.org
Subject: Re: Display corruption with radeonfb after resuming from suspend-to-ram
Message-ID: <20060130104511.GA9782@informatik.uni-bremen.de>
References: <20060128155237.GA4601@informatik.uni-bremen.de> <20060129153811.GE1764@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060129153811.GE1764@elf.ucw.cz>
User-Agent: Mutt/1.5.11
From: Moritz Muehlenhoff <jmm@inutil.org>
X-SA-Exim-Connect-IP: 134.102.116.14
X-SA-Exim-Mail-From: jmm@inutil.org
X-SA-Exim-Scanned: No (on vserver151.vserver151.serverflex.de); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek wrote:
> > Resuming from suspend-to-ram works flawless in roughly 98% of all cases, but
> > sometimes the display gets corrupted; some bits are set in the display in a
> > weird way and the display starts to shift with every line break. An
> > example:
> 
> Happens here, too... or happened, I think I have a solution. Reseting
> video card during resume seems like a way to go.
> 
> Could you get s2ram.c from www.sf.net/projects/suspend, and add your
> X31 with same parameters as X32 system, and let me know if it helps?
> 
> (You'll need an -mm kernel for parameter to be passed into kernel).

I'll do that, but it might take a few weeks until I can tell you wether
it worked, the bug only arises every few weeks.

Cheers,
        Moritz
