Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932499AbWEINBS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932499AbWEINBS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 May 2006 09:01:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932494AbWEINBS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 May 2006 09:01:18 -0400
Received: from rhun.apana.org.au ([64.62.148.172]:5138 "EHLO
	arnor.apana.org.au") by vger.kernel.org with ESMTP id S932301AbWEINBR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 May 2006 09:01:17 -0400
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Christian.Limpach@cl.cam.ac.uk (Christian Limpach)
Subject: Re: [Xen-devel] [RFC PATCH 34/35] Add the Xen virtual network	device	driver.
Cc: herbert@gondor.apana.org.au, xen-devel@lists.xensource.com,
       ian.pratt@xensource.com, netdev@vger.kernel.org,
       linux-kernel@vger.kernel.org, chrisw@sous-sol.org,
       virtualization@lists.osdl.org
Organization: Core
In-Reply-To: <20060509124359.GA5407@cl.cam.ac.uk>
X-Newsgroups: apana.lists.os.linux.kernel,apana.lists.os.linux.netdev,apana.lists.os.xen.devel
User-Agent: tin/1.7.4-20040225 ("Benbecula") (UNIX) (Linux/2.4.27-hx-1-686-smp (i686))
Message-Id: <E1FdRpp-0008HG-00@gondolin.me.apana.org.au>
Date: Tue, 09 May 2006 23:01:05 +1000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christian Limpach <Christian.Limpach@cl.cam.ac.uk> wrote:
> 
> There's at least two reasons why having it in the driver is preferable:
> - synchronizing sending the fake ARP request with when the device is
>  operational -- you really want to make this well synchronized to keep
>  unreachability as short as possible, especially when doing live
>  migration
> - anybody but the guest might not know (all) the MAC addresses for which
>  to send a fake ARP request

Sure.  However, what's there to stop you from doing this in user-space
inside the guest?

Cheers,
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
