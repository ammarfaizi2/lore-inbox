Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261907AbTILW1j (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Sep 2003 18:27:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261923AbTILW1j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Sep 2003 18:27:39 -0400
Received: from pc1-cwma1-5-cust4.swan.cable.ntl.com ([80.5.120.4]:37017 "EHLO
	dhcp23.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id S261907AbTILW1h (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Sep 2003 18:27:37 -0400
Subject: Re: (kconfig) IDE DMA dependencies
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Hollis Blanchard <hollisb@us.ibm.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1D1AD482-E569-11D7-AC00-000A95A0560C@us.ibm.com>
References: <1D1AD482-E569-11D7-AC00-000A95A0560C@us.ibm.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1063405576.5783.13.camel@dhcp23.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 (1.4.4-5) 
Date: Fri, 12 Sep 2003 23:26:17 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Gwe, 2003-09-12 at 22:36, Hollis Blanchard wrote:
> I noticed this when my linker couldn't find ide_setup_dma() last night. 
> It looks like most of the drivers/ide/pci/ drivers use ide_setup_dma() 
> in their .init_dma() function. ide_setup_dma() is defined in 

It should be falling out as a stub function I think. In the non DMA 
case it should never get invoked anyway

