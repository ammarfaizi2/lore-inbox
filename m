Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932463AbVIMJY1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932463AbVIMJY1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Sep 2005 05:24:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932461AbVIMJY1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Sep 2005 05:24:27 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:22438 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932459AbVIMJY0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Sep 2005 05:24:26 -0400
Date: Tue, 13 Sep 2005 10:24:24 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Christoph Hellwig <hch@infradead.org>, linux-kernel@vger.kernel.org,
       linux-ia64@vger.kernel.org, tony.luck@intel.com
Subject: Re: [patch 2.6.13] ia64: re-implement dma_get_cache_alignment to avoid EXPORT_SYMBOL
Message-ID: <20050913092424.GB29552@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	linux-kernel@vger.kernel.org, linux-ia64@vger.kernel.org,
	tony.luck@intel.com
References: <09122005104852.31327@bilbo.tuxdriver.com> <20050912192524.GA14360@infradead.org> <20050913000611.GI19644@tuxdriver.com> <20050913001429.GJ19644@tuxdriver.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050913001429.GJ19644@tuxdriver.com>
User-Agent: Mutt/1.4.2.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 12, 2005 at 08:14:29PM -0400, John W. Linville wrote:
> The current ia64 implementation of dma_get_cache_alignment does not
> work for modules because it relies on a symbol which is not exported.
> Direct access to a global is a little ugly anyway, so this patch
> re-implements dma_get_cache_alignment in a manner similar to what is
> currently used for x86_64.

looks good to me.

