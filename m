Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269622AbUIRUbM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269622AbUIRUbM (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Sep 2004 16:31:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269627AbUIRUbM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Sep 2004 16:31:12 -0400
Received: from mx02.cybersurf.com ([209.197.145.105]:2757 "EHLO
	mx02.cybersurf.com") by vger.kernel.org with ESMTP id S269622AbUIRUbK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Sep 2004 16:31:10 -0400
Subject: Re: [TRIVIAL] Fix recent bug in fib_semantics.c
From: jamal <hadi@cyberus.ca>
Reply-To: hadi@cyberus.ca
To: "David S. Miller" <davem@davemloft.net>
Cc: Herbert Xu <herbert@gondor.apana.org.au>, jonsmirl@gmail.com,
       david@gibson.dropbear.id.au, akpm@osdl.org, trivial@rustcorp.com.au,
       linux-kernel@vger.kernel.org, netdev@oss.sgi.com
In-Reply-To: <20040917233108.561c88d6.davem@davemloft.net>
References: <9e47339104091717215e9be08b@mail.gmail.com>
	 <E1C8T4t-0006ug-00@gondolin.me.apana.org.au>
	 <9e473391040917183726113e91@mail.gmail.com>
	 <20040918041627.GA12356@gondor.apana.org.au>
	 <20040917233108.561c88d6.davem@davemloft.net>
Content-Type: text/plain
Organization: jamalopolous
Message-Id: <1095539462.1043.1.camel@jzny.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 
Date: 18 Sep 2004 16:31:03 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2004-09-18 at 02:31, David S. Miller wrote:
> On Sat, 18 Sep 2004 14:16:28 +1000

> So if you rmmod() a device before any routes are ever
> created in ipv4, this triggers.  I didn't think this
> was possible, but it is.

May have been exposed by LLTX. When i turned off LLTX on e1000
before seeing your fix, the oops disapeared.

cheers,
jamal

