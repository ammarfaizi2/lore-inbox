Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261613AbVADNL2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261613AbVADNL2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Jan 2005 08:11:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261609AbVADNL2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Jan 2005 08:11:28 -0500
Received: from gprs214-115.eurotel.cz ([160.218.214.115]:31918 "EHLO
	amd.ucw.cz") by vger.kernel.org with ESMTP id S261613AbVADNKe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Jan 2005 08:10:34 -0500
Date: Tue, 4 Jan 2005 14:10:20 +0100
From: Pavel Machek <pavel@ucw.cz>
To: kernel list <linux-kernel@vger.kernel.org>,
       Linux-pm mailing list <linux-pm@lists.osdl.org>,
       Andrew Morton <akpm@zip.com.au>
Subject: Re: dm: introduce pm_message_t
Message-ID: <20050104131020.GC3981@elf.ucw.cz>
References: <20050104123938.GA13716@elf.ucw.cz> <20050104130515.B18550@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050104130515.B18550@flint.arm.linux.org.uk>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > +FREEZE -- stop DMA and interrupts, and be prepared to reinit HW from
> > +scratch. That probably means stop accepting upstream requests, the
> > +actual policy of what to do with them beeing specific to a given
> 
> busy busy bee.  I think you mean "being".

Fixed locally, thanks. I guess I can fix this one with followup patch
if it indeed gets merged.
								Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
