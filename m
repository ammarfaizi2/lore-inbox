Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262227AbVDFPUd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262227AbVDFPUd (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Apr 2005 11:20:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262228AbVDFPUc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Apr 2005 11:20:32 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:62353 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S262227AbVDFPU0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Apr 2005 11:20:26 -0400
Subject: Re: [LTP] Re: [ANNOUNCE] April Release of LTP now Available
From: Arjan van de Ven <arjan@infradead.org>
To: Dan Kegel <dank@kegel.com>
Cc: Andrew Morton <akpm@osdl.org>, Marty Ridgeway <mridge@us.ibm.com>,
       linux-kernel@vger.kernel.org, ltp-list@lists.sourceforge.net,
       ltp-announce@lists.sourceforge.net
In-Reply-To: <4253FAC3.5010000@kegel.com>
References: <OF98479217.2360E20E-ON85256FDA.00696BC9-86256FDA.00698E70@us.ibm.com>
	 <20050406043001.3f3d7c1c.akpm@osdl.org>  <4253FAC3.5010000@kegel.com>
Content-Type: text/plain
Date: Wed, 06 Apr 2005 17:20:14 +0200
Message-Id: <1112800815.6275.86.camel@laptopd505.fenrus.org>
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

On Wed, 2005-04-06 at 08:05 -0700, Dan Kegel wrote:
> Andrew Morton wrote:
> >> LTP-20050405
> > 
> > It seems to have an x86ism in it which causes the compile to fail on ppc64:
> > 
> > socketcall01.c: In function `socketcall':
> > socketcall01.c:80: error: asm-specifier for variable `__sc_4' conflicts with asm clobber list
> 
> That might be a problem with your toolchain.

I wonder why ltp doesn't just use the normal syscall() macro/functions
but instead insists on using stuff from kernel headers...


