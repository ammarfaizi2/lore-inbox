Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261817AbVECVol@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261817AbVECVol (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 May 2005 17:44:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261815AbVECVoc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 May 2005 17:44:32 -0400
Received: from dsl027-180-174.sfo1.dsl.speakeasy.net ([216.27.180.174]:2467
	"EHLO cheetah.davemloft.net") by vger.kernel.org with ESMTP
	id S261812AbVECVoE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 May 2005 17:44:04 -0400
Date: Tue, 3 May 2005 14:32:42 -0700
From: "David S. Miller" <davem@davemloft.net>
To: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
Cc: juhl-lkml@dif.dk, netdev@oss.sgi.com, reginak@cyclades.com,
       pc300@cyclades.com, ncorbic@sangoma.com, eis@baty.hanse.de,
       linux-net@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cleanups in drivers/net/wan/ - kfree of NULL pointer is
 valid
Message-Id: <20050503143242.3d06f71f.davem@davemloft.net>
In-Reply-To: <20050428222330.GI26945@conectiva.com.br>
References: <Pine.LNX.4.62.0504290009310.2476@dragon.hyggekrogen.localhost>
	<20050428222330.GI26945@conectiva.com.br>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 28 Apr 2005 19:23:30 -0300
Arnaldo Carvalho de Melo <acme@conectiva.com.br> wrote:

> Em Fri, Apr 29, 2005 at 12:22:22AM +0200, Jesper Juhl escreveu:
> > kfree(0) is perfectly valid, checking pointers for NULL before calling 
> > kfree() on them is redundant. The patch below cleans away a few such 
> > redundant checks (and while I was around some of those bits I couldn't 
> > stop myself from making a few tiny whitespace changes as well).
> 
> 
> Acked-by: Arnaldo Carvalho de MElo <acme@ghostprotocols.net>

Applied, thanks everyone.

