Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269121AbUIHLkK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269121AbUIHLkK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Sep 2004 07:40:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269122AbUIHLkK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Sep 2004 07:40:10 -0400
Received: from imladris.demon.co.uk ([193.237.130.41]:59655 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S269121AbUIHLkG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Sep 2004 07:40:06 -0400
Date: Wed, 8 Sep 2004 12:40:03 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [patch] preempt-smp.patch, 2.6.9-rc1-bk14
Message-ID: <20040908124002.A30883@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Ingo Molnar <mingo@elte.hu>, Andrew Morton <akpm@osdl.org>,
	linux-kernel@vger.kernel.org
References: <20040908111751.GA11507@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20040908111751.GA11507@elte.hu>; from mingo@elte.hu on Wed, Sep 08, 2004 at 01:17:51PM +0200
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by phoenix.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> NOTE to architecture maintainers: generic_raw_read_trylock() is a crude
> version that should be replaced with the proper arch-optimized version
> ASAP.

I'd suggest not providing it at all then, because that forces arch
maintainers to implement it. 

