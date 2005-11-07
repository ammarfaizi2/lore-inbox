Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964794AbVKGGe6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964794AbVKGGe6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Nov 2005 01:34:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964799AbVKGGe6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Nov 2005 01:34:58 -0500
Received: from 22.107.233.220.exetel.com.au ([220.233.107.22]:20488 "EHLO
	arnor.apana.org.au") by vger.kernel.org with ESMTP id S964794AbVKGGe5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Nov 2005 01:34:57 -0500
Date: Mon, 7 Nov 2005 17:34:30 +1100
To: Andrew Morton <akpm@osdl.org>
Cc: Christoph Hellwig <hch@infradead.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.14-mm1
Message-ID: <20051107063430.GA13617@gondor.apana.org.au>
References: <20051106182447.5f571a46.akpm@osdl.org> <20051107032518.GA12192@infradead.org> <20051106221257.1e413eec.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051106221257.1e413eec.akpm@osdl.org>
User-Agent: Mutt/1.5.9i
From: Herbert Xu <herbert@gondor.apana.org.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Christoph Hellwig <hch@infradead.org> wrote:
> >
> > > +add-be-le-types-without-underscores.patch
> > > 
> > >  cleanup
> > 
> > please don't.  having two types for exacytly the same thing is always a
> > bad idea.

This is no different from having both u16 and __u16.  The version
without underscores is the preferred type to use but we need to
keep the underscored version for header files included from userspace.

Cheers,
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
