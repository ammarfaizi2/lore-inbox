Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965087AbWEKAev@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965087AbWEKAev (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 May 2006 20:34:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965111AbWEKAeu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 May 2006 20:34:50 -0400
Received: from rhun.apana.org.au ([64.62.148.172]:46352 "EHLO
	arnor.apana.org.au") by vger.kernel.org with ESMTP id S965087AbWEKAeu
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 May 2006 20:34:50 -0400
From: Herbert Xu <herbert@gondor.apana.org.au>
To: ak@suse.de (Andi Kleen)
Subject: Re: [RFC PATCH 34/35] Add the Xen virtual network device driver.
Cc: rdreier@cisco.com, Keir.Fraser@cl.cam.ac.uk, shemminger@osdl.org,
       virtualization@lists.osdl.org, ian.pratt@xensource.com,
       xen-devel@lists.xensource.com, linux-kernel@vger.kernel.org,
       chrisw@sous-sol.org, netdev@vger.kernel.org
Organization: Core
In-Reply-To: <200605102028.22974.ak@suse.de>
X-Newsgroups: apana.lists.os.linux.kernel,apana.lists.os.linux.netdev,apana.lists.os.xen.devel
User-Agent: tin/1.7.4-20040225 ("Benbecula") (UNIX) (Linux/2.4.27-hx-1-686-smp (i686))
Message-Id: <E1Fdz7v-0007zc-00@gondolin.me.apana.org.au>
Date: Thu, 11 May 2006 10:33:59 +1000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen <ak@suse.de> wrote:
> 
> But if sampling virtual events for randomness is really unsafe (is it 
> really?) then native guests in Xen would also get bad random numbers
> and this would need to be somehow addressed.

Good point.  I wonder what VMWare does in this situation.
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
