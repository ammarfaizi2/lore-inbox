Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261832AbULGPGA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261832AbULGPGA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Dec 2004 10:06:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261829AbULGPDr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Dec 2004 10:03:47 -0500
Received: from [213.146.154.40] ([213.146.154.40]:27524 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S261830AbULGPDi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Dec 2004 10:03:38 -0500
Date: Tue, 7 Dec 2004 15:03:32 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Jason McMullan <jason.mcmullan@timesys.com>
Cc: linuxppc-dev@ozlabs.org, linuxppc-embedded@ozlabs.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] include/asm-ppc/dma-mapping.h macro patch
Message-ID: <20041207150332.GA16936@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Jason McMullan <jason.mcmullan@timesys.com>,
	linuxppc-dev@ozlabs.org, linuxppc-embedded@ozlabs.org,
	linux-kernel@vger.kernel.org
References: <20041207132031.GA23542@jmcmullan.timesys>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041207132031.GA23542@jmcmullan.timesys>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> +#define dma_cache_inv(_start,_size)		do { (void)(_start); (void)(_size); } while (0)

this looks really horrible.  What about turning these into inlines?

