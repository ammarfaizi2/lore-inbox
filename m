Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751298AbWDERLB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751298AbWDERLB (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Apr 2006 13:11:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751296AbWDERLB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Apr 2006 13:11:01 -0400
Received: from rhun.apana.org.au ([64.62.148.172]:6162 "EHLO
	arnor.apana.org.au") by vger.kernel.org with ESMTP id S1751289AbWDERLA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Apr 2006 13:11:00 -0400
Date: Thu, 6 Apr 2006 03:10:22 +1000
To: Dave Kleikamp <shaggy@austin.ibm.com>
Cc: "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] [IPSEC] Avoid null pointer dereference in xfrm4_rcv_encap
Message-ID: <20060405171022.GA14590@gondor.apana.org.au>
References: <1144249178.10340.5.camel@kleikamp.austin.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1144249178.10340.5.camel@kleikamp.austin.ibm.com>
User-Agent: Mutt/1.5.9i
From: Herbert Xu <herbert@gondor.apana.org.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 05, 2006 at 09:59:38AM -0500, Dave Kleikamp wrote:
> I'm getting a panic that I've traced back to this changeset:
> http://www.kernel.org/git/gitweb.cgi?p=linux/kernel/git/torvalds/linux-2.6.git;a=commit;h=e695633e21ffb6a443a8c2f8b3f095c7f1a48eb0
> 
> xfrm4_rcv_encap dereferences x->encap without testing it for null.

The fix for this bug has just been merged.  Thanks,
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
