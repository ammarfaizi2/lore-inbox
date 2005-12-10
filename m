Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161017AbVLJSLR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161017AbVLJSLR (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Dec 2005 13:11:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161018AbVLJSLQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Dec 2005 13:11:16 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:32454 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1161017AbVLJSLQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Dec 2005 13:11:16 -0500
Subject: Re: IRQ vector assignment for system call exception
From: Arjan van de Ven <arjan@infradead.org>
To: Gaurav Dhiman <gaurav4lkg@gmail.com>
Cc: yen <yen@eos.cs.nthu.edu.tw>, linux-kernel@vger.kernel.org
In-Reply-To: <1e33f5710512100520k57c016b0tadfbb496cac3ea6e@mail.gmail.com>
References: <20051208080435.M54890@eos.cs.nthu.edu.tw>
	 <1e33f5710512100520k57c016b0tadfbb496cac3ea6e@mail.gmail.com>
Content-Type: text/plain
Date: Sat, 10 Dec 2005 19:11:11 +0100
Message-Id: <1134238271.2828.19.camel@laptopd505.fenrus.org>
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

On Sat, 2005-12-10 at 18:50 +0530, Gaurav Dhiman wrote:
> yes, definetely a historical reason. System libraries need to know
> this vector to invoke system call.

nowadays it's also mostly unused; sysenter and friends are used instead
and they don't use this entry point.


