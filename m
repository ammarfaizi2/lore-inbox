Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261831AbVECVts@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261831AbVECVts (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 May 2005 17:49:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261830AbVECVtr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 May 2005 17:49:47 -0400
Received: from dsl027-180-174.sfo1.dsl.speakeasy.net ([216.27.180.174]:65513
	"EHLO cheetah.davemloft.net") by vger.kernel.org with ESMTP
	id S261823AbVECVs3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 May 2005 17:48:29 -0400
Date: Tue, 3 May 2005 14:37:26 -0700
From: "David S. Miller" <davem@davemloft.net>
To: Jesper Juhl <juhl-lkml@dif.dk>
Cc: paulus@samba.org, linux-ppp@vger.kernel.org, netdev@oss.sgi.com,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ppp: remove redundant NULL pointer checks before kfree
 & vfree
Message-Id: <20050503143726.63758ce3.davem@davemloft.net>
In-Reply-To: <Pine.LNX.4.62.0504290049240.2476@dragon.hyggekrogen.localhost>
References: <Pine.LNX.4.62.0504290049240.2476@dragon.hyggekrogen.localhost>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 29 Apr 2005 00:54:44 +0200 (CEST)
Jesper Juhl <juhl-lkml@dif.dk> wrote:

> kfree() and vfree() can both deal with NULL pointers. This patch removes 
> redundant NULL pointer checks from the ppp code in drivers/net/
> 
> Signed-off-by: Jesper Juhl <juhl-lkml@dif.dk>

Applied, thanks Jesper.
