Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262888AbUA0Hxz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jan 2004 02:53:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262913AbUA0Hxz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jan 2004 02:53:55 -0500
Received: from gprs202-204.eurotel.cz ([160.218.202.204]:5248 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S262888AbUA0Hxy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jan 2004 02:53:54 -0500
Date: Tue, 27 Jan 2004 08:53:29 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Nigel Cunningham <ncunningham@users.sourceforge.net>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Hugang <hugang@soulinfo.com>,
       Patrick Mochel <mochel@digitalimplant.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linuxppc-dev list <linuxppc-dev@lists.linuxppc.org>
Subject: Re: pmdisk working on ppc (WAS: Help port swsusp to ppc)
Message-ID: <20040127075328.GA23678@elf.ucw.cz>
References: <1074534964.2505.6.camel@laptop-linux> <1074549790.10595.55.camel@gaston> <20040122211746.3ec1018c@localhost> <1074841973.974.217.camel@gaston> <20040123183030.02fd16d6@localhost> <1074912854.834.61.camel@gaston> <20040126181004.GB315@elf.ucw.cz> <1075154452.6191.91.camel@gaston> <20040126232148.GF310@elf.ucw.cz> <1075162365.18808.4.camel@laptop-linux>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1075162365.18808.4.camel@laptop-linux>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > Notice that swsusp needs half of physical memory free by design. That
> > means that we need _some_ freeing. Nigel's swsusp2 works around that
> > at cost of more complicated implementation.
> 
> Yes, my method is a bit more complicated.
> 
> Yours doesn't always need some freeing though - you only need to free
> memory until that 1/2 limitation is met. Last time I looked at it, it
> freed memory until it could free no more. Is that still true?

Yes. [It could be changed, but at that point I'd have to figure out
how much memory I really do need for write buffers, bio allocation,
etc.]

								Pavel
-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
