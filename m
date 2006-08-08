Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932399AbWHHIwZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932399AbWHHIwZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Aug 2006 04:52:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932548AbWHHIwZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Aug 2006 04:52:25 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:62854 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932399AbWHHIwZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Aug 2006 04:52:25 -0400
Date: Tue, 8 Aug 2006 09:52:23 +0100
From: Christoph Hellwig <hch@infradead.org>
To: "Randy.Dunlap" <rdunlap@xenotime.net>
Cc: lkml <linux-kernel@vger.kernel.org>, akpm <akpm@osdl.org>,
       torvalds <torvalds@osdl.org>, matthew@wil.cx, kyle@parisc-linux.org
Subject: Re: [PATCH 5/9] Replace ARCH_HAS_FLUSH_ANON_PAGE with CONFIG_ARCH_FLUSH_ANON_PAGE
Message-ID: <20060808085223.GA20680@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	"Randy.Dunlap" <rdunlap@xenotime.net>,
	lkml <linux-kernel@vger.kernel.org>, akpm <akpm@osdl.org>,
	torvalds <torvalds@osdl.org>, matthew@wil.cx, kyle@parisc-linux.org
References: <20060807120928.c0fe7045.rdunlap@xenotime.net> <20060807141008.de9c9c5c.rdunlap@xenotime.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060807141008.de9c9c5c.rdunlap@xenotime.net>
User-Agent: Mutt/1.4.2.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 07, 2006 at 02:10:08PM -0700, Randy.Dunlap wrote:
> From: Randy Dunlap <rdunlap@xenotime.net>
> 
> Replace ARCH_HAS_FLUSH_ANON_PAGE with CONFIG_ARCH_FLUSH_ANON_PAGE.

Please just put the dummy flush_anon_page in every architectures header.

