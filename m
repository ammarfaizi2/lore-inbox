Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261460AbVA1F0u@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261460AbVA1F0u (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Jan 2005 00:26:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261462AbVA1F0u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Jan 2005 00:26:50 -0500
Received: from adsl-63-197-226-105.dsl.snfc21.pacbell.net ([63.197.226.105]:58820
	"EHLO cheetah.davemloft.net") by vger.kernel.org with ESMTP
	id S261460AbVA1F0t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Jan 2005 00:26:49 -0500
Date: Thu, 27 Jan 2005 21:22:14 -0800
From: "David S. Miller" <davem@davemloft.net>
To: sfeldma@pobox.com
Cc: rmk+lkml@arm.linux.org.uk, jgarzik@pobox.com, linux-kernel@vger.kernel.org,
       netdev@oss.sgi.com, greg@kroah.com, akpm@osdl.org
Subject: Re: [ANN] removal of certain net drivers coming soon: eepro100,
 xircom_tulip_cb, iph5526
Message-Id: <20050127212214.58678bef.davem@davemloft.net>
In-Reply-To: <1106877517.18167.311.camel@localhost.localdomain>
References: <41F952F4.7040804@pobox.com>
	<20050127225725.F3036@flint.arm.linux.org.uk>
	<20050127153114.72be03e2.davem@davemloft.net>
	<20050128001430.C22695@flint.arm.linux.org.uk>
	<20050127164843.08bdb307.davem@davemloft.net>
	<1106877517.18167.311.camel@localhost.localdomain>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 27 Jan 2005 17:58:37 -0800
Scott Feldman <sfeldma@pobox.com> wrote:

> eepro100 does a copy if pkt_len < rx_copybreak, otherwise it send up the
> skb and allocates and links a new one in it's place (see
> speedo_rx_link).

My bad, you're right.  So I wonder too what the difference
is that makes it work on ARM et al.
