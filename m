Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932277AbVIYTaA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932277AbVIYTaA (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Sep 2005 15:30:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932279AbVIYTaA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Sep 2005 15:30:00 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:40685 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932277AbVIYTaA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Sep 2005 15:30:00 -0400
Date: Sun, 25 Sep 2005 20:29:58 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Pierre Ossman <drzeus@drzeus.cx>
Cc: rmk+lkml@arm.linux.co.uk, Pierre Ossman <drzeus-list@drzeus.cx>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [MMC] wbsd: use dma_alloc insted of kmalloc
Message-ID: <20050925192958.GA25848@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Pierre Ossman <drzeus@drzeus.cx>, rmk+lkml@arm.linux.co.uk,
	Pierre Ossman <drzeus-list@drzeus.cx>, linux-kernel@vger.kernel.org
References: <20050925191614.23944.2485.stgit@poseidon.drzeus.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050925191614.23944.2485.stgit@poseidon.drzeus.cx>
User-Agent: Mutt/1.4.2.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 25, 2005 at 09:16:23PM +0200, Pierre Ossman wrote:
> x86_64 doesn't seem to like being passed pointers allocated using
> kmalloc to the DMA mapping API.

How so?  There's not much else that could be passed to dma_map_single.

Please try to fix x86_64 instead.
