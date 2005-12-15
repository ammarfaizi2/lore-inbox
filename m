Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750868AbVLORvr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750868AbVLORvr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Dec 2005 12:51:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750870AbVLORvr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Dec 2005 12:51:47 -0500
Received: from [81.2.110.250] ([81.2.110.250]:29674 "EHLO lxorguk.ukuu.org.uk")
	by vger.kernel.org with ESMTP id S1750855AbVLORvq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Dec 2005 12:51:46 -0500
Subject: Re: SATA feature list available
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>,
       "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>
In-Reply-To: <43A1A37E.4070806@pobox.com>
References: <43A1A37E.4070806@pobox.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Thu, 15 Dec 2005 17:51:46 +0000
Message-Id: <1134669106.12421.67.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Iau, 2005-12-15 at 12:10 -0500, Jeff Garzik wrote:
> For people such as marketing types working on a distro, or users just 
> looking for quick answers, I've created a feature list for libata:
> 
> 	http://linux.yyz.us/sata/features.html
> 
> Let me know if there is anything missing.  This is just a quick list, 
> details can be found on other pages at that site.


Comments

IDE isn't really supported yet. EIDE/ATA is mostly.
PCI IDE legacy/native - yes but we don't handle mixed

"Full support for initializing PATA device, controller timings" -
Nowhere near until the indpendent timing stuff is merged

Under not supported might be worth adding HPA, simplex DMA, legacy ISA
devices.


Controllers: -ac patch now has (not all tested or by any means ready for
the mainstream!)

ALi (no MWDMA yet)
AMD
ATIIXP
CS5520 (no VDMA)
CS5530
CS5535
CS5536
EFAR
HPT343/363
HPT36x
HPT37x
HPT3x2N
IT8172
IT821X
MPIIX
early PIIX
OPTI
PIIX/ICH/ESB etc
RZ1000 workarounds
SC1200
SIS (no MWDMA on some versions)
Serverworks OSB4/CSB5/CSB6
SL82C105
Triflex
VIA

Big glaring holes in the PC world

CMD64x
ARTOP
Earlier Promise


