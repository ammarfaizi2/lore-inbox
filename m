Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262231AbVCVB1m@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262231AbVCVB1m (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Mar 2005 20:27:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262236AbVCVBZe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Mar 2005 20:25:34 -0500
Received: from arnor.apana.org.au ([203.14.152.115]:6674 "EHLO
	arnor.apana.org.au") by vger.kernel.org with ESMTP id S262284AbVCVBUw
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Mar 2005 20:20:52 -0500
From: Herbert Xu <herbert@gondor.apana.org.au>
To: akpm@osdl.org (Andrew Morton)
Subject: Re: 2.6.11 oops in skb_drop_fraglist
Cc: cel@citi.umich.edu, netdev@oss.sgi.com, linux-kernel@vger.kernel.org
Organization: Core
In-Reply-To: <20050321162444.31c6c68d.akpm@osdl.org>
X-Newsgroups: apana.lists.os.linux.kernel,apana.lists.os.linux.netdev
User-Agent: tin/1.7.4-20040225 ("Benbecula") (UNIX) (Linux/2.4.27-hx-1-686-smp (i686))
Message-Id: <E1DDY3j-00047A-00@gondolin.me.apana.org.au>
Date: Tue, 22 Mar 2005 12:19:51 +1100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton <akpm@osdl.org> wrote:
> Chuck Lever <cel@citi.umich.edu> wrote:
>>
>> testing NFS client workloads on a dual Pentium-III system running 2.6.11 
>> with some NFS patches.  i hit this oops while doing simple-minded ftps 
>> and tars.
>> 
>> the system locks up once or twice a day under this workload.  this is 
>> the first time i had the console and captured the oops output.
> 
> Chuck, I didn't see any followup to this.  Is it still happening in current
> kernels?

In the past the same Oops have been caused by memory problems...
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
