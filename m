Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262406AbUJFPp7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262406AbUJFPp7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Oct 2004 11:45:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269289AbUJFPpx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Oct 2004 11:45:53 -0400
Received: from adsl-63-197-226-105.dsl.snfc21.pacbell.net ([63.197.226.105]:36499
	"EHLO cheetah.davemloft.net") by vger.kernel.org with ESMTP
	id S262406AbUJFPnW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Oct 2004 11:43:22 -0400
Date: Wed, 6 Oct 2004 08:42:42 -0700
From: "David S. Miller" <davem@davemloft.net>
To: root@chaos.analogic.com
Cc: joris@eljakim.nl, linux-kernel@vger.kernel.org
Subject: Re: UDP recvmsg blocks after select(), 2.6 bug?
Message-Id: <20041006084242.3443b2de.davem@davemloft.net>
In-Reply-To: <Pine.LNX.4.61.0410061124110.31091@chaos.analogic.com>
References: <Pine.LNX.4.58.0410061616420.22221@eljakim.netsystem.nl>
	<20041006080104.76f862e6.davem@davemloft.net>
	<Pine.LNX.4.61.0410061110260.6661@chaos.analogic.com>
	<20041006082145.7b765385.davem@davemloft.net>
	<Pine.LNX.4.61.0410061124110.31091@chaos.analogic.com>
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 6 Oct 2004 11:29:22 -0400 (EDT)
"Richard B. Johnson" <root@chaos.analogic.com> wrote:

> Somebody else responded that a bad checksum could do the same
> thing --not. Select must return correct information.

Guess what, our UDP implementation does exactly that
and has done so for years.  It's perfectly fine.
