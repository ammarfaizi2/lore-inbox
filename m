Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261593AbVFZVBC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261593AbVFZVBC (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Jun 2005 17:01:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261596AbVFZVBC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Jun 2005 17:01:02 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:43143 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S261597AbVFZU7y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Jun 2005 16:59:54 -0400
Subject: Re: [RFC] SPI core -- revisited
From: Arjan van de Ven <arjan@infradead.org>
To: Alexey Dobriyan <adobriyan@gmail.com>
Cc: dpervushin@ru.mvista.com, linux-kernel@vger.kernel.org
In-Reply-To: <200506270049.10970.adobriyan@gmail.com>
References: <20050626193621.8B8E44C4D1@abc.pervushin.pp.ru>
	 <200506270049.10970.adobriyan@gmail.com>
Content-Type: text/plain
Date: Sun, 26 Jun 2005 22:59:40 +0200
Message-Id: <1119819580.3215.47.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
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

> %p was invented for pointers.
> 
> > +unsigned long pnx_copy_from_user(void *to, const void *from_user, 
> 
> const void __user *from, I believe.
> 
> > +unsigned long pnx_copy_to_user(void *to_user, const void *from,
> 

> const void __user *to.
> -


... or just kill the wrappers entirely!


