Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269032AbUIMXid@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269032AbUIMXid (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Sep 2004 19:38:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269040AbUIMXid
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Sep 2004 19:38:33 -0400
Received: from adsl-63-197-226-105.dsl.snfc21.pacbell.net ([63.197.226.105]:18344
	"EHLO cheetah.davemloft.net") by vger.kernel.org with ESMTP
	id S269032AbUIMXfg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Sep 2004 19:35:36 -0400
Date: Mon, 13 Sep 2004 16:33:33 -0700
From: "David S. Miller" <davem@davemloft.net>
To: Stephen Hemminger <shemminger@osdl.org>
Cc: jolt@tuxbox.org, pp@ee.oulu.fi, jgarzik@pobox.com,
       linux-kernel@vger.kernel.org, netdev@oss.sgi.com
Subject: Re: [PATCH] Fix for b44 warnings.
Message-Id: <20040913163333.2fadaf93.davem@davemloft.net>
In-Reply-To: <20040913163001.7fa560c6@dell_ss3.pdx.osdl.net>
References: <200408292218.00756.jolt@tuxbox.org>
	<20040913163001.7fa560c6@dell_ss3.pdx.osdl.net>
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 13 Sep 2004 16:30:01 -0700
Stephen Hemminger <shemminger@osdl.org> wrote:

> B44 driver was using unsigned long as an io memory address.
> Recent changes caused this to be a warning.  This patch fixes that
> and makes the readl/writel wrapper into inline's instead of macros
> with magic variable side effect (yuck).

Jeff, I'll merge this one.

Thanks Stephen.
