Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269679AbVBFBXO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269679AbVBFBXO (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Feb 2005 20:23:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269646AbVBFBXO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Feb 2005 20:23:14 -0500
Received: from adsl-63-197-226-105.dsl.snfc21.pacbell.net ([63.197.226.105]:28338
	"EHLO cheetah.davemloft.net") by vger.kernel.org with ESMTP
	id S272402AbVBFBWq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Feb 2005 20:22:46 -0500
Date: Sat, 5 Feb 2005 17:14:39 -0800
From: "David S. Miller" <davem@davemloft.net>
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: anton@samba.org, okir@suse.de, netdev@oss.sgi.com,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arp_queue: serializing unlink + kfree_skb
Message-Id: <20050205171439.4e825155.davem@davemloft.net>
In-Reply-To: <20050204015539.GA9727@gondor.apana.org.au>
References: <20050131102920.GC4170@suse.de>
	<E1CvZo6-0001Bz-00@gondolin.me.apana.org.au>
	<20050203142705.GA11318@krispykreme.ozlabs.ibm.com>
	<20050203203010.GA7081@gondor.apana.org.au>
	<20050203141901.5ce04c92.davem@davemloft.net>
	<20050203235044.GA8422@gondor.apana.org.au>
	<20050203164922.2627a112.davem@davemloft.net>
	<20050204012053.GA8949@gondor.apana.org.au>
	<20050203172357.670c3402.davem@davemloft.net>
	<20050204015539.GA9727@gondor.apana.org.au>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 4 Feb 2005 12:55:39 +1100
Herbert Xu <herbert@gondor.apana.org.au> wrote:

> OK, here is the patch to do that.  Let's get rid of kfree_skb_fast
> while we're at it since it's no longer used.
> 
> Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>

I've queued this up for 2.6.x and 2.4.x, thanks everyone.
