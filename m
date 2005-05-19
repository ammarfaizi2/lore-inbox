Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261182AbVESRl6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261182AbVESRl6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 May 2005 13:41:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261184AbVESRlq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 May 2005 13:41:46 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:59032 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S261182AbVESRlC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 May 2005 13:41:02 -0400
Subject: Re: [PATCH 2.6.12-rc4] Add EXPORT_SYMBOL for hotplug_path
From: Arjan van de Ven <arjan@infradead.org>
To: Tom Rini <trini@kernel.crashing.org>
Cc: Andrew Morton <akpm@osdl.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20050519164323.GK3771@smtp.west.cox.net>
References: <20050519164323.GK3771@smtp.west.cox.net>
Content-Type: text/plain
Date: Thu, 19 May 2005 19:40:29 +0200
Message-Id: <1116524429.6027.55.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Content-Transfer-Encoding: 7bit
X-Spam-Score: 3.7 (+++)
X-Spam-Report: SpamAssassin version 2.63 on pentafluge.infradead.org summary:
	Content analysis details:   (3.7 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	1.1 RCVD_IN_DSBL           RBL: Received via a relay in list.dsbl.org
	[<http://dsbl.org/listing?80.57.133.107>]
	2.5 RCVD_IN_DYNABLOCK      RBL: Sent directly from dynamic IP address
	[80.57.133.107 listed in dnsbl.sorbs.net]
	0.1 RCVD_IN_SORBS          RBL: SORBS: sender is listed in SORBS
	[80.57.133.107 listed in dnsbl.sorbs.net]
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-05-19 at 09:43 -0700, Tom Rini wrote:
> If CONFIG_INPUT is set as a module, it will not load as hotplug_path is
> not a defined symbol.  Trivial fix is to EXPORT_SYMBOL hotplug_path.

shouldn't this be a _GPL export since it's quite internal to linux...


