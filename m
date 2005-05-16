Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261653AbVEPOC7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261653AbVEPOC7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 May 2005 10:02:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261662AbVEPOC7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 May 2005 10:02:59 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:56237 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S261653AbVEPOCo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 May 2005 10:02:44 -0400
Subject: Re: Linux does not care for data integrity (was: Disk write cache)
From: Arjan van de Ven <arjan@infradead.org>
To: Matthias Andree <matthias.andree@gmx.de>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20050516112956.GC13387@merlin.emma.line.org>
References: <Pine.LNX.4.58.0505151657230.19181@artax.karlin.mff.cuni.cz>
	 <200505151121.36243.gene.heskett@verizon.net>
	 <20050515152956.GA25143@havoc.gtf.org>
	 <20050516.012740.93615022.okuyamak@dd.iij4u.or.jp>
	 <42877C1B.2030008@pobox.com> <20050516110203.GA13387@merlin.emma.line.org>
	 <1116241957.6274.36.camel@laptopd505.fenrus.org>
	 <20050516112956.GC13387@merlin.emma.line.org>
Content-Type: text/plain
Date: Mon, 16 May 2005 16:02:37 +0200
Message-Id: <1116252157.6274.41.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
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

On Mon, 2005-05-16 at 13:29 +0200, Matthias Andree wrote:
> On Mon, 16 May 2005, Arjan van de Ven wrote:
> 
> > I think you missed the part where disabling the writecache decreases the
> > mtbf of your disk by like a factor 100 or so. At which point your
> > dataloss opportunity INCREASES by doing this.
> 
> Nah, if that were a factor of 100, then it should have been in the OEM
> manuals, no?

Why would they? Windows doesn't do it.  They only need to advertise MTBF
in the default settings (and I guess in Windows).

They do talk about this if you ask them.

>  So?

one sample doesn't prove the statistics are wrong.

> 
> > Sure you can waive rethorics around, but the fact is that linux is
> > improving; there now is write barrier support for ext3 (and I assume
> > reiserfs) for at least IDE and iirc selected scsi too. 
> 
> See the problem: "I assume", "IIRC selected...". There is no
> list of corroborated facts which systems work and which don't. I have
> made several attempts in compiling one, posting public calls for data
> here, no response.

well what stops you from building that list yourself by doing the actual
work yourself?


