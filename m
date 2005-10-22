Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751334AbVJVNzk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751334AbVJVNzk (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 22 Oct 2005 09:55:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751271AbVJVNzk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 22 Oct 2005 09:55:40 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:41703 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1751254AbVJVNzj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 22 Oct 2005 09:55:39 -0400
Subject: Re: interrupts are not shared between CPUs in 2.6.14-rc3
From: Arjan van de Ven <arjan@infradead.org>
To: cijoml@volny.cz
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200510221516.59343.cijoml@volny.cz>
References: <200510221516.59343.cijoml@volny.cz>
Content-Type: text/plain
Date: Sat, 22 Oct 2005 15:55:29 +0200
Message-Id: <1129989329.2775.7.camel@laptopd505.fenrus.org>
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

On Sat, 2005-10-22 at 15:16 +0200, Michal Semler wrote:
> Hi,
> 
> I have upgraded from 2.4.31 to 2.6.14-rc3 and see, that all interrupts are 
> handled by CPU0. In 2.4 Both CPUs take care. Pls fix that:

you want to install the irqbalance debian package.... 


