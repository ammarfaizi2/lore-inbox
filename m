Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262652AbTIAHwX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Sep 2003 03:52:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262724AbTIAHwX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Sep 2003 03:52:23 -0400
Received: from pizda.ninka.net ([216.101.162.242]:40849 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id S262652AbTIAHwR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Sep 2003 03:52:17 -0400
Date: Mon, 1 Sep 2003 00:43:08 -0700
From: "David S. Miller" <davem@redhat.com>
To: Krzysztof Halasa <khc@pm.waw.pl>
Cc: alan@lxorguk.ukuu.org.uk, jes@trained-monkey.org, zaitcev@redhat.com,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] RFC: kills consistent_dma_mask
Message-Id: <20030901004308.477f8cc8.davem@redhat.com>
In-Reply-To: <m37k4tj71h.fsf@defiant.pm.waw.pl>
References: <m3oeynykuu.fsf@defiant.pm.waw.pl>
	<20030818111522.A12835@devserv.devel.redhat.com>
	<m33cfyt3x6.fsf@trained-monkey.org>
	<1061298438.30566.29.camel@dhcp23.swansea.linux.org.uk>
	<20030819095547.2bf549e3.davem@redhat.com>
	<m34r0dwfrr.fsf@defiant.pm.waw.pl>
	<m38ypl29i4.fsf@defiant.pm.waw.pl>
	<m3isoo2taz.fsf@trained-monkey.org>
	<m3n0dz5kfg.fsf@defiant.pm.waw.pl>
	<20030824060057.7b4c0190.davem@redhat.com>
	<m365kmltdy.fsf@defiant.pm.waw.pl>
	<m365kex2rp.fsf@defiant.pm.waw.pl>
	<20030830185007.5c61af71.davem@redhat.com>
	<1062334374.31861.32.camel@dhcp23.swansea.linux.org.uk>
	<20030831222233.1bd41f01.davem@redhat.com>
	<m37k4tj71h.fsf@defiant.pm.waw.pl>
X-Mailer: Sylpheed version 0.9.2 (GTK+ 1.2.6; sparc-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 01 Sep 2003 09:34:50 +0200
Krzysztof Halasa <khc@pm.waw.pl> wrote:

> "David S. Miller" <davem@redhat.com> writes:
> 
> > The problem is that it works for the people it was created
> > for, you're going to break things for them.
> 
> Then Documentation/DMA* should be corrected to indicate this is created
> for PCI-64 cards only, and only to increase default 32-bit addressing
> to 64-bit on x86-64 and ia64.
> Such correction would be a help to driver developers.

Sure, I'm fine with this as a termporary thing until we
work out the details properly.
