Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262719AbTIAHfb (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Sep 2003 03:35:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262724AbTIAHfb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Sep 2003 03:35:31 -0400
Received: from hq.pm.waw.pl ([195.116.170.10]:5011 "EHLO hq.pm.waw.pl")
	by vger.kernel.org with ESMTP id S262719AbTIAHf2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Sep 2003 03:35:28 -0400
To: "David S. Miller" <davem@redhat.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, jes@trained-monkey.org,
       zaitcev@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] RFC: kills consistent_dma_mask
References: <m3oeynykuu.fsf@defiant.pm.waw.pl>
	<20030818111522.A12835@devserv.devel.redhat.com>
	<m33cfyt3x6.fsf@trained-monkey.org>
	<1061298438.30566.29.camel@dhcp23.swansea.linux.org.uk>
	<20030819095547.2bf549e3.davem@redhat.com>
	<m34r0dwfrr.fsf@defiant.pm.waw.pl> <m38ypl29i4.fsf@defiant.pm.waw.pl>
	<m3isoo2taz.fsf@trained-monkey.org> <m3n0dz5kfg.fsf@defiant.pm.waw.pl>
	<20030824060057.7b4c0190.davem@redhat.com>
	<m365kmltdy.fsf@defiant.pm.waw.pl> <m365kex2rp.fsf@defiant.pm.waw.pl>
	<20030830185007.5c61af71.davem@redhat.com>
	<1062334374.31861.32.camel@dhcp23.swansea.linux.org.uk>
	<20030831222233.1bd41f01.davem@redhat.com>
From: Krzysztof Halasa <khc@pm.waw.pl>
Date: 01 Sep 2003 09:34:50 +0200
In-Reply-To: <20030831222233.1bd41f01.davem@redhat.com>
Message-ID: <m37k4tj71h.fsf@defiant.pm.waw.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"David S. Miller" <davem@redhat.com> writes:

> The problem is that it works for the people it was created
> for, you're going to break things for them.

Then Documentation/DMA* should be corrected to indicate this is created
for PCI-64 cards only, and only to increase default 32-bit addressing
to 64-bit on x86-64 and ia64.
Such correction would be a help to driver developers.
-- 
Krzysztof Halasa, B*FH
