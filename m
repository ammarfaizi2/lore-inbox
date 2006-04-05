Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751304AbWDER3q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751304AbWDER3q (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Apr 2006 13:29:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751306AbWDER3q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Apr 2006 13:29:46 -0400
Received: from CyborgDefenseSystems.Corporatebeast.com ([64.62.148.172]:34322
	"EHLO arnor.apana.org.au") by vger.kernel.org with ESMTP
	id S1751304AbWDER3p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Apr 2006 13:29:45 -0400
Date: Thu, 6 Apr 2006 03:29:42 +1000
To: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Cc: linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org, akpm@osdl.org
Subject: Re: [PATCH] crypto: fix unaligned access in khazad module
Message-ID: <20060405172942.GA14914@gondor.apana.org.au>
References: <20060309.122638.07642914.nemoto@toshiba-tops.co.jp> <20060404.000518.126141927.anemo@mba.ocn.ne.jp> <20060403231122.GA32271@gondor.apana.org.au> <20060404.165552.52129978.nemoto@toshiba-tops.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060404.165552.52129978.nemoto@toshiba-tops.co.jp>
User-Agent: Mutt/1.5.9i
From: Herbert Xu <herbert@gondor.apana.org.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 04, 2006 at 04:55:52PM +0900, Atsushi Nemoto wrote:
> 
> On 64-bit platform, reading 64-bit keys (which is supposed to be
> 32-bit aligned) at a time will result in unaligned access.

Patch applied.  Thanks a lot.
--
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
