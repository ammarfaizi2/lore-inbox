Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750957AbWDIWpm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750957AbWDIWpm (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Apr 2006 18:45:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750959AbWDIWpm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Apr 2006 18:45:42 -0400
Received: from rhun.apana.org.au ([64.62.148.172]:57866 "EHLO
	arnor.apana.org.au") by vger.kernel.org with ESMTP id S1750956AbWDIWpl
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 Apr 2006 18:45:41 -0400
Date: Mon, 10 Apr 2006 08:45:37 +1000
To: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Cc: linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org, akpm@osdl.org
Subject: Re: [PATCH] crypto: add alignment handling to digest layer
Message-ID: <20060409224537.GA30127@gondor.apana.org.au>
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
> 
> Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>

Patch applied.  Thanks a lot.
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
