Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261758AbUL1HWS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261758AbUL1HWS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Dec 2004 02:22:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261698AbUL1HWR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Dec 2004 02:22:17 -0500
Received: from adsl-63-197-226-105.dsl.snfc21.pacbell.net ([63.197.226.105]:9386
	"EHLO cheetah.davemloft.net") by vger.kernel.org with ESMTP
	id S262100AbUL1Fx4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Dec 2004 00:53:56 -0500
Date: Mon, 27 Dec 2004 21:52:39 -0800
From: "David S. Miller" <davem@davemloft.net>
To: Oleg Nesterov <oleg@tv-sign.ru>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: [PATCH] optimize prefetch() usage in skb_queue_walk()
Message-Id: <20041227215239.2fb3b510.davem@davemloft.net>
In-Reply-To: <41D032B6.E5D3D00C@tv-sign.ru>
References: <41D032B6.E5D3D00C@tv-sign.ru>
X-Mailer: Sylpheed version 1.0.0rc (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 27 Dec 2004 19:05:10 +0300
Oleg Nesterov <oleg@tv-sign.ru> wrote:

> This patch changes skb_queue_walk() in the same manner
> as in list_for_each() prefetch optimization, see
> http://marc.theaimsgroup.com/?l=linux-kernel&m=110399132418587

Applied, thanks Oleg.
