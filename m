Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932465AbVH3Ut5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932465AbVH3Ut5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Aug 2005 16:49:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932461AbVH3Ut5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Aug 2005 16:49:57 -0400
Received: from dsl093-002-214.det1.dsl.speakeasy.net ([66.93.2.214]:45190 "EHLO
	pickle.fieldses.org") by vger.kernel.org with ESMTP id S932459AbVH3Utz
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Aug 2005 16:49:55 -0400
Date: Tue, 30 Aug 2005 16:49:41 -0400
To: Jesper Juhl <jesper.juhl@gmail.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Alexey Dobriyan <adobriyan@mail.ru>,
       Herbert Xu <herbert@gondor.apana.org.au>,
       YOSHIFUJI Hideaki <yoshfuji@linux-ipv6.org>,
       "David S. Miller" <davem@davemloft.net>,
       Benjamin Reed <breed@users.sourceforge.net>,
       Andy Adamson <andros@citi.umich.edu>, netdev@vger.kernel.org,
       lksctp developers <lksctp-developers@lists.sourceforge.net>,
       Andy Adamson <andros@umich.edu>, linux-net@vger.kernel.org,
       linux-crypto@vger.kernel.org
Subject: Re: [PATCH] crypto_free_tfm callers do not need to check for NULL
Message-ID: <20050830204941.GA10817@fieldses.org>
References: <200508302245.55392.jesper.juhl@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200508302245.55392.jesper.juhl@gmail.com>
User-Agent: Mutt/1.5.10i
From: "J. Bruce Fields" <bfields@fieldses.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 30, 2005 at 10:45:54PM +0200, Jesper Juhl wrote:
> Since the patch to add a NULL short-circuit to crypto_free_tfm() went in, 
> there's no longer any need for callers of that function to check for NULL.
...
> Feedback, ACK, NACK, etc welcome. 

I've no problem with the auth_gss or nfsv4 bits.--b.
