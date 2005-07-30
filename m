Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261655AbVGaKLv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261655AbVGaKLv (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 31 Jul 2005 06:11:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261667AbVGaKLv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Jul 2005 06:11:51 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:64914 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S261655AbVGaKLu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Jul 2005 06:11:50 -0400
Subject: Re: Slowdown with randomize_va_space in 2.6.12.2
From: Arjan van de Ven <arjan@infradead.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Eric Lammerts <eric@lammerts.org>, davej@redhat.com, davem@davemloft.net,
       pmarques@grupopie.com, linux-kernel@vger.kernel.org
In-Reply-To: <20050729182029.68748c9f.akpm@osdl.org>
References: <42CBE97C.2060208@grupopie.com>
	 <20050706.125719.08321870.davem@davemloft.net>
	 <20050706205315.GC27630@redhat.com> <20050706181220.3978d7f6.akpm@osdl.org>
	 <1120718229.3198.8.camel@laptopd505.fenrus.org>
	 <Pine.LNX.4.58.0507292040530.1819@vivaldi.madbase.net>
	 <20050729182029.68748c9f.akpm@osdl.org>
Content-Type: text/plain
Date: Sat, 30 Jul 2005 07:49:13 -0400
Message-Id: <1122724153.3388.10.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
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


> 
> It has the virtue of simplicity.  Arjan, were you planning on anything
> fancier?

short term: no. (eg 2.6.13).
Long term I wanted to turn this into a bitmask so that you can control
the randomisations individual (eg keep the stack one disable the library
one only)

