Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965173AbVKVUkU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965173AbVKVUkU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Nov 2005 15:40:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965179AbVKVUkU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Nov 2005 15:40:20 -0500
Received: from 22.107.233.220.exetel.com.au ([220.233.107.22]:7429 "EHLO
	arnor.apana.org.au") by vger.kernel.org with ESMTP id S965173AbVKVUkR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Nov 2005 15:40:17 -0500
Date: Wed, 23 Nov 2005 07:40:08 +1100
To: Joe Korty <joe.korty@ccur.com>
Cc: "David S. Miller" <davem@davemloft.net>, linux-kernel@vger.kernel.org,
       netdev@vger.kernel.org
Subject: Re: Network lockup under load
Message-ID: <20051122204008.GA16049@gondor.apana.org.au>
References: <20051122164502.GA12498@tsunami.ccur.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051122164502.GA12498@tsunami.ccur.com>
User-Agent: Mutt/1.5.9i
From: Herbert Xu <herbert@gondor.apana.org.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 22, 2005 at 04:45:02PM +0000, Joe Korty wrote:
> 
> To trigger the lockup, I do a 'scp -rp' of the kernel
> tree from a machine with a defective kernel to any other
> machine.  It triggers anywhere after the first file
> transfered, to perhaps 30 files transfered.

Please generate a stack backtrace of your processes using either
CTRL-SCROLLLOCK or SysRq.

Thanks,
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
