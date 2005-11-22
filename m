Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750920AbVKVFvA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750920AbVKVFvA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Nov 2005 00:51:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750925AbVKVFvA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Nov 2005 00:51:00 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:28613 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1750918AbVKVFu7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Nov 2005 00:50:59 -0500
Subject: Re: [RFC] Small PCI core patch
From: Arjan van de Ven <arjan@infradead.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org
In-Reply-To: <1132616132.26560.62.camel@gaston>
References: <20051121225303.GA19212@kroah.com>
	 <20051121230136.GB19212@kroah.com>  <1132616132.26560.62.camel@gaston>
Content-Type: text/plain
Date: Tue, 22 Nov 2005 06:50:52 +0100
Message-Id: <1132638652.2789.4.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-Spam-Score: 1.8 (+)
X-Spam-Report: SpamAssassin version 3.0.4 on pentafluge.infradead.org summary:
	Content analysis details:   (1.8 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	0.1 RCVD_IN_SORBS_DUL      RBL: SORBS: sent directly from dynamic IP address
	[213.93.14.173 listed in dnsbl.sorbs.net]
	1.7 RCVD_IN_NJABL_DUL      RBL: NJABL: dialup sender did non-local SMTP
	[213.93.14.173 listed in combined.njabl.org]
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-11-22 at 10:35 +1100, Benjamin Herrenschmidt wrote:
> On Mon, 2005-11-21 at 15:01 -0800, Greg KH wrote:
> 
> > If you, or your company is relying on closed source kernel modules, your
> > days are numbered.  And what are you going to do, and how are you going
> > to explain things to your bosses and your customers, if possibly,
> > something like this patch were to be accepted?
> 
> I'm all about it, but good luck trying to convince ATI and/or nVidia ...

that doesn't mean they're allowed to not honor the GPL of course.

Also it's almost the same argument as the ndiswrapper discussion: as
long as there is an alternative some of these companies (prolly not
ati/nvidia although: see [1]) will stay closed, but once there's no
alternative they'll just open up.

I can see the point of the argument that a change like this needs to be
announced for say 6 months first in that feature-removal doc though.



[1] Both nvidia and ati have a way out: they can do the IP side
(translating 3D stuff into card specific commands) in userspace and just
pass the data to the hardware via a thin driver that just drives and
controls the hardware. Sure it may be 5% slower, but it's a lot cleaner
IP wise. X after all is MIT (bsd like without nasty clauses) licensed
and allows binary components.



