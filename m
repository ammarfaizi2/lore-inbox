Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262652AbVDHE5p@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262652AbVDHE5p (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Apr 2005 00:57:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262659AbVDHE5p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Apr 2005 00:57:45 -0400
Received: from dsl027-180-174.sfo1.dsl.speakeasy.net ([216.27.180.174]:237
	"EHLO cheetah.davemloft.net") by vger.kernel.org with ESMTP
	id S262652AbVDHE5n (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Apr 2005 00:57:43 -0400
Date: Thu, 7 Apr 2005 21:55:10 -0700
From: "David S. Miller" <davem@davemloft.net>
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: johnpol@2ka.mipt.ru, akpm@osdl.org, guillaume.thouvenin@bull.net,
       greg@kroah.com, linux-kernel@vger.kernel.org
Subject: Re: [Fwd: Re: connector is missing in 2.6.12-rc2-mm1]
Message-Id: <20050407215510.56759e95.davem@davemloft.net>
In-Reply-To: <20050408045302.GA32600@gondor.apana.org.au>
References: <E1DJjiR-000850-00@gondolin.me.apana.org.au>
	<1112931238.28858.180.camel@uganda>
	<20050408033246.GA31344@gondor.apana.org.au>
	<1112932354.28858.192.camel@uganda>
	<20050408035052.GA31451@gondor.apana.org.au>
	<1112932969.28858.194.camel@uganda>
	<20050408040237.GA31761@gondor.apana.org.au>
	<1112934088.28858.199.camel@uganda>
	<20050408041724.GA32243@gondor.apana.org.au>
	<1112936127.28858.206.camel@uganda>
	<20050408045302.GA32600@gondor.apana.org.au>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 8 Apr 2005 14:53:02 +1000
Herbert Xu <herbert@gondor.apana.org.au> wrote:

> Yes but what will go wrong on uni-processor MIPS when you don't do the
> sync in atomic_sub_return?

Indeed.  I see nothing in those quotes which indicate that the
SYNC is needed on uniprocessor.  It's only saying things such
as "SYNC only affects load and store instructions" and
"LL/SC can only be performed on cacheable memory".  Stuff
like that.
