Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261701AbVAMVDD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261701AbVAMVDD (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jan 2005 16:03:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261683AbVAMU6z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jan 2005 15:58:55 -0500
Received: from canuck.infradead.org ([205.233.218.70]:37892 "EHLO
	canuck.infradead.org") by vger.kernel.org with ESMTP
	id S261688AbVAMU5s (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jan 2005 15:57:48 -0500
Subject: Re: thoughts on kernel security issues
From: Arjan van de Ven <arjan@infradead.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: grendel@caudium.net, Chris Wright <chrisw@osdl.org>,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       Linus Torvalds <torvalds@osdl.org>, Greg KH <greg@kroah.com>,
       akpm@osdl.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1105645267.4644.112.camel@localhost.localdomain>
References: <20050112094807.K24171@build.pdx.osdl.net>
	 <Pine.LNX.4.58.0501121002200.2310@ppc970.osdl.org>
	 <20050112185133.GA10687@kroah.com>
	 <Pine.LNX.4.58.0501121058120.2310@ppc970.osdl.org>
	 <20050112161227.GF32024@logos.cnet>
	 <Pine.LNX.4.58.0501121148240.2310@ppc970.osdl.org>
	 <20050112174203.GA691@logos.cnet>
	 <1105627541.4624.24.camel@localhost.localdomain>
	 <20050113194246.GC24970@beowulf.thanes.org>
	 <20050113115004.Z24171@build.pdx.osdl.net>
	 <20050113202905.GD24970@beowulf.thanes.org>
	 <1105645267.4644.112.camel@localhost.localdomain>
Content-Type: text/plain
Date: Thu, 13 Jan 2005 21:57:17 +0100
Message-Id: <1105649837.6031.54.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3) 
Content-Transfer-Encoding: 7bit
X-Spam-Score: 4.1 (++++)
X-Spam-Report: SpamAssassin version 2.63 on canuck.infradead.org summary:
	Content analysis details:   (4.1 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	0.3 RCVD_NUMERIC_HELO      Received: contains a numeric HELO
	1.1 RCVD_IN_DSBL           RBL: Received via a relay in list.dsbl.org
	[<http://dsbl.org/listing?80.57.133.107>]
	2.5 RCVD_IN_DYNABLOCK      RBL: Sent directly from dynamic IP address
	[80.57.133.107 listed in dnsbl.sorbs.net]
	0.1 RCVD_IN_SORBS          RBL: SORBS: sender is listed in SORBS
	[80.57.133.107 listed in dnsbl.sorbs.net]
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by canuck.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-01-13 at 19:41 +0000, Alan Cox wrote:

> So the non-disclosure argument is perhaps put as "equality of access at
> the point of discovery means everyone gets rooted.". And if you want a
> lot more detail on this read papers on the models of security economics
> - its a well studied field.

or in other words: you can write an exploit faster than y ou can write
the fix, so the thing needs delaying until a fix is available to make it
more equal.


