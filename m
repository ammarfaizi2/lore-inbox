Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262271AbVCOFoM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262271AbVCOFoM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Mar 2005 00:44:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262269AbVCOFoL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Mar 2005 00:44:11 -0500
Received: from dsl027-180-174.sfo1.dsl.speakeasy.net ([216.27.180.174]:36537
	"EHLO cheetah.davemloft.net") by vger.kernel.org with ESMTP
	id S262268AbVCOFn6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Mar 2005 00:43:58 -0500
Date: Mon, 14 Mar 2005 21:41:38 -0800
From: "David S. Miller" <davem@davemloft.net>
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: rmk+lkml@arm.linux.org.uk, linux-kernel@vger.kernel.org,
       netfilter@lists.netfilter.org
Subject: Re: Netfilter ipt_hashlimit
Message-Id: <20050314214138.025b2e43.davem@davemloft.net>
In-Reply-To: <E1D9itD-00039G-00@gondolin.me.apana.org.au>
References: <20050310222934.C1044@flint.arm.linux.org.uk>
	<E1D9itD-00039G-00@gondolin.me.apana.org.au>
X-Mailer: Sylpheed version 1.0.1 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 11 Mar 2005 23:05:11 +1100
Herbert Xu <herbert@gondor.apana.org.au> wrote:

> Russell King <rmk+lkml@arm.linux.org.uk> wrote:
> > With current-ish Linus 2.6 BK, I'm seeing this:
> > 
> > net/ipv4/netfilter/ipt_hashlimit.c:96: warning: type defaults to `int' in declaration of `DECLARE_LOCK'
> > net/ipv4/netfilter/ipt_hashlimit.c:96: warning: parameter names (without types) in function declaration
> > 
> > Looks like ipt_hashlimit.c is missing an include?
> 
> Indeed.  It should include lockhelp.h directly.
> 
> Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>

Applied, thanks Herbert.
