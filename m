Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262013AbVANPxE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262013AbVANPxE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Jan 2005 10:53:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262014AbVANPxE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Jan 2005 10:53:04 -0500
Received: from canuck.infradead.org ([205.233.218.70]:10513 "EHLO
	canuck.infradead.org") by vger.kernel.org with ESMTP
	id S262013AbVANPxB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Jan 2005 10:53:01 -0500
Subject: Re: thoughts on kernel security issues
From: Arjan van de Ven <arjan@infradead.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Horst von Brand <vonbrand@inf.utfsm.cl>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Christoph Hellwig <hch@infradead.org>, Dave Jones <davej@redhat.com>,
       Andrew Morton <akpm@osdl.org>, marcelo.tosatti@cyclades.com,
       Greg KH <greg@kroah.com>, chrisw@osdl.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.58.0501140731450.2310@ppc970.osdl.org>
References: <200501141239.j0ECdaRj005677@laptop11.inf.utfsm.cl>
	 <Pine.LNX.4.58.0501140731450.2310@ppc970.osdl.org>
Content-Type: text/plain
Date: Fri, 14 Jan 2005 16:52:23 +0100
Message-Id: <1105717943.6042.31.camel@laptopd505.fenrus.org>
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

On Fri, 2005-01-14 at 07:45 -0800, Linus Torvalds wrote:
> 
> Alan's point about perl is well taken, though. Perl is a pretty damn 
> generic interpreter, and unlike most interpreters exposes everything.
> And 
> I doubt it uses "mmap(.. PROT_EXEC)" to map in the file ;)

you can feed it via stdin, I doubt it mmaps stdin that way for sure ;)


