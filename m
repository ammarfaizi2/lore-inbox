Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261234AbUFMWS6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261234AbUFMWS6 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Jun 2004 18:18:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261239AbUFMWS6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Jun 2004 18:18:58 -0400
Received: from arnor.apana.org.au ([203.14.152.115]:23564 "EHLO
	arnor.apana.org.au") by vger.kernel.org with ESMTP id S261234AbUFMWS4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Jun 2004 18:18:56 -0400
Date: Mon, 14 Jun 2004 08:18:40 +1000
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Cc: Christoph Hellwig <hch@infradead.org>, linux-ide@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] IDE update for 2.6.7-rc3 [1/12]
Message-ID: <20040613221840.GA31354@gondor.apana.org.au>
References: <E1BZQSC-0006vd-00@gondolin.me.apana.org.au> <200406132001.44262.bzolnier@elka.pw.edu.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200406132001.44262.bzolnier@elka.pw.edu.pl>
User-Agent: Mutt/1.5.5.1+cvs20040105i
From: Herbert Xu <herbert@gondor.apana.org.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 13, 2004 at 08:01:44PM +0200, Bartlomiej Zolnierkiewicz wrote:
> 
> This makes ordering of IDE devices different in Debian-2.6
> and vanilla 2.4/2.6, doesn't sound like a good thing to do.

If IDE is built-in, the ordering is exactly the same.

> Ideally ordering should be controlled by user-space. :-)

If IDE is built as a module, then the ordering is still controlled
by user space.
-- 
Visit Openswan at http://www.openswan.org/
Email:  Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
