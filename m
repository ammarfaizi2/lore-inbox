Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263479AbTDCTFq 
	(for <rfc822;willy@w.ods.org>); Thu, 3 Apr 2003 14:05:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id S263478AbTDCTFp 
	(for <rfc822;linux-kernel-outgoing>); Thu, 3 Apr 2003 14:05:45 -0500
Received: from hq.pm.waw.pl ([195.116.170.10]:47495 "EHLO hq.pm.waw.pl")
	by vger.kernel.org with ESMTP id S263472AbTDCTFh 
	(for <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Apr 2003 14:05:37 -0500
To: <linux-kernel@vger.kernel.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: ISA vs PCI interrupt handling
References: <m3n0j8lc4y.fsf@defiant.pm.waw.pl>
	<1049366617.11275.16.camel@dhcp22.swansea.linux.org.uk>
From: Krzysztof Halasa <khc@pm.waw.pl>
Date: 03 Apr 2003 21:17:07 +0200
In-Reply-To: <1049366617.11275.16.camel@dhcp22.swansea.linux.org.uk>
Message-ID: <m3brznxufg.fsf@defiant.pm.waw.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox <alan@lxorguk.ukuu.org.uk> writes:

> For PCI at least you must mask the IRQ on your device in that situation.
> It must also be masked on the device not via disable_irq

Thanks.
Looks like it's even more important on ISA.
-- 
Krzysztof Halasa
Network Administrator
