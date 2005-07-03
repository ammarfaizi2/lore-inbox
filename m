Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262242AbVGFKJt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262242AbVGFKJt (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Jul 2005 06:09:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262174AbVGFKGI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Jul 2005 06:06:08 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:34264 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S262202AbVGFIMm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Jul 2005 04:12:42 -0400
Date: Sun, 3 Jul 2005 13:39:22 +0200
From: Pavel Machek <pavel@suse.cz>
To: Andi Kleen <ak@suse.de>
Cc: Pierre Ossman <drzeus-list@drzeus.cx>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] ISA DMA suspend for x86_64
Message-ID: <20050703113922.GA1667@elf.ucw.cz>
References: <42A3061C.7010604@drzeus.cx.suse.lists.linux.kernel> <42B1A08B.8080601@drzeus.cx.suse.lists.linux.kernel> <20050616170622.A1712@flint.arm.linux.org.uk.suse.lists.linux.kernel> <42C3A698.9020404@drzeus.cx.suse.lists.linux.kernel> <1120130926.6482.83.camel@localhost.localdomain.suse.lists.linux.kernel> <42C3E3A4.3090305@drzeus.cx.suse.lists.linux.kernel> <42C432BB.407@drzeus.cx.suse.lists.linux.kernel> <p73u0jeg5lg.fsf@verdi.suse.de> <42C6CF40.4040308@drzeus.cx> <20050702174055.GI21330@wotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050702174055.GI21330@wotan.suse.de>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > I used i8259.c as an example and it includes its suspend routines in all
> > cases. Also, the problem this patch solves is for suspend-to-ram, not
> > suspend-to-disk (i.e. software suspend).
> 
> Hmm, it would be better if that all was CONFIG_ able. But ok.

I'll intoduce CONFIG_SLEEP for this, and it is already okay to make it
conditional on CONFIG_PM.

								Pavel
-- 
teflon -- maybe it is a trademark, but it should not be.
