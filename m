Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261272AbUL2BOU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261272AbUL2BOU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Dec 2004 20:14:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261273AbUL2BOU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Dec 2004 20:14:20 -0500
Received: from adsl-63-197-226-105.dsl.snfc21.pacbell.net ([63.197.226.105]:34482
	"EHLO cheetah.davemloft.net") by vger.kernel.org with ESMTP
	id S261272AbUL2BOR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Dec 2004 20:14:17 -0500
Date: Tue, 28 Dec 2004 17:12:46 -0800
From: "David S. Miller" <davem@davemloft.net>
To: William Lee Irwin III <wli@holomorphy.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [sunrpc] remove xdr_kmap()
Message-Id: <20041228171246.496f3eab.davem@davemloft.net>
In-Reply-To: <20041228230416.GM771@holomorphy.com>
References: <20041228230416.GM771@holomorphy.com>
X-Mailer: Sylpheed version 1.0.0rc (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 28 Dec 2004 15:04:16 -0800
William Lee Irwin III <wli@holomorphy.com> wrote:

> In this process, I stumbled over a blatant kmap() deadlock in
> xdr_kmap(), which fortunately is never called.

This got zapped by a cleanup patch by Adrian Bunk which
I applied yesterdat.  Linus just hasn't pulled from my
tree yet.
