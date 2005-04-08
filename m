Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262663AbVDHDBX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262663AbVDHDBX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Apr 2005 23:01:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262664AbVDHDBX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Apr 2005 23:01:23 -0400
Received: from arnor.apana.org.au ([203.14.152.115]:46097 "EHLO
	arnor.apana.org.au") by vger.kernel.org with ESMTP id S262663AbVDHDBU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Apr 2005 23:01:20 -0400
From: Herbert Xu <herbert@gondor.apana.org.au>
To: johnpol@2ka.mipt.ru
Subject: Re: [Fwd: Re: connector is missing in 2.6.12-rc2-mm1]
Cc: akpm@osdl.org, guillaume.thouvenin@bull.net, greg@kroah.com,
       linux-kernel@vger.kernel.org
Organization: Core
In-Reply-To: <1112868768.28858.156.camel@uganda>
X-Newsgroups: apana.lists.os.linux.kernel
User-Agent: tin/1.7.4-20040225 ("Benbecula") (UNIX) (Linux/2.4.27-hx-1-686-smp (i686))
Message-Id: <E1DJjiR-000850-00@gondolin.me.apana.org.au>
Date: Fri, 08 Apr 2005 12:59:27 +1000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Evgeniy Polyakov <johnpol@2ka.mipt.ru> wrote:
>
> atomic_dec_and_test() is more expensive than 2 barriers + atomic_dec(),
> but in case of connector I think the price is not so high.

Can you list the platforms on which this is true?

Thanks,
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
