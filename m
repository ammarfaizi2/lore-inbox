Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271755AbTHMLY0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Aug 2003 07:24:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271813AbTHMLY0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Aug 2003 07:24:26 -0400
Received: from crosslink-village-512-1.bc.nu ([81.2.110.254]:9720 "EHLO
	dhcp23.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id S271755AbTHMLYY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Aug 2003 07:24:24 -0400
Subject: Re: consistent_dma_mask is a ghost?
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Pete Zaitcev <zaitcev@redhat.com>
Cc: Krzysztof Halasa <khc@pm.waw.pl>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <200308130011.h7D0BME29033@devserv.devel.redhat.com>
References: <mailman.1060643897.16128.linux-kernel2news@redhat.com>
	 <200308130011.h7D0BME29033@devserv.devel.redhat.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1060773827.8008.13.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.3 (1.4.3-3) 
Date: 13 Aug 2003 12:23:48 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mer, 2003-08-13 at 01:11, Pete Zaitcev wrote:
> Platforms which worked correctly before continue to work
> correctly thereafter. IMHO, the whole thing is a kludge,
> designed to support AIC7xxx on SGI SN-2, and that's about
> all it does. There's a device which uses fewer DMA bits
> when it accesses its mailbox than when it accesses data.

Same is true for megaraid, aacraid and several other cards, but they
just keep changing the pci mask at runtime. Thats in some ways even
uglier but works for now

