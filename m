Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263851AbUC3TKH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Mar 2004 14:10:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263853AbUC3TKH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Mar 2004 14:10:07 -0500
Received: from fed1mtao05.cox.net ([68.6.19.126]:35582 "EHLO
	fed1mtao05.cox.net") by vger.kernel.org with ESMTP id S263851AbUC3TKA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Mar 2004 14:10:00 -0500
Date: Tue, 30 Mar 2004 12:09:59 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Sven Hartge <hartge@ds9.gnuu.de>
Cc: Meelis Roos <mroos@linux.ee>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.5-pre* does not boot on my PReP PPC
Message-ID: <20040330190958.GA13819@smtp.west.cox.net>
References: <Pine.GSO.4.44.0403262029010.2460-100000@math.ut.ee> <20040326185103.GB20819@smtp.west.cox.net> <E1B7EHF-0004Jm-DY@ds9.argh.org> <20040329151515.GD2895@smtp.west.cox.net> <c4cf82nnq0@ds9.argh.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c4cf82nnq0@ds9.argh.org>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 30, 2004 at 08:49:15PM +0200, Sven Hartge wrote:

> Um 08:15 Uhr am 29.03.04 schrieb Tom Rini:
> 
> > Ok.  Can both of you try the following patch on top of the version which
> > fails?
> 
> 2.6.4 and earlier are unpatchable, because they differ to much from 2.6.5.
> Someone with a better connection than a tiny ISDN line should check the
> ppc32-changes between 2.6.2-rc2 and 2.6.4, because 2.6.2-rc2 was the last
> kernel I tried before 2.6.4 and 2.6.2-rc2 did at least boot.

I know what the failure is due to, in general terms.  It's merging
arch/ppc/boot/prep/ into arch/ppc/boot/simple/ .  What I'm not so sure
about are the specific breakage, but I know it has to do with the
OpenFirmware code as it does work (or rather, it did when I submitted
it, and I'm going to verify that 2.6.5-rc3 stock does today) on my
Motorola PowerStack Series E (PPC1Bug, not OpenFirmware).

-- 
Tom Rini
http://gate.crashing.org/~trini/
