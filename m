Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265973AbUFJKJT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265973AbUFJKJT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Jun 2004 06:09:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265991AbUFJKJT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Jun 2004 06:09:19 -0400
Received: from arnor.apana.org.au ([203.14.152.115]:41743 "EHLO
	arnor.apana.org.au") by vger.kernel.org with ESMTP id S265973AbUFJKJS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Jun 2004 06:09:18 -0400
From: Herbert Xu <herbert@gondor.apana.org.au>
To: norman.r.weathers@conocophillips.com
Subject: Re: 2.4.26 SMP lockup problem
Cc: hahn@physics.mcmaster.ca, linux-kernel@vger.kernel.org
Organization: Core
In-Reply-To: <200406090812.20041.norman.r.weathers@conocophillips.com>
X-Newsgroups: apana.lists.os.linux.kernel
User-Agent: tin/1.7.4-20040225 ("Benbecula") (UNIX) (Linux/2.4.25-1-686-smp (i686))
Message-Id: <E1BYMUU-0008PS-00@gondolin.me.apana.org.au>
Date: Thu, 10 Jun 2004 20:08:58 +1000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Norman Weathers <norman.r.weathers@conocophillips.com> wrote:
> 
> On Tuesday 08 June 2004 08:00 pm, Mark Hahn wrote:
>> > CONFIG_X86_LOCAL_APIC=y
>>
>> that's the first thing I'd try turning off...
> 
> I have it disabled on the lilo promptwith noapic.  If that is not enough to 
> keep it disabled on these nodes, then I will turn it off completely.

You want nolapic to disable the local APIC.
-- 
Visit Openswan at http://www.openswan.org/
Email:  Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
