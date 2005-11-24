Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030565AbVKXH4e@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030565AbVKXH4e (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Nov 2005 02:56:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030571AbVKXH4d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Nov 2005 02:56:33 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:52439 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1030565AbVKXH4c (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Nov 2005 02:56:32 -0500
Subject: Re: [-mm patch] init/main.c: dummy mark_rodata_ro() should be
	static
From: Arjan van de Ven <arjan@infradead.org>
To: Adrian Bunk <bunk@stusta.de>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Ingo Molnar <mingo@elte.hu>
In-Reply-To: <20051123223505.GF3963@stusta.de>
References: <20051123033550.00d6a6e8.akpm@osdl.org>
	 <20051123223505.GF3963@stusta.de>
Content-Type: text/plain
Date: Thu, 24 Nov 2005 08:56:26 +0100
Message-Id: <1132818987.2832.21.camel@laptopd505.fenrus.org>
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

On Wed, 2005-11-23 at 23:35 +0100, Adrian Bunk wrote:
> Every inline dummy function should be static.

that gave a spewload of warnings when I did it in the first place
though.....


