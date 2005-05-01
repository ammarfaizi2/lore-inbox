Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261398AbVEAXKj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261398AbVEAXKj (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 May 2005 19:10:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261382AbVEAXKj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 May 2005 19:10:39 -0400
Received: from arnor.apana.org.au ([203.14.152.115]:58633 "EHLO
	arnor.apana.org.au") by vger.kernel.org with ESMTP id S261369AbVEAXK0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 May 2005 19:10:26 -0400
Date: Mon, 2 May 2005 09:08:43 +1000
To: Jesper Juhl <juhl-lkml@dif.dk>
Cc: "David S. Miller" <davem@davemloft.net>,
       Jouni Malinen <jkmaline@cc.hut.fi>,
       James Morris <jmorris@intercode.com.au>,
       Pedro Roque <roque@di.fc.ul.pt>,
       Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
       Kunihiro Ishiguro <kunihiro@ipinfusion.com>,
       Mitsuru KANDA <mk@linux-ipv6.org>,
       lksctp-developers@lists.sourceforge.net,
       Andy Adamson <andros@umich.edu>, Bruce Fields <bfields@umich.edu>,
       netdev@oss.sgi.com, linux-net@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] resource release cleanup in net/
Message-ID: <20050501230843.GA16518@gondor.apana.org.au>
References: <Pine.LNX.4.62.0504302219520.2094@dragon.hyggekrogen.localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.62.0504302219520.2094@dragon.hyggekrogen.localhost>
User-Agent: Mutt/1.5.6+20040907i
From: Herbert Xu <herbert@gondor.apana.org.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 30, 2005 at 10:36:00PM +0200, Jesper Juhl wrote:
> 
> Since Andrew merged the patch that makes calling crypto_free_tfm() with a 
> NULL pointer safe into 2.6.12-rc3-mm1, I made a patch to remove checks for 
> NULL before calling that function, and while I was at it I removed similar 
> redundant checks before calls to kfree() and vfree() in the same files. 
> There are also a few tiny whitespace cleanups in there.

Hi Jesper:

Could we wait until the crypto_free_tfm patch gets into the main tree?
Most people here track that instead of mm.

Thanks,
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
