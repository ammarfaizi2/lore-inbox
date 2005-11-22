Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932484AbVKVAKR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932484AbVKVAKR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Nov 2005 19:10:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932442AbVKVAKR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Nov 2005 19:10:17 -0500
Received: from 22.107.233.220.exetel.com.au ([220.233.107.22]:775 "EHLO
	arnor.apana.org.au") by vger.kernel.org with ESMTP id S932433AbVKVAKP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Nov 2005 19:10:15 -0500
Date: Tue, 22 Nov 2005 11:09:59 +1100
To: Christopher Friesen <cfriesen@nortel.com>
Cc: kuznet@ms2.inr.ac.ru, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
       davem@davemloft.net
Subject: Re: netlink nlmsg_pid supposed to be pid or tid?
Message-ID: <20051122000959.GA27615@gondor.apana.org.au>
References: <E1EeJwF-0006wc-00@gondolin.me.apana.org.au> <43824F57.1040007@nortel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43824F57.1040007@nortel.com>
User-Agent: Mutt/1.5.9i
From: Herbert Xu <herbert@gondor.apana.org.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 21, 2005 at 04:51:03PM -0600, Christopher Friesen wrote:
> 
> Should that be getsockname(2)?  Anyways, I now understand the issues.

Yes that's what I meant.

> As it turns out, we were actually already calling getsockname() a bit 
> earlier in the code path, so we can just use the "pid" value from there.

Excellent.

Cheers,
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
