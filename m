Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751216AbVKNS3f@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751216AbVKNS3f (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Nov 2005 13:29:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751227AbVKNS3e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Nov 2005 13:29:34 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:6371 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1751216AbVKNS3e (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Nov 2005 13:29:34 -0500
Subject: Re: [2.6 patch] i386: always use 4k stacks
From: Arjan van de Ven <arjan@infradead.org>
To: Alistair John Strachan <s0348365@sms.ed.ac.uk>
Cc: Dave Jones <davej@redhat.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Alex Davis <alex14641@yahoo.com>, linux-kernel@vger.kernel.org
In-Reply-To: <200511141822.31315.s0348365@sms.ed.ac.uk>
References: <20051114133802.38755.qmail@web50205.mail.yahoo.com>
	 <200511141802.45788.s0348365@sms.ed.ac.uk>
	 <20051114181854.GB3652@redhat.com>
	 <200511141822.31315.s0348365@sms.ed.ac.uk>
Content-Type: text/plain
Date: Mon, 14 Nov 2005 19:29:28 +0100
Message-Id: <1131992968.2821.50.camel@laptopd505.fenrus.org>
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


> LWN has a piece on the possible options, but I suppose you could use the 
> argument that forcibly breaking ndiswrapper will spur new driver development 
> (but if you look at vendors like Broadcom, they have seem consistently 
> unwilling to do this).

there now is a specification for the broadcom wireless, and a driver is
being written right now to that specification; and it seems to be
getting along quite well (it's not ready for primetime use yet but at
least they can send and receive stuff, which is probably the hardest
part)

