Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262344AbVCVGyi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262344AbVCVGyi (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Mar 2005 01:54:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262256AbVCVGvz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Mar 2005 01:51:55 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:40863 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S262340AbVCVGu1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Mar 2005 01:50:27 -0500
Subject: Re: 2.6.12-rc1-mm1
From: Arjan van de Ven <arjan@infradead.org>
To: Jesse Barnes <jbarnes@engr.sgi.com>
Cc: Adrian Bunk <bunk@stusta.de>, Andrew Morton <akpm@osdl.org>,
       arjanv@infradead.org, linux-kernel@vger.kernel.org
In-Reply-To: <200503211642.00796.jbarnes@engr.sgi.com>
References: <20050321025159.1cabd62e.akpm@osdl.org>
	 <200503210915.53193.jbarnes@engr.sgi.com> <20050321202506.GA3982@stusta.de>
	 <200503211642.00796.jbarnes@engr.sgi.com>
Content-Type: text/plain
Date: Tue, 22 Mar 2005 07:50:05 +0100
Message-Id: <1111474205.7096.0.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3) 
Content-Transfer-Encoding: 7bit
X-Spam-Score: 4.1 (++++)
X-Spam-Report: SpamAssassin version 2.63 on pentafluge.infradead.org summary:
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
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-03-21 at 16:42 -0800, Jesse Barnes wrote:
> On Monday, March 21, 2005 12:25 pm, Adrian Bunk wrote:
> > On Mon, Mar 21, 2005 at 09:15:53AM -0800, Jesse Barnes wrote:
> > > On Monday, March 21, 2005 2:51 am, Andrew Morton wrote:
> > > > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.12-rc
> > > >1/2. 6.12-rc1-mm1/
> > >
> > > Andrew, please drop
> > >
> > > revert-allow-oem-written-modules-to-make-calls-to-ia64-oem-sal-functions.
> > >patch
> > >
> > > The tiocx.c driver is now in the tree, and it uses those functions.
> >
> > IOW:
> > The EXPORT_SYMBOL's should still be removed, but the functions
> > themselves should stay.
> 
> Actually, no, since tiocx can be built modular.  The patch should just be 
> dropped.

... or changed so that the exports are _GPL ...


