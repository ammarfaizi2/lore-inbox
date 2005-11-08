Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965142AbVKHNIO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965142AbVKHNIO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Nov 2005 08:08:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965147AbVKHNIO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Nov 2005 08:08:14 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:9369 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S965142AbVKHNIN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Nov 2005 08:08:13 -0500
Subject: Re: [PATCH] i386: export genapic again
From: Arjan van de Ven <arjan@infradead.org>
To: Jan Beulich <JBeulich@novell.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <4370AEE1.76F0.0078.0@novell.com>
References: <4370AEE1.76F0.0078.0@novell.com>
Content-Type: text/plain
Date: Tue, 08 Nov 2005 14:08:09 +0100
Message-Id: <1131455290.2789.15.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-Spam-Score: 2.9 (++)
X-Spam-Report: SpamAssassin version 3.0.4 on pentafluge.infradead.org summary:
	Content analysis details:   (2.9 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	0.1 RCVD_IN_SORBS_DUL      RBL: SORBS: sent directly from dynamic IP address
	[80.57.133.107 listed in dnsbl.sorbs.net]
	2.8 RCVD_IN_DSBL           RBL: Received via a relay in list.dsbl.org
	[<http://dsbl.org/listing?80.57.133.107>]
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-11-08 at 13:57 +0100, Jan Beulich wrote:
> A change not too long ago made i386's genapic symbol no longer be
> exported, and thus certain low-level functions no longer be usable.
> Since close-to-the-hardware code may still be modular, this
> rectifies the situation.
> 
> From: Jan Beulich <jbeulich@novell.com>
> 
> (actual patch attached)
> 

+#define APIC_DEFINITION 1

what is that for?


