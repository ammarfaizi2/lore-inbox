Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750746AbVKJKCn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750746AbVKJKCn (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Nov 2005 05:02:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750747AbVKJKCn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Nov 2005 05:02:43 -0500
Received: from baythorne.infradead.org ([81.187.2.161]:15782 "EHLO
	baythorne.infradead.org") by vger.kernel.org with ESMTP
	id S1750746AbVKJKCn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Nov 2005 05:02:43 -0500
Subject: Re: latest mtd changes broke collie
From: David Woodhouse <dwmw2@infradead.org>
To: Pavel Machek <pavel@ucw.cz>
Cc: Todd Poynor <tpoynor@mvista.com>, rpurdie@rpsys.net, lenz@cs.wisc.edu,
       kernel list <linux-kernel@vger.kernel.org>,
       Russell King <rmk@arm.linux.org.uk>, Andrew Morton <akpm@osdl.org>
In-Reply-To: <20051110095050.GC2021@elf.ucw.cz>
References: <20051109221712.GA28385@elf.ucw.cz>
	 <4372B7A8.5060904@mvista.com>  <20051110095050.GC2021@elf.ucw.cz>
Content-Type: text/plain
Date: Thu, 10 Nov 2005 10:02:28 +0000
Message-Id: <1131616948.27347.174.camel@baythorne.infradead.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by baythorne.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-11-10 at 10:50 +0100, Pavel Machek wrote:
> Is there easy way to get at linux-mtd CVS? Attached is my current
> version of sharp.c; map_read32/map_write32 was deleted thanks to
> Richard Purdue.

http://www.linux-mtd.infradead.org/source.html has a reference to
anoncvs.

I'd really prefer not to see sharp.c revived -- it's supposed to be
dying, in favour of the CFI chipset drivers and jedec_probe code.
Can we try to work out what's wrong with those, instead?

-- 
dwmw2


