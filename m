Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262573AbVC2H2g@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262573AbVC2H2g (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Mar 2005 02:28:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262572AbVC2H22
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Mar 2005 02:28:28 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:38816 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S262527AbVC2HQ0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Mar 2005 02:16:26 -0500
Subject: Re: [ubuntu-hardened] Re: Collecting NX information
From: Arjan van de Ven <arjan@infradead.org>
To: John Richard Moser <nigelenki@comcast.net>
Cc: Brandon Hale <brandon@smarterits.com>, ubuntu-hardened@lists.ubuntu.com,
       linux-kernel@vger.kernel.org
In-Reply-To: <4248828B.20708@comcast.net>
References: <42484B13.4060408@comcast.net>
	 <1112035059.6003.44.camel@laptopd505.fenrus.org>
	 <4248520E.1070602@comcast.net>
	 <1112036121.6003.46.camel@laptopd505.fenrus.org>
	 <424857B0.4030302@comcast.net>
	 <1112043246.10117.5.camel@localhost.localdomain>
	 <4248828B.20708@comcast.net>
Content-Type: text/plain
Date: Tue, 29 Mar 2005 09:16:20 +0200
Message-Id: <1112080581.6282.1.camel@laptopd505.fenrus.org>
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


> 
> You need to consider that in the end I'd need PT_GNU_STACK to do
> everything PaX wants

why?
Why not have independent flags for independent things?
That way you have both cleanness of design and you don't break anything.

> The point is
> to not break anything, yet to still make things easier for those
> projects and distributions like Hardened Ubuntu.

to achieve that you need to get the toolchain to omit this stuff
automatically somehow. 

