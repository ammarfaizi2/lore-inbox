Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268039AbUIGUYo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268039AbUIGUYo (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Sep 2004 16:24:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268346AbUIGUWv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Sep 2004 16:22:51 -0400
Received: from verein.lst.de ([213.95.11.210]:61855 "EHLO mail.lst.de")
	by vger.kernel.org with ESMTP id S268039AbUIGUAy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Sep 2004 16:00:54 -0400
Date: Tue, 7 Sep 2004 22:00:49 +0200
From: Christoph Hellwig <hch@lst.de>
To: "Randy.Dunlap" <rddunlap@osdl.org>, Christoph Hellwig <hch@lst.de>,
       alan@lxorguk.ukuu.org.uk, akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mark install_page static
Message-ID: <20040907200049.GA14413@lst.de>
Mail-Followup-To: Christoph Hellwig <hch@lst.de>,
	"Randy.Dunlap" <rddunlap@osdl.org>, alan@lxorguk.ukuu.org.uk,
	akpm@osdl.org, linux-kernel@vger.kernel.org
References: <20040907143741.GA8606@lst.de> <1094576968.9599.9.camel@localhost.localdomain> <20040907181259.GA12654@lst.de> <20040907121443.68c5c3b8.rddunlap@osdl.org> <20040907215849.GB11238@mars.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040907215849.GB11238@mars.ravnborg.org>
User-Agent: Mutt/1.3.28i
X-Spam-Score: -4.901 () BAYES_00
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 07, 2004 at 11:58:49PM +0200, Sam Ravnborg wrote:
> On Tue, Sep 07, 2004 at 12:14:43PM -0700, Randy.Dunlap wrote:
> > On Tue, 7 Sep 2004 20:12:59 +0200 Christoph Hellwig wrote:
> > 
> > | On Tue, Sep 07, 2004 at 06:09:29PM +0100, Alan Cox wrote:
> > | > On Maw, 2004-09-07 at 15:37, Christoph Hellwig wrote:
> > | > > Not used anywhere in modules and it really shouldn't either.
> > | > 
> > | > Doesn't that happen (conveniently from some viewpoints Im sure) to break
> > | > vmware ?
> > | 
> > | It happens because Arjan & I wrote up some scripts to find dead exports.
> > 
> > Can you put those at kernelnewbies.org or janitor.kernelnewbies.org ?
> 
> Keith Ownes 'namespacecheck' flags unused exported symbols as well.
> And furthermore unused non-static definitions.

Well, to get halfway reliable data you need to merge the data from
multiple architectures.  And then do lots of manual grepping for
every instance to be sure.

