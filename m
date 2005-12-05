Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751369AbVLEO2c@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751369AbVLEO2c (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Dec 2005 09:28:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751370AbVLEO2c
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Dec 2005 09:28:32 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:4494 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1751369AbVLEO2b (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Dec 2005 09:28:31 -0500
Subject: Re: Kernel BUG at page_alloc.c:117!
From: Arjan van de Ven <arjan@infradead.org>
To: zine el abidine Hamid <zine46@yahoo.fr>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20051205142502.71657.qmail@web30605.mail.mud.yahoo.com>
References: <20051205142502.71657.qmail@web30605.mail.mud.yahoo.com>
Content-Type: text/plain
Date: Mon, 05 Dec 2005 15:28:27 +0100
Message-Id: <1133792907.9356.26.camel@laptopd505.fenrus.org>
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

On Mon, 2005-12-05 at 15:25 +0100, zine el abidine Hamid wrote:
> 
> I have to use the 2.4.18 kernel because We use an
> application which is build on this kernel.

the good news is that userspace applications are not kernel version
specific! At least in general; there are some low level system tools
that sometimes are impacted (these are usually the "kernel helpers" like
the insmod tool or udev). Regular applications work on just about any
kernel; applications written for linux in 1994 still work on 2.6
kernels!

> The module are the next one (lsmod):
> 
> Module                  Size  Used by    Not tainted
> wdpiano                 1920   0  (unused)

what is this?



