Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262081AbUK3SZj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262081AbUK3SZj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Nov 2004 13:25:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262236AbUK3SZi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Nov 2004 13:25:38 -0500
Received: from canuck.infradead.org ([205.233.218.70]:3336 "EHLO
	canuck.infradead.org") by vger.kernel.org with ESMTP
	id S262081AbUK3SZS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Nov 2004 13:25:18 -0500
Subject: Re: 2.6.10-rc2-mm4
From: Arjan van de Ven <arjan@infradead.org>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20041130102105.21750596.akpm@osdl.org>
References: <20041130095045.090de5ea.akpm@osdl.org>
	 <1101837994.2640.67.camel@laptop.fenrus.org>
	 <20041130102105.21750596.akpm@osdl.org>
Content-Type: text/plain
Message-Id: <1101839110.2640.69.camel@laptop.fenrus.org>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2.dwmw2.1) 
Date: Tue, 30 Nov 2004 19:25:10 +0100
Content-Transfer-Encoding: 7bit
X-Spam-Score: 3.7 (+++)
X-Spam-Report: SpamAssassin version 2.63 on canuck.infradead.org summary:
	Content analysis details:   (3.7 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
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

On Tue, 2004-11-30 at 10:21 -0800, Andrew Morton wrote:
> Arjan van de Ven <arjan@infradead.org> wrote:
> >
> > On Tue, 2004-11-30 at 09:50 -0800, Andrew Morton wrote:
> > > http://www.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.10-rc2/2.6.10-rc2-mm4/
> > > 
> > > - Various fixes and cleanups
> > > 
> > > - A decent-sized x86_64 update.
> > > 
> > > - x86_64 supports a fourth VM zone: ZONE_DMA32.  This may affect memory
> > >   reclaim, but shouldn't.
> > 
> > 
> > what is the purpose of such a zone ??
> 
> For pages which have a physical address <4G.  I assume this was motivated
> by the lack of an IOMMU on ia32e?

but there's the swiommu for those... so that can't be it
realistically....

Is there code using the zone GFP mask yet ??

