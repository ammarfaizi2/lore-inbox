Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262920AbVA2Oy2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262920AbVA2Oy2 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Jan 2005 09:54:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262813AbVA2Oy2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Jan 2005 09:54:28 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:36104 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S262920AbVA2OyX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Jan 2005 09:54:23 -0500
Date: Sat, 29 Jan 2005 14:54:17 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Christoph Hellwig <hch@infradead.org>,
       Pierre Ossman <drzeus-list@drzeus.cx>,
       Geert Uytterhoeven <geert@linux-m68k.org>,
       LKML <linux-kernel@vger.kernel.org>, wbsd-devel@list.drzeus.cx
Subject: Re: [Wbsd-devel] [PATCH 540] MMC_WBSD depends on ISA
Message-ID: <20050129145417.A12311@flint.arm.linux.org.uk>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Pierre Ossman <drzeus-list@drzeus.cx>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	LKML <linux-kernel@vger.kernel.org>, wbsd-devel@list.drzeus.cx
References: <200501072250.j07MonUe012310@anakin.of.borg> <41E22B4F.4090402@drzeus.cx> <41FB91A3.7060404@drzeus.cx> <20050129135714.GA320@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20050129135714.GA320@infradead.org>; from hch@infradead.org on Sat, Jan 29, 2005 at 01:57:14PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph, did you mean to add anything?

On Sat, Jan 29, 2005 at 01:57:14PM +0000, Christoph Hellwig wrote:
> On Sat, Jan 29, 2005 at 02:37:39PM +0100, Pierre Ossman wrote:
> > Pierre Ossman wrote:
> > >Geert Uytterhoeven wrote:
> > >
> > >>MMC_WBSD depends on ISA (needs isa_virt_to_bus())
> > >>
> > >>
> > >
> > >Thanks. Shouldn't have missed something so obvious :)
> > >
> > >Russell, can you fix this in your next merge?
> > >
> > 
> > Russell, please undo this patch. isa_virt_to_bus() is not dependent on 
> > CONFIG_ISA. It causes problems on x86_64 platforms which cannot enable 
> > ISA support.
> > 
> > Rgds
> > Pierre
> > -
> > To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > Please read the FAQ at  http://www.tux.org/lkml/
> ---end quoted text---

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core
