Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262070AbUL1F0g@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262070AbUL1F0g (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Dec 2004 00:26:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262077AbUL1F0L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Dec 2004 00:26:11 -0500
Received: from adsl-63-197-226-105.dsl.snfc21.pacbell.net ([63.197.226.105]:41641
	"EHLO cheetah.davemloft.net") by vger.kernel.org with ESMTP
	id S262070AbUL1FWw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Dec 2004 00:22:52 -0500
Date: Mon, 27 Dec 2004 21:18:04 -0800
From: "David S. Miller" <davem@davemloft.net>
To: Adrian Bunk <bunk@stusta.de>
Cc: netdev@oss.sgi.com, linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] net/rxrpc/: misc possible cleanups
Message-Id: <20041227211804.4365c340.davem@davemloft.net>
In-Reply-To: <20041215012612.GG12937@stusta.de>
References: <20041215012612.GG12937@stusta.de>
X-Mailer: Sylpheed version 1.0.0rc (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 15 Dec 2004 02:26:12 +0100
Adrian Bunk <bunk@stusta.de> wrote:

> The patch below contains the following possible cleanups:
> - make some needlessly global code static
> - remove the following unused global function:
>   - transport.c: rxrpc_clear_transport
> - remove the following unneeded EXPORT_SYMBOL:
>   - rxrpc_syms.c: rxrpc_call_flush

Looks good, applied.

Thanks Adrian.
