Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262040AbVEELkM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262040AbVEELkM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 May 2005 07:40:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262065AbVEELkM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 May 2005 07:40:12 -0400
Received: from arnor.apana.org.au ([203.14.152.115]:13577 "EHLO
	arnor.apana.org.au") by vger.kernel.org with ESMTP id S262040AbVEELkC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 May 2005 07:40:02 -0400
From: Herbert Xu <herbert@gondor.apana.org.au>
To: yoshfuji@linux-ipv6.org (YOSHIFUJI Hideaki / ????)
Subject: Re: [PATCH 2/3] add open iscsi netlink interface to iscsi transport class
Cc: michaelc@cs.wisc.edu, linux-scsi@vger.kernel.org, netdev@oss.sgi.com,
       linux-kernel@vger.kernel.org, yoshfuji@linux-ipv6.org
Organization: Core
In-Reply-To: <20050505.185503.78606493.yoshfuji@linux-ipv6.org>
X-Newsgroups: apana.lists.os.linux.kernel,apana.lists.os.linux.netdev,apana.lists.os.linux.scsi
User-Agent: tin/1.7.4-20040225 ("Benbecula") (UNIX) (Linux/2.4.27-hx-1-686-smp (i686))
Message-Id: <E1DTehn-0005gJ-00@gondolin.me.apana.org.au>
Date: Thu, 05 May 2005 21:39:47 +1000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

YOSHIFUJI Hideaki / ???? <yoshfuji@linux-ipv6.org> wrote:
> In article <42798AC1.2010308@cs.wisc.edu> (at Wed, 04 May 2005 19:53:53 -0700), Mike Christie <michaelc@cs.wisc.edu> says:
> 
>> +struct iscsi_uevent {
> :
>> +} __attribute__ ((aligned (sizeof(unsigned long))));
> 
> I think it'd be better to use sizeof(uint64_t) or something.

Is there a benefit in aligning on 64-bit boundaries for 32-bit platforms?

Cheers,
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
