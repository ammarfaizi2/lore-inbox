Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262998AbVCQEpq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262998AbVCQEpq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Mar 2005 23:45:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262997AbVCQEpq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Mar 2005 23:45:46 -0500
Received: from dsl027-180-174.sfo1.dsl.speakeasy.net ([216.27.180.174]:212
	"EHLO cheetah.davemloft.net") by vger.kernel.org with ESMTP
	id S262998AbVCQEpi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Mar 2005 23:45:38 -0500
Date: Wed, 16 Mar 2005 20:40:20 -0800
From: "David S. Miller" <davem@davemloft.net>
To: Adrian Bunk <bunk@stusta.de>
Cc: netdev@oss.sgi.com, linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] net/ipv4/inetpeer.c: make a struct static
Message-Id: <20050316204020.152b35cc.davem@davemloft.net>
In-Reply-To: <20050317010821.GE3251@stusta.de>
References: <20050315144408.GL3189@stusta.de>
	<20050316145343.6e31ba6a.davem@davemloft.net>
	<20050316145448.5a45dddc.davem@davemloft.net>
	<20050317010821.GE3251@stusta.de>
X-Mailer: Sylpheed version 1.0.1 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 17 Mar 2005 02:08:21 +0100
Adrian Bunk <bunk@stusta.de> wrote:

> inet_peer_unused_tailp might be referenced from other files via 
> inetpeer.h, but inet_peer_unused_head isn't referenced directly from 
> other files.

I misread your patch, I thought you were marking both
as static.  My bad, sorry.

I'll apply your patch, thanks.
