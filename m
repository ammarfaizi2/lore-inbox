Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265109AbUFVTxs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265109AbUFVTxs (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Jun 2004 15:53:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265114AbUFVTxV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Jun 2004 15:53:21 -0400
Received: from [213.146.154.40] ([213.146.154.40]:18571 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S265663AbUFVTv4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Jun 2004 15:51:56 -0400
Date: Tue, 22 Jun 2004 20:51:51 +0100
From: Christoph Hellwig <hch@infradead.org>
To: "Nguyen, Tom L" <tom.l.nguyen@intel.com>
Cc: Roland Dreier <roland@topspin.com>, linux-kernel@vger.kernel.org
Subject: Re: Question on using MSI in PCI driver
Message-ID: <20040622195151.GA8809@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	"Nguyen, Tom L" <tom.l.nguyen@intel.com>,
	Roland Dreier <roland@topspin.com>, linux-kernel@vger.kernel.org
References: <C7AB9DA4D0B1F344BF2489FA165E5024057E5196@orsmsx404.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <C7AB9DA4D0B1F344BF2489FA165E5024057E5196@orsmsx404.amr.corp.intel.com>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 22, 2004 at 11:08:04AM -0700, Nguyen, Tom L wrote:
> On Tuesday, June 22, 2004 Roland Dreier wrote: 
> 
> >Do you think the msi subsystem should use a different name for the
> >MSI-X memory region ("MSI-X iomap Failure" seems very strange to me).
> 
> What do you think of "Failure to request the MMIO address space of the
> MSI-X PBA"?
> Or what name do you suggest?

Why do you think you want "failure" in that string?   It's a name that
can be used to easily identify the MMIO region, and your sentence is a)
too long and b) doesn't make sense (at least to me, maybe I'm missing
something important).

Why not just "MSI-X PBA"?

