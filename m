Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264345AbTDOGcj (for <rfc822;willy@w.ods.org>); Tue, 15 Apr 2003 02:32:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264347AbTDOGcj (for <rfc822;linux-kernel-outgoing>);
	Tue, 15 Apr 2003 02:32:39 -0400
Received: from [218.27.126.177] ([218.27.126.177]:12434 "EHLO mta2.mail.jl.cn")
	by vger.kernel.org with ESMTP id S264345AbTDOGch (for <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Apr 2003 02:32:37 -0400
Date: Tue, 15 Apr 2003 14:52:32 +0800
From: tlsoft <tlsoft@public.bc.jl.cn>
Subject: Fw: Kernel 2.4.20 PCI: Device 00:0f.1 not available because of
 resource collisions
To: linux-kernel@vger.kernel.org
Message-id: <006701c3031b$97723330$da03a8c0@xalan>
MIME-version: 1.0
X-MIMEOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
X-Mailer: Microsoft Outlook Express 6.00.2800.1106
Content-type: text/plain; charset=gb2312
Content-transfer-encoding: 7BIT
X-Priority: 3
X-MSMail-priority: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


----- Original Message ----- 
From: "tlsoft" <tlsoft@public.bc.jl.cn>
To: <linux-kernel@vger.kernel.org>
Sent: Tuesday, April 15, 2003 2:48 PM
Subject: Kernel 2.4.20 PCI: Device 00:0f.1 not available because of resource collisions


> kernel output:
> 
> SvrWks CSB5: IDE controller on PCI bus 00 dev 79
> PCI: Device 00:0f.1 not available because of resource collisions
> SvrWks CSB5: (ide_setup_pci_device:) Could not enable device.
> hda: IC35L040AVER07-0, ATA DISK drive
> ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
> hda: 80418240 sectors (41174 MB) w/1916KiB Cache, CHS=5005/255/63
> 
> when mount /dev/cdrom /mnt/cdrom   
> system died.
> 
> lspci:
>   00:00.0 Host bridge: ServerWorks CNB20HE Host Bridge (rev 23)
> 00:00.1 Host bridge: ServerWorks CNB20HE Host Bridge (rev 01)
> 00:00.2 Host bridge: ServerWorks: Unknown device 0006 (rev 01)
> 00:00.3 Host bridge: ServerWorks: Unknown device 0006 (rev 01)
> 00:01.0 VGA compatible controller: ATI Technologies Inc Rage XL (rev 27)
> 00:02.0 Ethernet controller: Intel Corp. 82557/8/9 [Ethernet Pro 100] (rev 08)
> 00:03.0 Ethernet controller: Intel Corp. 82557/8/9 [Ethernet Pro 100] (rev 08)
> 00:0f.0 ISA bridge: ServerWorks CSB5 South Bridge (rev 92)
> 00:0f.1 IDE interface: ServerWorks CSB5 IDE Controller (rev 92)
> 00:0f.2 USB Controller: ServerWorks OSB4/CSB5 USB Controller (rev 05)
> 00:0f.3 Host bridge: ServerWorks: Unknown device 0230
> 02:0b.0 SCSI storage controller: Adaptec AIC-7899P U160/m (rev 01)
> 02:0b.1 SCSI storage controller: Adaptec AIC-7899P U160/m (rev 01)
> 
> what is wrong ?
> 
> 
