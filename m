Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932211AbVLDNFY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932211AbVLDNFY (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Dec 2005 08:05:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932217AbVLDNFY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Dec 2005 08:05:24 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:4242 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932211AbVLDNFY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Dec 2005 08:05:24 -0500
Subject: Re: RFC: Starting a stable kernel series off the 2.6 kernel
From: Arjan van de Ven <arjan@infradead.org>
To: Indrek Kruusa <indrek.kruusa@tuleriit.ee>
Cc: Adrian Bunk <bunk@stusta.de>, linux-kernel@vger.kernel.org
In-Reply-To: <4392E79B.7080903@tuleriit.ee>
References: <20051203135608.GJ31395@stusta.de>
	 <4392E79B.7080903@tuleriit.ee>
Content-Type: text/plain
Date: Sun, 04 Dec 2005 14:05:20 +0100
Message-Id: <1133701520.5188.34.camel@laptopd505.fenrus.org>
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

> nt model (or at least they have no resources to 
> do testing [Torvalds])
> c) end-users (or those who are not kernel maintainers) are directed 
> permanently to distros kernels and "stay away from kernel.org you 
> wanna-bees!

this is not what is being said. What is being said is that if you can't
deal with occasional breakage, you're better off using vendor kernels.
But.. if you can't deal with occasional breakage, you wouldn't test test
kernels EITHER. If you can deal with an occasional breakage, I hope you
and everyone else who can, will run and test kernel.org kernels,
especially the -rc ones. 

Most of the "instability" people complain about with the new 2.6 model
is caused by people not testing the -rc kernels before they are
released, so that they end up being released with regressions. But...
that will happen no matter what model you use actually. Before july
there was a problem where -rc kernels kept changing bigtime, so it was
hard to know which one to test if you only had time to test one, but
that is now changed... 

Maybe it's a bit extremist, but I'd like to even state it like this:
"If you can't be bothered to test -rc kernels, you have no right to
complain about the final ones", sort of as analogy to the "if you don't
go voting you have no right to complain about the politicians".


