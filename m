Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263171AbTIVOet (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Sep 2003 10:34:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263174AbTIVOet
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Sep 2003 10:34:49 -0400
Received: from fmr09.intel.com ([192.52.57.35]:46299 "EHLO hermes.hd.intel.com")
	by vger.kernel.org with ESMTP id S263171AbTIVOer convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Sep 2003 10:34:47 -0400
Content-Class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Subject: RE: 2.4.22-ac1 -- loading of usb-uhci gives hard lockup
X-MimeOLE: Produced By Microsoft Exchange V6.0.6487.1
Date: Mon, 22 Sep 2003 07:34:41 -0700
Message-ID: <7F740D512C7C1046AB53446D3720017304AF88@scsmsx402.sc.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: 2.4.22-ac1 -- loading of usb-uhci gives hard lockup
Thread-Index: AcOBE1YhJL4FwIdcSZKqtlII0hI6GgAApLsw
From: "Nakajima, Jun" <jun.nakajima@intel.com>
To: <juan.carlos@vivo.com.br>
Cc: <pawel.dziekonski@pwr.wroc.pl>, <linux-kernel@vger.kernel.org>,
       <jcastro@vialink.com.br>
X-OriginalArrivalTime: 22 Sep 2003 14:34:41.0522 (UTC) FILETIME=[A8A5FD20:01C38116]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marcelo released Linux 2.4.23-pre5, and it has more bug fixes. Can you please try that? It would provide more data.

Thanks,
Jun
---

<len.brown:intel.com>:
  o Extended IRQ resource type for nForce (Andrew de Quincey) Handle BIOS with _CRS that fails (Jun Nakajima)
  o Fix ACPI oops on ThinkPad T32/T40 (Shaohua David Li)
  o support non ACPI compliant SCI over-ride specs (Jun Nakajima)
  o remove ASUS A7V BIOS version 1011 from blacklist (Eric Valette)
  o fix off-by-one error in ioremap() fixes kernel crash in acpi mode: http://bugzilla.kernel.org/show_bug.cgi?id=1085
  o ACPI_CA_VERSION                 0x20030916
  o tables.c.diff
  o from 2.6 acpi_pci_link_get_irq() returns 0 on error, not -ENODEV. (Christophe Saout)
  o exclude acpitable.[ch] from the CONFIG_ACPI_HT_ONLY build
  o [ACPI] delete acpitable.[ch], which used to be just for CONFIG_ACPI_HT_ONLY
  o [ACPI] Fix SCI storm on out of spec boards like Tyan http://bugzilla.kernel.org/show_bug.cgi?id=774
  o [ACPI] acpi_disabled is used after __initdata is freed
  o [ACPI] fix IO-APIC mode SCI storm due to sharing with PCI device (David Shaohua Li) http://bugzilla.kernel.org/show_bug.cgi?id=1165


> -----Original Message-----
> From: juan.carlos@vivo.com.br [mailto:juan.carlos@vivo.com.br]
> Sent: Monday, September 22, 2003 7:10 AM
> To: Nakajima, Jun
> Cc: pawel.dziekonski@pwr.wroc.pl; linux-kernel@vger.kernel.org;
> jcastro@vialink.com.br
> Subject: RE: 2.4.22-ac1 -- loading of usb-uhci gives hard lockup
> 
> Hello, I tried the patch you wrote (and noticed it is now in 2.4.22-ac3)
> but I still have the same hard lockup Pawel Dziekonski has -- and, like
> him, everything works when I don't compile ACPI into the kernel. My mobo
> is
> a Soyo K7VTA-PRO, Athlon 950 Mhz, chipset VIA82Csomething.
> 
> Is there a piece of information I could send you that would help (BIOS
> settings, /proc listings)? Please CC to me at j[CUBAN-DICTATOR'S-SURNAME]
> @vialink.com.br, I'm not subscribed to LKML (but could be since I'm
> getting
> broadband today. Yay!) :)
> 
> Cheers all,
> 
> Juan Carlos Castro y Castro
> VIVO - Diretoria de Processos de Negócio - Projetos
> Tel.: 55 (21) 2574-3506 - Cel.: 55 (21) 9603-7440
> juan.carlos@vivo.com.br
> jcastro@vialink.com.br
> 
> 
> 
> 

