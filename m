Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264386AbUJOWWx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264386AbUJOWWx (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Oct 2004 18:22:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264443AbUJOWWw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Oct 2004 18:22:52 -0400
Received: from arnor.apana.org.au ([203.14.152.115]:17165 "EHLO
	arnor.apana.org.au") by vger.kernel.org with ESMTP id S264386AbUJOWWO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Oct 2004 18:22:14 -0400
From: Herbert Xu <herbert@gondor.apana.org.au>
To: alain@parkautomat.net (Alain Schroeder)
Subject: Re: tun.c patch to fix "smp_processor_id() in preemptible code"
Cc: linux-kernel@vger.kernel.org, jbglaw@lug-owl.de
Organization: Core
In-Reply-To: <1097876587.4170.16.camel@marvin.home.parkautomat.net>
X-Newsgroups: apana.lists.os.linux.kernel
User-Agent: tin/1.7.4-20040225 ("Benbecula") (UNIX) (Linux/2.4.27-hx-1-686-smp (i686))
Message-Id: <E1CIaSa-0000hB-00@gondolin.me.apana.org.au>
Date: Sat, 16 Oct 2004 08:22:04 +1000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alain Schroeder <alain@parkautomat.net> wrote:
> 
> The (very) little attached patch fixes this.

Your change should be moved into netif_rx_ni itself.
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
