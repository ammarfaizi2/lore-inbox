Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030559AbVKXHqO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030559AbVKXHqO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Nov 2005 02:46:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030563AbVKXHqO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Nov 2005 02:46:14 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:51113 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1030517AbVKXHqM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Nov 2005 02:46:12 -0500
Subject: Re: [NET]: Shut up warnings in net/core/flow.c
From: Arjan van de Ven <arjan@infradead.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: "David S. Miller" <davem@davemloft.net>, akpm@osdl.org,
       linux-kernel@vger.kernel.org, rmk@arm.linux.org.uk, ak@muc.de
In-Reply-To: <Pine.LNX.4.64.0511231526340.13959@g5.osdl.org>
References: <20051123002134.287ff226.akpm@osdl.org>
	 <20051123.005530.17893365.davem@davemloft.net>
	 <Pine.LNX.4.64.0511230849380.13959@g5.osdl.org>
	 <20051123.152031.02282381.davem@davemloft.net>
	 <Pine.LNX.4.64.0511231526340.13959@g5.osdl.org>
Content-Type: text/plain
Date: Thu, 24 Nov 2005 08:46:07 +0100
Message-Id: <1132818368.2832.19.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-Spam-Score: 1.8 (+)
X-Spam-Report: SpamAssassin version 3.0.4 on pentafluge.infradead.org summary:
	Content analysis details:   (1.8 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	0.1 RCVD_IN_SORBS_DUL      RBL: SORBS: sent directly from dynamic IP address
	[213.93.14.173 listed in dnsbl.sorbs.net]
	1.7 RCVD_IN_NJABL_DUL      RBL: NJABL: dialup sender did non-local SMTP
	[213.93.14.173 listed in combined.njabl.org]
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Quite frankly, every time we rely on some really smart gcc feature, we're 
> burnt.


-ffunction-sections is a linker feature though ;)


