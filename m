Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263185AbUKTV25@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263185AbUKTV25 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 Nov 2004 16:28:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263182AbUKTV1o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Nov 2004 16:27:44 -0500
Received: from phoenix.infradead.org ([81.187.226.98]:53256 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S263185AbUKTVTg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Nov 2004 16:19:36 -0500
Date: Sat, 20 Nov 2004 21:19:31 +0000
From: Christoph Hellwig <hch@infradead.org>
To: William Lee Irwin III <wli@holomorphy.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.10-rc2-mm2
Message-ID: <20041120211931.GA21321@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	William Lee Irwin III <wli@holomorphy.com>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
References: <20041118021538.5764d58c.akpm@osdl.org> <20041120183128.GW2714@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041120183128.GW2714@holomorphy.com>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by phoenix.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 20, 2004 at 10:31:28AM -0800, William Lee Irwin III wrote:
> On Thu, Nov 18, 2004 at 02:15:38AM -0800, Andrew Morton wrote:
> > +frv-kill-off-highmem_start_page.patch
> > +frv-remove-obsolete-hardirq-stuff-from-includes.patch
> > +further-nommu-changes.patch
> > +further-nommu-proc-changes.patch
> > +frv-arch-nommu-changes.patch
> 
> This patch converts FRV to use remap_pfn_range() in its
> io_remap_page_range() function.

What about introducing io_remap_pfn_range while you're at it so we can
have a cross-plattform calling convention?

