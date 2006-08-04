Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161051AbWHDFzF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161051AbWHDFzF (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Aug 2006 01:55:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161050AbWHDFzE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Aug 2006 01:55:04 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:55730
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S1161044AbWHDFzB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Aug 2006 01:55:01 -0400
Date: Thu, 03 Aug 2006 22:55:01 -0700 (PDT)
Message-Id: <20060803.225501.77357103.davem@davemloft.net>
To: herbert@gondor.apana.org.au
Cc: johnpol@2ka.mipt.ru, arnd@arndnet.de, linux-kernel@vger.kernel.org,
       netdev@vger.kernel.org
Subject: Re: problems with e1000 and jumboframes
From: David Miller <davem@davemloft.net>
In-Reply-To: <E1G8sbw-0003mT-00@gondolin.me.apana.org.au>
References: <20060803135925.GA28348@2ka.mipt.ru>
	<E1G8sbw-0003mT-00@gondolin.me.apana.org.au>
X-Mailer: Mew version 4.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Herbert Xu <herbert@gondor.apana.org.au>
Date: Fri, 04 Aug 2006 15:52:40 +1000

> Evgeniy Polyakov <johnpol@2ka.mipt.ru> wrote:
> > 
> > But it does not support splitting them into page sized chunks, so it
> > requires the whole jumbo frame allocation in one contiguous chunk, 9k
> > will be transferred into 16k allocation (order 3), since SLAB uses
> > power-of-2 allocation.
> 
> Actually order 3 is 32KB.

It's 64KB on my computer :)
