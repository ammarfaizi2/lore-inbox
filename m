Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264299AbUIMAGj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264299AbUIMAGj (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Sep 2004 20:06:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264346AbUIMAGj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Sep 2004 20:06:39 -0400
Received: from adsl-63-197-226-105.dsl.snfc21.pacbell.net ([63.197.226.105]:25247
	"EHLO cheetah.davemloft.net") by vger.kernel.org with ESMTP
	id S264299AbUIMAGe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Sep 2004 20:06:34 -0400
Date: Sun, 12 Sep 2004 17:05:05 -0700
From: "David S. Miller" <davem@davemloft.net>
To: Paul P Komkoff Jr <i@stingr.net>
Cc: netdev@oss.sgi.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [RFC] Support for wccp version 1 and 2 in ip_gre.c
Message-Id: <20040912170505.62916147.davem@davemloft.net>
In-Reply-To: <20040911194108.GS28258@stingr.sgu.ru>
References: <20040911194108.GS28258@stingr.sgu.ru>
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 11 Sep 2004 23:41:08 +0400
Paul P Komkoff Jr <i@stingr.net> wrote:

> Some time ago I posted the following patch.
> It indeed adds support for wccp version 1 and 2 decapsulation in
> ip_gre.c. But there is an open question.
> I surrounded all decapsulation stuff in if (1).
> Which knob I should use instead of that 1 to make this change
> acceptable into mainline kernel?

What are the rules for IP_GRE in general for when
to apply this transformation?

Please do me a favor also, and redo your patch by putting
ETH_P_WCCP into include/linux/if_ether.h where it belongs.

Thanks.
