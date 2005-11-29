Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932338AbVK2SnE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932338AbVK2SnE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Nov 2005 13:43:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932342AbVK2SnE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Nov 2005 13:43:04 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:63391 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932338AbVK2SnC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Nov 2005 13:43:02 -0500
Subject: Re: Linux 2.6.15-rc3 - gcc-4.0.2 compile error
From: Arjan van de Ven <arjan@infradead.org>
To: Byron Stanoszek <gandalf@winds.org>
Cc: linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.63.0511291321380.9526@winds.org>
References: <Pine.LNX.4.64.0511282006370.3177@g5.osdl.org>
	 <438C0124.3030700@m1k.net> <Pine.LNX.4.64.0511290808510.3177@g5.osdl.org>
	 <438C80DD.7050809@m1k.net> <Pine.LNX.4.64.0511290835220.3177@g5.osdl.org>
	 <20051129172534.GA4514@pe.Belkin>
	 <Pine.LNX.4.63.0511291321380.9526@winds.org>
Content-Type: text/plain
Date: Tue, 29 Nov 2005 19:42:56 +0100
Message-Id: <1133289777.2804.58.camel@laptopd505.fenrus.org>
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

On Tue, 2005-11-29 at 13:37 -0500, Byron Stanoszek wrote:
> Just reporting a compile error with gcc-4.0.2 on i386. Below is the error. My
> .config is attached. The error only appears at the very end of the vmlinux
> linking stage.

this is a known gcc bug that already got fixed..... (it's in gcc
bugzilla for a while)

