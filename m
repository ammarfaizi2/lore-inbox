Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262249AbUK3Sv5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262249AbUK3Sv5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Nov 2004 13:51:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262247AbUK3SsH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Nov 2004 13:48:07 -0500
Received: from clock-tower.bc.nu ([81.2.110.250]:61853 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S262261AbUK3Sri (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Nov 2004 13:47:38 -0500
Subject: Re: 2.6.10-rc2-mm4
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Andrew Morton <akpm@osdl.org>
Cc: Arjan van de Ven <arjan@infradead.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20041130103218.513b8ce0.akpm@osdl.org>
References: <20041130095045.090de5ea.akpm@osdl.org>
	 <1101837994.2640.67.camel@laptop.fenrus.org>
	 <20041130102105.21750596.akpm@osdl.org>
	 <1101839110.2640.69.camel@laptop.fenrus.org>
	 <20041130103218.513b8ce0.akpm@osdl.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1101836642.25617.63.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Tue, 30 Nov 2004 17:44:03 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Maw, 2004-11-30 at 18:32, Andrew Morton wrote:
> "This helps mainly graphic drivers who really need a lot of memory below
> the 4GB area.  Previous they could only use IOMMU+16MB GFP_DMA, which was
> not enough memory."
> 
> >  Is there code using the zone GFP mask yet ??
> 
> Nope.

You mean its a private hook for a proprietary graphics driver, which
because it is that can't use it anyway ? That sounds dubious to me as
policy has always been to avoid such hooks. What other drivers need this
- I've seen people claim aacraid does which is untrue but no others.

Alan

