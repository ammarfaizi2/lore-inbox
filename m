Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262891AbVA2PRA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262891AbVA2PRA (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Jan 2005 10:17:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262927AbVA2PRA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Jan 2005 10:17:00 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:41096 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S262891AbVA2PQ7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Jan 2005 10:16:59 -0500
Date: Sat, 29 Jan 2005 15:16:56 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Christoph Hellwig <hch@infradead.org>,
       Pierre Ossman <drzeus-list@drzeus.cx>,
       Geert Uytterhoeven <geert@linux-m68k.org>,
       LKML <linux-kernel@vger.kernel.org>, wbsd-devel@list.drzeus.cx
Subject: Re: [Wbsd-devel] [PATCH 540] MMC_WBSD depends on ISA
Message-ID: <20050129151656.GA1104@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Pierre Ossman <drzeus-list@drzeus.cx>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	LKML <linux-kernel@vger.kernel.org>, wbsd-devel@list.drzeus.cx
References: <200501072250.j07MonUe012310@anakin.of.borg> <41E22B4F.4090402@drzeus.cx> <41FB91A3.7060404@drzeus.cx> <20050129135714.GA320@infradead.org> <20050129145417.A12311@flint.arm.linux.org.uk> <20050129150023.GA959@infradead.org> <20050129151346.B12311@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050129151346.B12311@flint.arm.linux.org.uk>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 29, 2005 at 03:13:46PM +0000, Russell King wrote:
> One thing which comes up in this instance is: what struct device should
> be used.

Current convention is to use a NULL device, it's from pre-generic
DMA times were only the pci_* types existed.

