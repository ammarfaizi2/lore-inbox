Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265531AbUKBBCN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265531AbUKBBCN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Nov 2004 20:02:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264074AbUKBA4j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Nov 2004 19:56:39 -0500
Received: from adsl-63-197-226-105.dsl.snfc21.pacbell.net ([63.197.226.105]:55992
	"EHLO cheetah.davemloft.net") by vger.kernel.org with ESMTP
	id S386151AbUKBAoX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Nov 2004 19:44:23 -0500
Date: Mon, 1 Nov 2004 16:31:00 -0800
From: "David S. Miller" <davem@davemloft.net>
To: Adrian Bunk <bunk@stusta.de>
Cc: coreteam@netfilter.org, marc@mbsi.ca, netfilter-devel@lists.netfilter.org,
       netdev@oss.sgi.com, linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] netfilter/ipt_tcpmss.c: remove an unused function
Message-Id: <20041101163100.60e737ff.davem@davemloft.net>
In-Reply-To: <20041029002113.GP29142@stusta.de>
References: <20041028230202.GV3207@stusta.de>
	<20041029002113.GP29142@stusta.de>
X-Mailer: Sylpheed version 0.9.99 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 29 Oct 2004 02:21:13 +0200
Adrian Bunk <bunk@stusta.de> wrote:

> The patch below removes an unused function from 
> net/ipv4/netfilter/ipt_tcpmss.c

Applied, thanks Adrian.  This one is probably due to cut&paste
from ipt_TCPMSS.c where this inline is also implemented and also
actually used :-)
