Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135628AbRDSLmW>; Thu, 19 Apr 2001 07:42:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135631AbRDSLmM>; Thu, 19 Apr 2001 07:42:12 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:27404 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S135628AbRDSLl5>; Thu, 19 Apr 2001 07:41:57 -0400
Subject: Re: PNP BIOS and parport_pc - dma found but not used
To: proski@gnu.org (Pavel Roskin)
Date: Thu, 19 Apr 2001 12:43:49 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.33.0104190203320.10275-100000@portland> from "Pavel Roskin" at Apr 19, 2001 02:14:03 AM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14qCql-00070F-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I've compiled 2.4.3-ac9 with support for PNP BIOS. I understand that this
> is a new feature experimental and the feedback is requested.

Thanks

> The setting is BIOS is to use irq 7 and dma 3. I normally use "options
> parport_pc io=0x378 irq=7 dma=3" in /etc/modules.conf, but this time I
> commented them out hoping that the driver will ask BIOS.
> 
> PnPBIOS: Parport found PNPBIOS PNP0401 at io=0378,0778 irq=7 dma=-1

Do you have it set in the BIOS itself to use DMA mode and to use DMA 3. The
PnPBIOS should be reflecting your BIOS choices if I understand rightly

