Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263498AbTIAS1P (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Sep 2003 14:27:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263507AbTIAS1O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Sep 2003 14:27:14 -0400
Received: from hq.pm.waw.pl ([195.116.170.10]:10398 "EHLO hq.pm.waw.pl")
	by vger.kernel.org with ESMTP id S263498AbTIAS0l convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Sep 2003 14:26:41 -0400
To: "David S. Miller" <davem@redhat.com>
Cc: alan@lxorguk.ukuu.org.uk, jes@trained-monkey.org, zaitcev@redhat.com,
       linux-kernel@vger.kernel.org
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
	<m37k4tj71h.fsf@defiant.pm.waw.pl>
	<20030901004308.477f8cc8.davem@redhat.com>
	<m3ptikctx5.fsf@defiant.pm.waw.pl>
	<20030901102808.1d27f537.davem@redhat.com>
From: Krzysztof Halasa <khc@pm.waw.pl>
Date: 01 Sep 2003 20:24:51 +0200
In-Reply-To: <20030901102808.1d27f537.davem@redhat.com>
Message-ID: <m3he3wcqoc.fsf@defiant.pm.waw.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"David S. Miller" <davem@redhat.com> writes:

> Umm, come on, this is inaccurate.

I tried to make it accurate. I might be missing something, though.
What exactly do you think is inaccurate?

>  But this is unrelated to
> the consistent DMA issues.

Hmm... What do you mean?

BTW: consistent_dma_mask and dma_mask names are misleading: they are
(in theory) related to allocation vs mapping requests mainly -
the consistent vs non-consistent thing is secondary.
-- 
Krzysztof Halasa, B*FH
