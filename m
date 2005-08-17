Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750964AbVHQKyx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750964AbVHQKyx (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Aug 2005 06:54:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750960AbVHQKyx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Aug 2005 06:54:53 -0400
Received: from smtp4.brturbo.com.br ([200.199.201.180]:47947 "EHLO
	smtp4.brturbo.com.br") by vger.kernel.org with ESMTP
	id S1750804AbVHQKyx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Aug 2005 06:54:53 -0400
Subject: Re: [Fwd: help with PCI hotplug and a PCI device enabled after
	boot]
From: Mauro Carvalho Chehab <mchehab@brturbo.com.br>
To: Rolf Eike Beer <eike-kernel@sf-tec.de>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <200508171147.22927@bilbo.math.uni-mannheim.de>
References: <1124269343.4423.35.camel@localhost>
	 <200508171147.22927@bilbo.math.uni-mannheim.de>
Content-Type: text/plain; charset=ISO-8859-1
Date: Wed, 17 Aug 2005 07:54:50 -0300
Message-Id: <1124276090.4423.46.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3-6mdk 
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rolf,

Em Qua, 2005-08-17 às 11:47 +0200, Rolf Eike Beer escreveu:
> Mauro Carvalho Chehab wrote:
> >    I need some help with PCI hotplug for allowing a new driver at
> >Video4Linux.
> >
> >    I need memory to set its internal registers. Is there a way to make
> >PCI drivers to allocate a memory region for the board?
> 
> Use dummyphp instead of fakephp. It should handle this case. You can find it 
> here: http://opensource.sf-tec.de/kernel/dummyphp-2.6.13-rc1.diff
> 
	Didn't compile cleanly against -rc6. Do I need another patch or -mm
series?

WARNING: /lib/modules/2.6.13-rc6/kernel/drivers/pci/hotplug/dummyphp.ko
needs unknown symbol pci_bus_add_resources

> Eike
Cheers, 
Mauro.

