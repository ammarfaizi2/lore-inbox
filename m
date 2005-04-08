Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262903AbVDHSCK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262903AbVDHSCK (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Apr 2005 14:02:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262904AbVDHSCJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Apr 2005 14:02:09 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:61888 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S262903AbVDHSCH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Apr 2005 14:02:07 -0400
Subject: Re: [PATCH] restrict inter_module_* to its last users
From: Arjan van de Ven <arjan@infradead.org>
To: Andrew Morton <akpm@osdl.org>
Cc: =?ISO-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>,
       linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org
In-Reply-To: <20050408104826.3ca70fb4.akpm@osdl.org>
References: <20050408170805.GE2292@wohnheim.fh-wedel.de>
	 <20050408104826.3ca70fb4.akpm@osdl.org>
Content-Type: text/plain; charset=UTF-8
Date: Fri, 08 Apr 2005 20:01:59 +0200
Message-Id: <1112983320.6278.80.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-2) 
Content-Transfer-Encoding: 8bit
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

On Fri, 2005-04-08 at 10:48 -0700, Andrew Morton wrote:
> Jörn Engel <joern@wohnheim.fh-wedel.de> wrote:
> >
> > Next step for inter_module removal.  This patch makes the code
> >  conditional on its last users and shrinks the kernel binary for the
> >  huge majority of people.
> 
> If we do this, nobody will get around to fixing up the remaining users.

there is really only one, and how is this making it LESS likely? the
stuff remains deprecated and spews warnings, just like it is now....
just that other mortals now also don't get the kernel bloat...


