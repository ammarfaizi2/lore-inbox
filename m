Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262938AbVA2P5d@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262938AbVA2P5d (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Jan 2005 10:57:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262937AbVA2P5d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Jan 2005 10:57:33 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:8073 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S262934AbVA2P50 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Jan 2005 10:57:26 -0500
Date: Sat, 29 Jan 2005 15:57:22 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Pierre Ossman <drzeus-list@drzeus.cx>
Cc: Christoph Hellwig <hch@infradead.org>,
       Geert Uytterhoeven <geert@linux-m68k.org>,
       LKML <linux-kernel@vger.kernel.org>, wbsd-devel@list.drzeus.cx
Subject: Re: [Wbsd-devel] [PATCH 540] MMC_WBSD depends on ISA
Message-ID: <20050129155722.GA1320@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Pierre Ossman <drzeus-list@drzeus.cx>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	LKML <linux-kernel@vger.kernel.org>, wbsd-devel@list.drzeus.cx
References: <200501072250.j07MonUe012310@anakin.of.borg> <41E22B4F.4090402@drzeus.cx> <41FB91A3.7060404@drzeus.cx> <20050129135714.GA320@infradead.org> <20050129145417.A12311@flint.arm.linux.org.uk> <20050129150023.GA959@infradead.org> <41FBAC44.9020502@drzeus.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41FBAC44.9020502@drzeus.cx>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 29, 2005 at 04:31:16PM +0100, Pierre Ossman wrote:
> The problem was that the DMA API didn't work for x86_64 when I wrote the 
> driver. I see now that it has been fixed.
> isa_virt_to_bus still works even though CONFIG_ISA is not configured. So 

It may not exist at all.

