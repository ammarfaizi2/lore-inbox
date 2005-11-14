Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751219AbVKNSMS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751219AbVKNSMS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Nov 2005 13:12:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751218AbVKNSMS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Nov 2005 13:12:18 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:7405 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1751219AbVKNSMR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Nov 2005 13:12:17 -0500
Subject: Re: [2.6 patch] i386: always use 4k stacks
From: Arjan van de Ven <arjan@infradead.org>
To: Alistair John Strachan <s0348365@sms.ed.ac.uk>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Alex Davis <alex14641@yahoo.com>,
       linux-kernel@vger.kernel.org
In-Reply-To: <200511141802.45788.s0348365@sms.ed.ac.uk>
References: <20051114133802.38755.qmail@web50205.mail.yahoo.com>
	 <1131979779.5751.17.camel@localhost.localdomain>
	 <200511141802.45788.s0348365@sms.ed.ac.uk>
Content-Type: text/plain
Date: Mon, 14 Nov 2005 19:12:09 +0100
Message-Id: <1131991930.2821.46.camel@laptopd505.fenrus.org>
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


> I honestly don't know if this is the case, but is it conceivable that no patch 
> could be written to resolve this, because the Windows drivers themselves only 
> respect Windows stack limits (which are presumably still 8K?).

afaik Windows has 12k or 16k stacks.


