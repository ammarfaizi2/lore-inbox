Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269218AbUIBVtG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269218AbUIBVtG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Sep 2004 17:49:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269216AbUIBVpp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Sep 2004 17:45:45 -0400
Received: from inx.pm.waw.pl ([195.116.170.20]:41452 "EHLO inx.pm.waw.pl")
	by vger.kernel.org with ESMTP id S269196AbUIBVpD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Sep 2004 17:45:03 -0400
To: Michael Hunold <hunold@convergence.de>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Jeff Garzik <jgarzik@pobox.com>
Subject: Re: Dual-Ethernet DECchip 21142/43 doesn't like cold boots
References: <41374B9F.6000404@convergence.de>
From: Krzysztof Halasa <khc@pm.waw.pl>
Date: Thu, 02 Sep 2004 23:25:32 +0200
In-Reply-To: <41374B9F.6000404@convergence.de> (Michael Hunold's message of
 "Thu, 02 Sep 2004 18:34:39 +0200")
Message-ID: <m33c20z7lf.fsf@defiant.pm.waw.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Michael Hunold <hunold@convergence.de> writes:

> Linux Tulip driver version 1.1.13 (May 11, 2002)
> ACPI: PCI interrupt 0000:02:04.0[A] -> GSI 11 (level, low) -> IRQ 11
> tulip0:  EEPROM default media type Autosense.
> tulip0:  Index #0 - Media MII (#11) described by a 21142 MII PHY (3) block.
> tulip0: ***WARNING***: No MII transceiver found!
> eth0: Digital DS21143 Tulip rev 33 at 0xe280ff80, 00:00:D1:1B:EF:2E, IRQ 11.

Interesting - I'm occasionally seeing same warnings with SMC EtherPower II.
May be unrelated, though. And despite the warning, the card actually
works.
This is SMC epic100 chip, not a Tulip or clone.
-- 
Krzysztof Halasa
