Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271747AbTG2N7P (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Jul 2003 09:59:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271746AbTG2N7P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Jul 2003 09:59:15 -0400
Received: from hq.pm.waw.pl ([195.116.170.10]:13220 "EHLO hq.pm.waw.pl")
	by vger.kernel.org with ESMTP id S271740AbTG2N6B (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Jul 2003 09:58:01 -0400
To: "Kathy Frazier" <kfrazier@mdc-dayton.com>
Cc: <linux-kernel@vger.kernel.org>, <herbert@13thfloor.at>
Subject: Re: Problems related to DMA or DDR memory on Intel 845 chipset?
References: <PMEMILJKPKGMMELCJCIGKELACDAA.kfrazier@mdc-dayton.com>
From: Krzysztof Halasa <khc@pm.waw.pl>
Date: 29 Jul 2003 15:57:44 +0200
In-Reply-To: <PMEMILJKPKGMMELCJCIGKELACDAA.kfrazier@mdc-dayton.com>
Message-ID: <m3he55xwo7.fsf@defiant.pm.waw.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Kathy Frazier" <kfrazier@mdc-dayton.com> writes:

> We are using the ASUS P4PE MoBo - Uses Intel 845PE chipset.  The message
> file indicates:
> 
> Transparant bridge - Intel Corp. 82801BA/CA/DB PCI bridge

Actually I was thinking about an IC on your card, something like
PLX PCI9080 chip - i.e. the chip connected to the PCI bus and doing
the DMA transfers (many specialized controllers have built-in PCI
bridge, though).

Could you please state if you are using bus mastering PCI DMA, or
if it is IDE DMA (an IDE hard disk etc) thing?
-- 
Krzysztof Halasa
Network Administrator
