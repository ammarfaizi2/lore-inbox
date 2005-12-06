Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750728AbVLFIDi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750728AbVLFIDi (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Dec 2005 03:03:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750736AbVLFIDi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Dec 2005 03:03:38 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:22735 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1750728AbVLFIDh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Dec 2005 03:03:37 -0500
Subject: Re: Help track a memory leak in 2.6.0..14
From: Arjan van de Ven <arjan@infradead.org>
To: Kalin KOZHUHAROV <kalin@thinrope.net>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <43954489.5040309@thinrope.net>
References: <43954489.5040309@thinrope.net>
Content-Type: text/plain
Date: Tue, 06 Dec 2005 09:03:34 +0100
Message-Id: <1133856214.2858.13.camel@laptopd505.fenrus.org>
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


> Who uses that memory?

the programs

slabtop
xrestop
cat /proc/meminfo

are probably good starting points to find the leak; they give a detailed
overview of various memory pools

