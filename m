Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030578AbVKXH5H@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030578AbVKXH5H (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Nov 2005 02:57:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030571AbVKXH5G
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Nov 2005 02:57:06 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:54231 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1030573AbVKXH5E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Nov 2005 02:57:04 -0500
Subject: Re: [-mm patch] dummy mark_rodata_ro() should be static
From: Arjan van de Ven <arjan@infradead.org>
To: Adrian Bunk <bunk@stusta.de>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Ingo Molnar <mingo@elte.hu>
In-Reply-To: <20051124051405.GO3963@stusta.de>
References: <20051123033550.00d6a6e8.akpm@osdl.org>
	 <20051123223505.GF3963@stusta.de>  <20051124051405.GO3963@stusta.de>
Content-Type: text/plain
Date: Thu, 24 Nov 2005 08:56:59 +0100
Message-Id: <1132819019.2832.23.camel@laptopd505.fenrus.org>
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

On Thu, 2005-11-24 at 06:14 +0100, Adrian Bunk wrote:
> On Wed, Nov 23, 2005 at 11:35:05PM +0100, Adrian Bunk wrote:
> 
> > Every inline dummy function should be static.
> >...
> 
> Sorry, the patch was incomplete.

ok I was trying to avoid the ifdefs... if you add the ifdefs you might
as well put the dummy in the header too in a #else clause.


