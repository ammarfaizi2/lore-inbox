Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750733AbVIJKGG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750733AbVIJKGG (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Sep 2005 06:06:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750736AbVIJKGG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Sep 2005 06:06:06 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:44169 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1750733AbVIJKGF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Sep 2005 06:06:05 -0400
Subject: Re: [GIT PATCH] More PCI patches for 2.6.13
From: Arjan van de Ven <arjan@infradead.org>
To: Greg KH <gregkh@suse.de>
Cc: Linus Torvalds <torvalds@osdl.org>, davej@codemonkey.org.uk,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       linux-pci@atrey.karlin.mff.cuni.cz
In-Reply-To: <20050909225421.GA31433@suse.de>
References: <20050909220758.GA29746@kroah.com>
	 <Pine.LNX.4.58.0509091535180.3051@g5.osdl.org>
	 <20050909225421.GA31433@suse.de>
Content-Type: text/plain
Date: Sat, 10 Sep 2005 12:05:33 +0200
Message-Id: <1126346733.3222.130.camel@laptopd505.fenrus.org>
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

On Fri, 2005-09-09 at 15:54 -0700, Greg KH wrote:
> On Fri, Sep 09, 2005 at 03:37:16PM -0700, Linus Torvalds wrote:
> > 
> > 
> > On Fri, 9 Sep 2005, Greg KH wrote:
> > > 
> > > Dave Jones:
> > >   must_check attributes for PCI layer.
> > 
> > Why?
> 
> This is something that David and Arjan wanted in.  Guys?

The one I cared about is pci_enable_device(); the others I care about a
lot less to not at all. 

