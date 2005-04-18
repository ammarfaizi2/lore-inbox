Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262194AbVDRUFv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262194AbVDRUFv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Apr 2005 16:05:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262195AbVDRUFv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Apr 2005 16:05:51 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:21980 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S262194AbVDRUFq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Apr 2005 16:05:46 -0400
Subject: Re: [PATCH][RFC][0/4] InfiniBand userspace verbs implementation
From: Arjan van de Ven <arjan@infradead.org>
To: Timur Tabi <timur.tabi@ammasso.com>
Cc: Roland Dreier <roland@topspin.com>, Troy Benjegerdes <hozer@hozed.org>,
       linux-kernel@vger.kernel.org, openib-general@openib.org
In-Reply-To: <426411C2.5040703@ammasso.com>
References: <200544159.Ahk9l0puXy39U6u6@topspin.com>
	 <20050411142213.GC26127@kalmia.hozed.org> <52mzs51g5g.fsf@topspin.com>
	 <4263DBBF.9040801@ammasso.com>
	 <1113840973.6274.84.camel@laptopd505.fenrus.org>
	 <4263DF70.2060702@ammasso.com>
	 <1113853240.6274.99.camel@laptopd505.fenrus.org>
	 <426411C2.5040703@ammasso.com>
Content-Type: text/plain
Date: Mon, 18 Apr 2005 22:05:42 +0200
Message-Id: <1113854742.6274.101.camel@laptopd505.fenrus.org>
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

On Mon, 2005-04-18 at 15:00 -0500, Timur Tabi wrote:
> Arjan van de Ven wrote:
> 
> > you should since that physical page can be reused, say by a root
> > process, and you'd be majorly screwed
> 
> I don't understand what you mean by "reused".  The whole point behind pinning the memory 
> is that it stays where it is.  It doesn't get moved around and it doesn't get swapped out.
> 
you just said that you didn't care that it got munlock'd. So you don't
care that it gets freed either. And then reused.


