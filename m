Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263015AbTIARPq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Sep 2003 13:15:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263112AbTIARPp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Sep 2003 13:15:45 -0400
Received: from hq.pm.waw.pl ([195.116.170.10]:55450 "EHLO hq.pm.waw.pl")
	by vger.kernel.org with ESMTP id S263015AbTIARPn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Sep 2003 13:15:43 -0400
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
	<1062402857.13087.4.camel@dhcp23.swansea.linux.org.uk>
	<20030901005259.73f77f24.davem@redhat.com>
From: Krzysztof Halasa <khc@pm.waw.pl>
Date: 01 Sep 2003 18:27:45 +0200
In-Reply-To: <20030901005259.73f77f24.davem@redhat.com>
Message-ID: <m3u17wcw3i.fsf@defiant.pm.waw.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"David S. Miller" <davem@redhat.com> writes:

> But knowing breaking the tree for people is bad practice.

How about breaking the existing sound drivers (not checked other things)
on ia64 and x86-64?
-- 
Krzysztof Halasa, B*FH
