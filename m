Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269022AbUI2UvY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269022AbUI2UvY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Sep 2004 16:51:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269026AbUI2UvY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Sep 2004 16:51:24 -0400
Received: from adsl-63-197-226-105.dsl.snfc21.pacbell.net ([63.197.226.105]:45459
	"EHLO cheetah.davemloft.net") by vger.kernel.org with ESMTP
	id S269022AbUI2UvW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Sep 2004 16:51:22 -0400
Date: Wed, 29 Sep 2004 13:50:29 -0700
From: "David S. Miller" <davem@davemloft.net>
To: Jesse Barnes <jbarnes@engr.sgi.com>
Cc: gnb@sgi.com, akpm@osdl.org, linux-kernel@vger.kernel.org, jeremy@sgi.com,
       johnip@sgi.com, netdev@oss.sgi.com
Subject: Re: [PATCH] I/O space write barrier
Message-Id: <20040929135029.38444afd.davem@davemloft.net>
In-Reply-To: <200409291343.55863.jbarnes@engr.sgi.com>
References: <200409271103.39913.jbarnes@engr.sgi.com>
	<20040929103646.GA4682@sgi.com>
	<20040929133500.59d78765.davem@davemloft.net>
	<200409291343.55863.jbarnes@engr.sgi.com>
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 29 Sep 2004 13:43:55 -0700
Jesse Barnes <jbarnes@engr.sgi.com> wrote:

> The patch that actually implements mmiowb() already does this, I think Greg 
> just used his patch for testing.  The proper way to do it of course is to 
> just use mmiowb() where needed in tg3 after the write barrier patch gets in.

Perfect, please send me a tg3 patch once the mmiowb() bits
go into the tree.

Thanks a lot.
