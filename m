Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751091AbVHOMZ7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751091AbVHOMZ7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Aug 2005 08:25:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751092AbVHOMZ6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Aug 2005 08:25:58 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:35767 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1751091AbVHOMZ5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Aug 2005 08:25:57 -0400
Subject: Re: [-mm patch] make kcalloc() a static inline
From: Arjan van de Ven <arjan@infradead.org>
To: Denis Vlasenko <vda@ilport.com.ua>
Cc: Pekka J Enberg <penberg@cs.Helsinki.FI>, Adrian Bunk <bunk@stusta.de>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
In-Reply-To: <200508151517.52171.vda@ilport.com.ua>
References: <20050808223842.GM4006@stusta.de>
	 <200508151233.46523.vda@ilport.com.ua>
	 <1124098918.3228.25.camel@laptopd505.fenrus.org>
	 <200508151517.52171.vda@ilport.com.ua>
Content-Type: text/plain
Date: Mon, 15 Aug 2005 14:25:37 +0200
Message-Id: <1124108737.3228.35.camel@laptopd505.fenrus.org>
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

On Mon, 2005-08-15 at 15:17 +0300, Denis Vlasenko wrote:

> Seems like that optimization is not helping.
> Do you have better example?

you need gcc 4.1 (eg CVS) for the value range propagation stuff.


