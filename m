Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317583AbSFML6e>; Thu, 13 Jun 2002 07:58:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317586AbSFML6d>; Thu, 13 Jun 2002 07:58:33 -0400
Received: from nixpbe.pdb.siemens.de ([192.109.2.33]:26004 "EHLO
	nixpbe.pdb.sbs.de") by vger.kernel.org with ESMTP
	id <S317583AbSFML6c>; Thu, 13 Jun 2002 07:58:32 -0400
Subject: Re: Serverworks OSB4 in impossible state
From: Martin Wilck <Martin.Wilck@Fujitsu-Siemens.com>
To: Daniela Engert <dani@ngrt.de>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Linux Kernel mailing list <linux-kernel@vger.kernel.org>
In-Reply-To: <20020613104659.37E7B109F6@mail.medav.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 13 Jun 2002 13:59:06 +0200
Message-Id: <1023969547.23733.858.camel@biker.pdb.fsc.net>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Don, 2002-06-13 um 13.50 schrieb Daniela Engert:

> And here is the same with the ROSB4. This time, some of the
> DMA writes are shown. After loading the second PRD entry
> which describes a memory region of 7800h bytes, 3000h bytes
> are transferred before IRQ14 is asserted. The IRQ14 INTACK
> cycle is the last transaction on the PCI bus ever, the
> machine is completely frozen!

You say (dma_base+2) is never read?
Was that a Linux system? If yes, I assume you never saw "OSB4 in
impossible state ..." ?

Martin

-- 
Martin Wilck                Phone: +49 5251 8 15113
Fujitsu Siemens Computers   Fax:   +49 5251 8 20409
Heinz-Nixdorf-Ring 1	    mailto:Martin.Wilck@Fujitsu-Siemens.com
D-33106 Paderborn           http://www.fujitsu-siemens.com/primergy





