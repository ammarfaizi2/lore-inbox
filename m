Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964832AbWGHNq3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964832AbWGHNq3 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Jul 2006 09:46:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964840AbWGHNq3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Jul 2006 09:46:29 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:31437 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S964832AbWGHNq2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Jul 2006 09:46:28 -0400
Date: Sat, 8 Jul 2006 14:46:21 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Arjan van de Ven <arjan@infradead.org>
Cc: Herbert Xu <herbert@gondor.apana.org.au>, davej@redhat.com, mingo@elte.hu,
       akpm@osdl.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: starting mc triggers lockdep
Message-ID: <20060708134621.GA10549@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Arjan van de Ven <arjan@infradead.org>,
	Herbert Xu <herbert@gondor.apana.org.au>, davej@redhat.com,
	mingo@elte.hu, akpm@osdl.org, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
References: <E1Fz33I-0006vG-00@gondolin.me.apana.org.au> <1152352400.3120.19.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1152352400.3120.19.camel@laptopd505.fenrus.org>
User-Agent: Mutt/1.4.2.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 08, 2006 at 11:53:20AM +0200, Arjan van de Ven wrote:
> > Did I miss something?
> 
> is it not possible to nfs export /sys, and then mount it over loopback?

No, it's not.  A filesystem needs dedicated routines to support nfs
exporting and sysfs doesn't have those.

