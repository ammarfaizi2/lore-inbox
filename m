Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262917AbVCDNaP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262917AbVCDNaP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Mar 2005 08:30:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262916AbVCDNaK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Mar 2005 08:30:10 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:61652 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S262890AbVCDN2a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Mar 2005 08:28:30 -0500
Subject: Re: [2.6 patch] unexport uts_sem
From: Arjan van de Ven <arjan@infradead.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Adrian Bunk <bunk@stusta.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1109941076.29932.24.camel@localhost.localdomain>
References: <20050304005001.GA4608@stusta.de>
	 <1109941076.29932.24.camel@localhost.localdomain>
Content-Type: text/plain
Date: Fri, 04 Mar 2005 14:28:18 +0100
Message-Id: <1109942899.6293.90.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3) 
Content-Transfer-Encoding: 7bit
X-Spam-Score: 4.1 (++++)
X-Spam-Report: SpamAssassin version 2.63 on pentafluge.infradead.org summary:
	Content analysis details:   (4.1 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	0.3 RCVD_NUMERIC_HELO      Received: contains a numeric HELO
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

On Fri, 2005-03-04 at 12:57 +0000, Alan Cox wrote:
> On Gwe, 2005-03-04 at 00:50, Adrian Bunk wrote:
> > I didn't find any possible modular usage in the kernel.
> 
> Sure ? This used to be exported for loadable modules that wanted to get
> the system default hostname string and for emulation layers like xabi
> (the SYS5 unix emulation lib)

afaik the linux abi stuff never made the jump to 2.6, and is far from
likely to do so...


