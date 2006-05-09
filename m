Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751330AbWEIWmG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751330AbWEIWmG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 May 2006 18:42:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751331AbWEIWmG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 May 2006 18:42:06 -0400
Received: from rhun.apana.org.au ([64.62.148.172]:5392 "EHLO
	arnor.apana.org.au") by vger.kernel.org with ESMTP id S1751327AbWEIWmF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 May 2006 18:42:05 -0400
From: Herbert Xu <herbert@gondor.apana.org.au>
To: chrisw@sous-sol.org (Chris Wright)
Subject: Re: [Xen-devel] [RFC PATCH 34/35] Add the Xen virtual network device	driver.
Cc: linux-kernel@vger.kernel.org, virtualization@lists.osdl.org,
       Christian.Limpach@cl.cam.ac.uk, xen-devel@lists.xensource.com,
       netdev@vger.kernel.org, ian.pratt@xensource.com
Organization: Core
In-Reply-To: <20060509085201.446830000@sous-sol.org>
X-Newsgroups: apana.lists.os.linux.kernel,apana.lists.os.linux.netdev,apana.lists.os.xen.devel
User-Agent: tin/1.7.4-20040225 ("Benbecula") (UNIX) (Linux/2.4.27-hx-1-686-smp (i686))
Message-Id: <E1FdatV-0000lj-00@gondolin.me.apana.org.au>
Date: Wed, 10 May 2006 08:41:29 +1000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Wright <chrisw@sous-sol.org> wrote:
>
> +       netdev->features        = NETIF_F_IP_CSUM;

Any reason why IP_CSUM was chosen instead of HW_CSUM? Doing the latter
would seem to be in fact easier for a virtual driver, no?

Cheers,
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
