Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264980AbUHCLQL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264980AbUHCLQL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Aug 2004 07:16:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265772AbUHCLQK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Aug 2004 07:16:10 -0400
Received: from s124.mittwaldmedien.de ([62.216.178.24]:52642 "EHLO
	s124.mittwaldmedien.de") by vger.kernel.org with ESMTP
	id S264980AbUHCLQG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Aug 2004 07:16:06 -0400
Message-ID: <410F7407.8070903@vcd-berlin.de>
Date: Tue, 03 Aug 2004 13:16:23 +0200
From: Elmar Hinz <elmar.hinz@vcd-berlin.de>
User-Agent: Mozilla Thunderbird 0.5 (X11/20040306)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: PATCH: Add support for IT8212 IDE controllers
References: <2obsK-5Ni-13@gated-at.bofh.it>
In-Reply-To: <2obsK-5Ni-13@gated-at.bofh.it>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> There is a messy scsi faking vendor driver for this card but this instead
> is a standard Linux IDE layer driver.
> 

I try to answer to this post. As I newly subscribed to this list, I 
probably won't catch the original thread.

After application of this patch I get the following error during 
compilation. This are my first steps with kernel patching. Probably the 
fault is on my side.

Regards Elmar



   CC      drivers/ide/pci/it8212.o
drivers/ide/pci/it8212.c:643: error: `PCI_DEVICE_ID_ITE_8212' undeclared 
here (not in a function)
drivers/ide/pci/it8212.c:643: error: Initialisierungselement ist nicht 
konstant
drivers/ide/pci/it8212.c:643: error: (near initialization for 
`it8212_pci_tbl[0].device')
drivers/ide/pci/it8212.c:643: error: Initialisierungselement ist nicht 
konstant
drivers/ide/pci/it8212.c:643: error: (near initialization for 
`it8212_pci_tbl[0]')
drivers/ide/pci/it8212.c:644: error: Initialisierungselement ist nicht 
konstant
drivers/ide/pci/it8212.c:644: error: (near initialization for 
`it8212_pci_tbl[1]')
make[4]: *** [drivers/ide/pci/it8212.o] Fehler 1
make[3]: *** [drivers/ide/pci] Fehler 2
make[2]: *** [drivers/ide] Fehler 2
make[1]: *** [drivers] Fehler 2
make[1]: Verlasse Verzeichnis »/usr/src/linux-2.6.8-rc2«
make: *** [stamp-build] Fehler 2


