Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262063AbUL1EJK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262063AbUL1EJK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Dec 2004 23:09:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262064AbUL1EJJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Dec 2004 23:09:09 -0500
Received: from adsl-63-197-226-105.dsl.snfc21.pacbell.net ([63.197.226.105]:12455
	"EHLO cheetah.davemloft.net") by vger.kernel.org with ESMTP
	id S262063AbUL1EJI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Dec 2004 23:09:08 -0500
Date: Mon, 27 Dec 2004 20:04:24 -0800
From: "David S. Miller" <davem@davemloft.net>
To: Adrian Bunk <bunk@stusta.de>
Cc: netdev@oss.sgi.com, linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] net/ipv4/: misc possible cleanups
Message-Id: <20041227200424.557a5902.davem@davemloft.net>
In-Reply-To: <20041228033617.GI5345@stusta.de>
References: <20041215005139.GJ23151@stusta.de>
	<20041227191535.5edce690.davem@davemloft.net>
	<20041228033617.GI5345@stusta.de>
X-Mailer: Sylpheed version 1.0.0rc (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 28 Dec 2004 04:36:17 +0100
Adrian Bunk <bunk@stusta.de> wrote:

> tcp_done doesn't call tcp_clear_xmit_timer, it calls 
> tcp_clear_xmit_timers (note the s) which is not an inline but an 
> EXPORT_SYMBOL'ed function in tcp_timer.c.

My bad, I'll re-review your patch and apply it unless
I find some problem.
