Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266474AbUFUVN7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266474AbUFUVN7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Jun 2004 17:13:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266477AbUFUVN7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Jun 2004 17:13:59 -0400
Received: from mx1.redhat.com ([66.187.233.31]:26793 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S266474AbUFUVNo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Jun 2004 17:13:44 -0400
Date: Mon, 21 Jun 2004 14:11:44 -0700
From: "David S. Miller" <davem@redhat.com>
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: kernel@nn7.de, linux-kernel@vger.kernel.org, benh@kernel.crashing.org,
       netdev@oss.sgi.com, jgarzik@pobox.com
Subject: Re: sungem - ifconfig eth0 mtu 1300 -> oops
Message-Id: <20040621141144.119be627.davem@redhat.com>
In-Reply-To: <20040621130316.GA2661@gondor.apana.org.au>
References: <1087568322.4455.22.camel@localhost>
	<E1BcNzi-0000eh-00@gondolin.me.apana.org.au>
	<20040621130316.GA2661@gondor.apana.org.au>
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 21 Jun 2004 23:03:16 +1000
Herbert Xu <herbert@gondor.apana.org.au> wrote:

> On Mon, Jun 21, 2004 at 10:33:50PM +1000, Herbert Xu wrote:
> > 
> > Does this patch fix your problems?
> 
> Oops, I had a thinko about min vs. max.  I've also decided to make the
> bigger MTU useful by adjusting the arguments to skb_put() as well.
> Please try this one instead.

Applied, thanks Herbert.
