Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265375AbTIJR2s (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Sep 2003 13:28:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265379AbTIJR2s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Sep 2003 13:28:48 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:9951 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S265375AbTIJR2q
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Sep 2003 13:28:46 -0400
Date: Wed, 10 Sep 2003 18:28:42 +0100
From: Matthew Wilcox <willy@debian.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Matthew Wilcox <willy@debian.org>, Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>,
       Marc Zyngier <maz@wild-wind.fr.eu.org>, Ralf Baechle <ralf@gnu.org>,
       Richard Henderson <rth@twiddle.net>
Subject: Re: [PATCH] Move EISA_bus
Message-ID: <20030910172842.GB21596@parcelfarce.linux.theplanet.co.uk>
References: <20030909222937.GH18654@parcelfarce.linux.theplanet.co.uk> <Pine.GSO.4.21.0309101857560.1390-100000@vervain.sonytel.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.GSO.4.21.0309101857560.1390-100000@vervain.sonytel.be>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 10, 2003 at 06:58:25PM +0200, Geert Uytterhoeven wrote:
> On Tue, 9 Sep 2003, Matthew Wilcox wrote:
> > When I change the setting of CONFIG_EISA, everything rebuilds.  This is
> > because EISA_bus is declared in <asm/processor.h> which is implicitly
> > included by just about everything.  This is a silly place to declare it,
> > so this patch moves it to include/linux/eisa.h.
> 
> BTW, can't the same be done with MCA_bus?

Guess what patch is coming up next once Linus takes this patch?

-- 
"It's not Hollywood.  War is real, war is primarily not about defeat or
victory, it is about death.  I've seen thousands and thousands of dead bodies.
Do you think I want to have an academic debate on this subject?" -- Robert Fisk
