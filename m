Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266969AbSKQWRK>; Sun, 17 Nov 2002 17:17:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266970AbSKQWRK>; Sun, 17 Nov 2002 17:17:10 -0500
Received: from pc1-cwma1-5-cust42.swa.cable.ntl.com ([80.5.120.42]:43954 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S266969AbSKQWRJ>; Sun, 17 Nov 2002 17:17:09 -0500
Subject: Re: ALI 1533 / hang on boot / vaio c1mhp / 2.4.19 + acpi backport
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Florian Lohoff <flo@rfc822.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20021117194745.GA1281@paradigm.rfc822.org>
References: <20021117194745.GA1281@paradigm.rfc822.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 17 Nov 2002 22:50:00 +0000
Message-Id: <1037573400.5356.1.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2002-11-17 at 19:47, Florian Lohoff wrote:
> 
> Hi,
> i am seeing a hang on boot on a Crusoe based Vaio C1MHP when enabling
> the ALI IDE Driver:
> 
> These are the last lines:
> 
> Unform Multi-Platform E-IDE driver Revision: 6.31
> ide: Assuming 33Mhz system bus speed for PIO modes: override with idebus=xx
> ALI15X3: IDE controller on PCI bus 00 dev 80
>  pci_irq-0293 [05] acpi_pci_irq_derive   : Unable to derive IRQ for device 00:10.0
> PCI: No IRQ known for interrupt pin A of device 00:10.0 - using IRQ 255
> ALI15X3: chipset revision 196
> ALI15X3: not 100% native mode: will probe irqs later

Try it without the ACPI first. Let me know if that also hangs

