Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262719AbVAKLSn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262719AbVAKLSn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jan 2005 06:18:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262721AbVAKLSn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jan 2005 06:18:43 -0500
Received: from canuck.infradead.org ([205.233.218.70]:64268 "EHLO
	canuck.infradead.org") by vger.kernel.org with ESMTP
	id S262719AbVAKLSl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jan 2005 06:18:41 -0500
Subject: Re: [PATCH 0/6] 2.4.19-rc1 stack reduction patches
From: Arjan van de Ven <arjan@infradead.org>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: Badari Pulavarty <pbadari@us.ibm.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20050111074949.GE18796@logos.cnet>
References: <1105378550.4000.132.camel@dyn318077bld.beaverton.ibm.com>
	 <1105429144.3917.0.camel@laptopd505.fenrus.org>
	 <20050111074949.GE18796@logos.cnet>
Content-Type: text/plain
Date: Tue, 11 Jan 2005 12:18:31 +0100
Message-Id: <1105442311.3917.25.camel@laptopd505.fenrus.org>
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

On Tue, 2005-01-11 at 05:49 -0200, Marcelo Tosatti wrote:
> On Tue, Jan 11, 2005 at 08:39:03AM +0100, Arjan van de Ven wrote:
> > On Mon, 2005-01-10 at 09:35 -0800, Badari Pulavarty wrote:
> > > Hi Marcelo,
> > > 
> > > I re-worked all the applicable stack reduction patches for 2.4.19-rc1.
> > 
> > is it really worth doing this sort of thing for 2.4 still? It's a matter
> > of risk versus gain... not sure this sort of thing is still worth it in
> > the deep-maintenance 2.4 tree
> 
> Well it seems the s390 fellows are seeing stack overflows, which are serious
> enough. Have you noticed that?

well.. is anyone using 2.4.2X mainline on s390, or is ibm making their
s390 customers use vendor kernels instead? 
(the people brave enough to not use those kernels might very well be
using 2.6 by now)

Just trying to get a feeling for who if anyone will benefit inclusion of
such patches, because if that is "just about nobody" then they might
well not be worth the risk.


