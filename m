Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261238AbVCJUuA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261238AbVCJUuA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Mar 2005 15:50:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261220AbVCJUtx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Mar 2005 15:49:53 -0500
Received: from dsl027-180-174.sfo1.dsl.speakeasy.net ([216.27.180.174]:36746
	"EHLO cheetah.davemloft.net") by vger.kernel.org with ESMTP
	id S263089AbVCJUqV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Mar 2005 15:46:21 -0500
Date: Thu, 10 Mar 2005 12:45:02 -0800
From: "David S. Miller" <davem@davemloft.net>
To: "emmanuel.colbus@ensimag.imag.fr" <colbuse@ensisun.imag.fr>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC][SPARC64][kernel 2.4] __show_regs() calls to printk()
Message-Id: <20050310124502.5ee5d8bf.davem@davemloft.net>
In-Reply-To: <Pine.GSO.4.40.0503102050160.27735-100000@ensisun>
References: <Pine.GSO.4.40.0503102050160.27735-100000@ensisun>
X-Mailer: Sylpheed version 1.0.1 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 10 Mar 2005 21:19:24 +0100 (MET)
"emmanuel.colbus@ensimag.imag.fr" <colbuse@ensisun.imag.fr> wrote:

> Therefore, it uses 84 caracters per line, but the VT100 has only 80, so we
> are using two lines instead of only one, shortening the content of the
> (eventual) Oops one could sent.

Nobody really cares, and changing the output format is not a good
idea since automated tools parse this output.
