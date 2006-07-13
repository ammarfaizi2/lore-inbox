Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751538AbWGMMLz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751538AbWGMMLz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jul 2006 08:11:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751540AbWGMMLz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jul 2006 08:11:55 -0400
Received: from rhun.apana.org.au ([64.62.148.172]:50188 "EHLO
	arnor.apana.org.au") by vger.kernel.org with ESMTP id S1751537AbWGMMLy
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jul 2006 08:11:54 -0400
From: Herbert Xu <herbert@gondor.apana.org.au>
To: cat@zip.com.au (CaT)
Subject: Re: possible dos / wsize affected frozen connection length
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Organization: Core
In-Reply-To: <20060705005540.GL2344@zip.com.au>
X-Newsgroups: apana.lists.os.linux.kernel,apana.lists.os.linux.netdev
User-Agent: tin/1.7.4-20040225 ("Benbecula") (UNIX) (Linux/2.6.17-rc4 (i686))
Message-Id: <E1G102n-0007pk-00@gondolin.me.apana.org.au>
Date: Thu, 13 Jul 2006 22:11:49 +1000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

CaT <cat@zip.com.au> wrote:
> 
> I'm just wondering if connections hanging around this long are normal.
> The above has now been running for 6 days. netstat is still reporting an
> established session. netcat has not timed out. It's all just sitting
> there doing nothing.

TCP connections without keepalives can sit there for all eternity,
if your machine lasts that long :)
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
