Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261188AbVBLTXn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261188AbVBLTXn (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Feb 2005 14:23:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261189AbVBLTXm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Feb 2005 14:23:42 -0500
Received: from adsl-63-197-226-105.dsl.snfc21.pacbell.net ([63.197.226.105]:61584
	"EHLO cheetah.davemloft.net") by vger.kernel.org with ESMTP
	id S261188AbVBLTXl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Feb 2005 14:23:41 -0500
Date: Sat, 12 Feb 2005 11:22:03 -0800
From: "David S. Miller" <davem@davemloft.net>
To: Willy Tarreau <willy@w.ods.org>
Cc: marcelo.tosatti@cyclades.com, linux-kernel@vger.kernel.org,
       herbert@gondor.apana.org.au
Subject: Re: [2.4.30-pre1] Sparc SMP build fixes
Message-Id: <20050212112203.3232d444.davem@davemloft.net>
In-Reply-To: <20050212101349.GA22759@alpha.home.local>
References: <20050212101349.GA22759@alpha.home.local>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 12 Feb 2005 11:13:49 +0100
Willy Tarreau <willy@w.ods.org> wrote:

> The recent addition of an smp_rmb() in kfree_skb() by Herbert Xu
> broke SMP builds on sparc and sparc64, but it's not Herbert's fault,
> it's because of a few extra semi-colons in system.h for both archs.

I pushed this independantly to Marcelo yesterday, he just hasn't
pulled it in yet.

Sit tight :-)
