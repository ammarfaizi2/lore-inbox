Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1756537AbWKSKB0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756537AbWKSKB0 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Nov 2006 05:01:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756538AbWKSKB0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Nov 2006 05:01:26 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:25540 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1756537AbWKSKBZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Nov 2006 05:01:25 -0500
Subject: Re: [2.6 patch] mark pci_find_device() as __deprecated
From: Arjan van de Ven <arjan@infradead.org>
To: Muli Ben-Yehuda <muli@il.ibm.com>
Cc: Adrian Bunk <bunk@stusta.de>, Alan Cox <alan@redhat.com>,
       Andrew Morton <akpm@osdl.org>, gregkh@suse.de,
       linux-kernel@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz
In-Reply-To: <20061119095258.GK3735@rhun.zurich.ibm.com>
References: <20061114014125.dd315fff.akpm@osdl.org>
	 <20061117142145.GX31879@stusta.de>
	 <20061117143236.GA23210@devserv.devel.redhat.com>
	 <20061118000629.GW31879@stusta.de>
	 <1163929632.31358.481.camel@laptopd505.fenrus.org>
	 <20061119095258.GK3735@rhun.zurich.ibm.com>
Content-Type: text/plain
Organization: Intel International BV
Date: Sun, 19 Nov 2006 11:01:16 +0100
Message-Id: <1163930476.31358.483.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1.1 (2.8.1.1-3.fc6) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2006-11-19 at 11:52 +0200, Muli Ben-Yehuda wrote:
> On Sun, Nov 19, 2006 at 10:47:12AM +0100, Arjan van de Ven wrote:
> > 
> > > 
> > > Oh, and if anything starts complaining "But this adds some warnings to 
> > > my kernel build!", he should either first fix the 200 kB (sic) of 
> > > warnings I'm getting in 2.6.19-rc5-mm2 starting at MODPOST or go to hell.
> > 
> > we can solve this btw; we could have a
> > 
> > #define THIS_MODULE_IS_LEGACY_CRAP_AND_WONT_GET_FIXED
> > 
> > that would turn __deprecated into a nop for those few legacy modules
> > inside the kernel that nobody really is looking after.
> 
> If no one is looking after them, shouldn't they just be removed?


that's a whole different flamewar, esp if they sort of kinda mostly work
if the moon is aligned properly with Mars.


-- 
if you want to mail me at work (you don't), use arjan (at) linux.intel.com
Test the interaction between Linux and your BIOS via http://www.linuxfirmwarekit.org

