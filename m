Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262937AbVAQWnb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262937AbVAQWnb (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Jan 2005 17:43:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261516AbVAQWmr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Jan 2005 17:42:47 -0500
Received: from adsl-63-197-226-105.dsl.snfc21.pacbell.net ([63.197.226.105]:26524
	"EHLO cheetah.davemloft.net") by vger.kernel.org with ESMTP
	id S261540AbVAQWl4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Jan 2005 17:41:56 -0500
Date: Mon, 17 Jan 2005 14:37:38 -0800
From: "David S. Miller" <davem@davemloft.net>
To: Adrian Bunk <bunk@stusta.de>
Cc: acme@conectiva.com.br, netdev@oss.sgi.com, linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] net/802/: some cleanups
Message-Id: <20050117143738.0cf1ed02.davem@davemloft.net>
In-Reply-To: <20050117081438.GE4274@stusta.de>
References: <20041212201115.GU22324@stusta.de>
	<20041227184923.5b26f5a0.davem@davemloft.net>
	<20050117081438.GE4274@stusta.de>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 17 Jan 2005 09:14:38 +0100
Adrian Bunk <bunk@stusta.de> wrote:

> On Mon, Dec 27, 2004 at 06:49:23PM -0800, David S. Miller wrote:
> > 
> > drivers/net/net_init.c no longer exists in the source tree :)
> 
> Updated patch:
> 
> 
> <--  snip  -->
> 
> 
> This patch contains the following cleanups:
> - make some needlessly global code static
> - net/802/hippi.c: remove the unused global function hippi_net_init
> - net/8021q/vlan.c: remove the global variable vlan_default_dev_flags
>                     that was never changed
> 
> Signed-off-by: Adrian Bunk <bunk@stusta.de>

Applied, thanks Adrian.
