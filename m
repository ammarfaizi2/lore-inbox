Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030213AbVKWAEF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030213AbVKWAEF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Nov 2005 19:04:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030267AbVKWAEF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Nov 2005 19:04:05 -0500
Received: from 22.107.233.220.exetel.com.au ([220.233.107.22]:54791 "EHLO
	arnor.apana.org.au") by vger.kernel.org with ESMTP id S1030213AbVKWAED
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Nov 2005 19:04:03 -0500
Date: Wed, 23 Nov 2005 11:03:37 +1100
To: "David S. Miller" <davem@davemloft.net>
Cc: kuznet@ms2.inr.ac.ru, cfriesen@nortel.com, netdev@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [NETLINK]: Use tgid instead of pid for nlmsg_pid
Message-ID: <20051123000337.GA17249@gondor.apana.org.au>
References: <20051121213549.GA28187@ms2.inr.ac.ru> <E1EeJxb-0006xG-00@gondolin.me.apana.org.au> <20051122.144334.23915283.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051122.144334.23915283.davem@davemloft.net>
User-Agent: Mutt/1.5.9i
From: Herbert Xu <herbert@gondor.apana.org.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 22, 2005 at 02:43:34PM -0800, David S. Miller wrote:
> 
> Applied, of course.

Thanks Dave.
 
> It is possible we accidently reintroduced current->pid when
> we redid all of the netlink hashing. :-)

I just checked using git-whatchanged and that line goes back to
2002 :)

Cheers,
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
