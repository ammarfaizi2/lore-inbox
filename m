Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261173AbVDDIWQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261173AbVDDIWQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Apr 2005 04:22:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261174AbVDDIWQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Apr 2005 04:22:16 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:50115 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S261173AbVDDIWL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Apr 2005 04:22:11 -0400
Subject: Re: [2.6 patch] kernel/rcupdate.c: make the exports
	EXPORT_SYMBOL_GPL
From: Arjan van de Ven <arjan@infradead.org>
To: paulmck@us.ibm.com
Cc: Adrian Bunk <bunk@stusta.de>, Andrew Morton <akpm@osdl.org>,
       Dipankar Sarma <dipankar@in.ibm.com>,
       Manfred Spraul <manfred@colorfullife.com>, linux-kernel@vger.kernel.org
In-Reply-To: <20050403060200.GA1332@us.ibm.com>
References: <20050327143454.GJ4285@stusta.de>
	 <20050403060200.GA1332@us.ibm.com>
Content-Type: text/plain
Date: Mon, 04 Apr 2005 10:18:24 +0200
Message-Id: <1112602705.6270.33.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-2) 
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

On Sat, 2005-04-02 at 22:02 -0800, Paul E. McKenney wrote:

> These need to be put back.  Moving them to GPL -- but in a measured
> manner, as I proposed on this list some months ago -- is fine.  Changing
> these particular exports precipitously is most definitely -not- fine.
> Here is my earlier proposal:


ok so there is no disagreement that these should become _GPL eventually,
only about the "when". There is agreement also about the expectation
that currently no binary module is using these. Personally I would then
suggest removing them right now (as is done in -bk); the longer you wait
the higher the chance of anyone out there starting to use them and
giving/having a problem a year from now, while the current "damage" is
expected to be zero.



