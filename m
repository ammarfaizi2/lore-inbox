Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266067AbUFPCO5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266067AbUFPCO5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Jun 2004 22:14:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266071AbUFPCO5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Jun 2004 22:14:57 -0400
Received: from arnor.apana.org.au ([203.14.152.115]:11794 "EHLO
	arnor.apana.org.au") by vger.kernel.org with ESMTP id S266067AbUFPCO4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Jun 2004 22:14:56 -0400
From: Herbert Xu <herbert@gondor.apana.org.au>
To: mbligh@aracnet.com (Martin J. Bligh)
Subject: Re: [PATCH] Performance regression in 2.6.7-rc3
Cc: mingo@elte.hu, kernel@kolivas.org, linux-kernel@vger.kernel.org,
       piggin@cyberone.com.au, akpm@osdl.org, wli@holomorphy.com,
       torvalds@osdl.org, markw@osdl.org
Organization: Core
In-Reply-To: <30410000.1087311734@[10.10.2.4]>
X-Newsgroups: apana.lists.os.linux.kernel
User-Agent: tin/1.7.4-20040225 ("Benbecula") (UNIX) (Linux/2.4.25-1-686-smp (i686))
Message-Id: <E1BaPwX-0007k0-00@gondolin.me.apana.org.au>
Date: Wed, 16 Jun 2004 12:14:25 +1000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martin J. Bligh <mbligh@aracnet.com> wrote:
> 
> How the hell can that have any effect on non-threaded workloads? Perhaps
> some part of kernel compile *is* multi-threaded. It does seem to get 

make(1) with vfork(2) perhaps?
-- 
Visit Openswan at http://www.openswan.org/
Email:  Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
