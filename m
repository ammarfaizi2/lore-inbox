Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262433AbVDYCIC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262433AbVDYCIC (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Apr 2005 22:08:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262444AbVDYCIB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Apr 2005 22:08:01 -0400
Received: from dsl027-180-174.sfo1.dsl.speakeasy.net ([216.27.180.174]:61914
	"EHLO cheetah.davemloft.net") by vger.kernel.org with ESMTP
	id S262433AbVDYCH6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Apr 2005 22:07:58 -0400
Date: Sun, 24 Apr 2005 18:59:54 -0700
From: "David S. Miller" <davem@davemloft.net>
To: Jesper Juhl <juhl-lkml@dif.dk>
Cc: linux-kernel@vger.kernel.org, loz@holmes.demon.co.uk,
       waltje@uwalt.nl.mugnet.org, netdev@oss.sgi.com
Subject: Re: [PATCH] net: remove redundant NULL pointer checks prior to
 kfree in drivers/net/slip.c
Message-Id: <20050424185954.7c33ce58.davem@davemloft.net>
In-Reply-To: <Pine.LNX.4.62.0504112311130.2480@dragon.hyggekrogen.localhost>
References: <Pine.LNX.4.62.0504112311130.2480@dragon.hyggekrogen.localhost>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 11 Apr 2005 23:15:40 +0200 (CEST)
Jesper Juhl <juhl-lkml@dif.dk> wrote:

> kfree() checks for NULL. Checking prior to calling it is redundant.
> This patch removes these redundant checks from drivers/net/slip.c
> 
> Signed-off-by: Jesper Juhl <juhl-lkml@dif.dk>

Applied, thanks Jesper.
