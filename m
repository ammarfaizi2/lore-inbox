Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262914AbVA2N6a@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262914AbVA2N6a (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Jan 2005 08:58:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262911AbVA2N6a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Jan 2005 08:58:30 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:52103 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S262914AbVA2N5X (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Jan 2005 08:57:23 -0500
Date: Sat, 29 Jan 2005 13:57:14 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Pierre Ossman <drzeus-list@drzeus.cx>
Cc: Russell King <rmk+lkml@arm.linux.org.uk>,
       Geert Uytterhoeven <geert@linux-m68k.org>,
       LKML <linux-kernel@vger.kernel.org>, wbsd-devel@list.drzeus.cx
Subject: Re: [Wbsd-devel] [PATCH 540] MMC_WBSD depends on ISA
Message-ID: <20050129135714.GA320@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Pierre Ossman <drzeus-list@drzeus.cx>,
	Russell King <rmk+lkml@arm.linux.org.uk>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	LKML <linux-kernel@vger.kernel.org>, wbsd-devel@list.drzeus.cx
References: <200501072250.j07MonUe012310@anakin.of.borg> <41E22B4F.4090402@drzeus.cx> <41FB91A3.7060404@drzeus.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41FB91A3.7060404@drzeus.cx>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 29, 2005 at 02:37:39PM +0100, Pierre Ossman wrote:
> Pierre Ossman wrote:
> >Geert Uytterhoeven wrote:
> >
> >>MMC_WBSD depends on ISA (needs isa_virt_to_bus())
> >>
> >>
> >
> >Thanks. Shouldn't have missed something so obvious :)
> >
> >Russell, can you fix this in your next merge?
> >
> 
> Russell, please undo this patch. isa_virt_to_bus() is not dependent on 
> CONFIG_ISA. It causes problems on x86_64 platforms which cannot enable 
> ISA support.
> 
> Rgds
> Pierre
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
---end quoted text---
