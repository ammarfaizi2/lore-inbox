Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262739AbVCWCts@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262739AbVCWCts (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Mar 2005 21:49:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262726AbVCWCtp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Mar 2005 21:49:45 -0500
Received: from dsl027-180-174.sfo1.dsl.speakeasy.net ([216.27.180.174]:33732
	"EHLO cheetah.davemloft.net") by vger.kernel.org with ESMTP
	id S262723AbVCWCtj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Mar 2005 21:49:39 -0500
Date: Tue, 22 Mar 2005 18:47:50 -0800
From: "David S. Miller" <davem@davemloft.net>
To: Jesper Juhl <juhl-lkml@dif.dk>
Cc: netdev@oss.sgi.com, obz@Kodak.COM, bir7@leland.Stanford.Edu,
       waltje@uWalt.NL.Mugnet.ORG, linux-net@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net/socket.c : remove redundant NULL pointer check
 before kfree()
Message-Id: <20050322184750.4ec7a51c.davem@davemloft.net>
In-Reply-To: <Pine.LNX.4.62.0503172028030.2512@dragon.hyggekrogen.localhost>
References: <Pine.LNX.4.62.0503172028030.2512@dragon.hyggekrogen.localhost>
X-Mailer: Sylpheed version 1.0.1 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 17 Mar 2005 20:34:05 +0100 (CET)
Jesper Juhl <juhl-lkml@dif.dk> wrote:

> kfree() handles NULL pointers just fine, checking first is pointless.
> 
> Signed-off-by: Jesper Juhl <juhl-lkml@dif.dk>

Applied, thanks Jesper.
