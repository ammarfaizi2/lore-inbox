Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751237AbVJFGQS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751237AbVJFGQS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Oct 2005 02:16:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751238AbVJFGQS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Oct 2005 02:16:18 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:31443 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1751237AbVJFGQR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Oct 2005 02:16:17 -0400
Subject: Re: kernel performance update - 2.6.14-rc3
From: Arjan van de Ven <arjan@infradead.org>
To: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200510052115.j95LFgg07836@unix-os.sc.intel.com>
References: <200510052115.j95LFgg07836@unix-os.sc.intel.com>
Content-Type: text/plain
Date: Thu, 06 Oct 2005 08:16:11 +0200
Message-Id: <1128579372.2960.6.camel@laptopd505.fenrus.org>
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


> dbench is catching some attention.  We just ran it with default
> parameter.  I don't think default parameter is the right one to use
> on some of our configurations.  For example, it shows +100% improvement

never ever consider dbench a serious benchmark; the thing is you can
make dbench a lot better very easy; just make the kernel run one thread
at a time until completion. dbench really gives very variable results,
but it is not really possible to say if +100% or -100% is an improvement
or a degredation for real life. So please just don't run it, or at least
don't interpret the results in a "higher is better" way.

