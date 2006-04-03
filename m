Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932338AbWDCVVK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932338AbWDCVVK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Apr 2006 17:21:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932327AbWDCVVJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Apr 2006 17:21:09 -0400
Received: from rhun.apana.org.au ([64.62.148.172]:28434 "EHLO
	arnor.apana.org.au") by vger.kernel.org with ESMTP id S932077AbWDCVVI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Apr 2006 17:21:08 -0400
Date: Tue, 4 Apr 2006 07:21:05 +1000
To: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Cc: linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org, akpm@osdl.org
Subject: Re: [PATCH] crypto: add alignment handling to digest layer
Message-ID: <20060403212105.GA31533@gondor.apana.org.au>
References: <20060309.123608.08076793.nemoto@toshiba-tops.co.jp> <20060404.000407.41198995.anemo@mba.ocn.ne.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060404.000407.41198995.anemo@mba.ocn.ne.jp>
User-Agent: Mutt/1.5.9i
From: Herbert Xu <herbert@gondor.apana.org.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 04, 2006 at 12:04:07AM +0900, Atsushi Nemoto wrote:
> 
> Some hash modules load/store data words directly.  The digest layer
> should pass properly aligned buffer to update()/final() method.  This
> patch also add cra_alignmask to some hash modules.

This patch is in my queue.  I'll be travelling for the next couple of
weeks but I'll get onto it after that.

Thanks,
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
