Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265223AbTFMHZd (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Jun 2003 03:25:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265224AbTFMHZd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Jun 2003 03:25:33 -0400
Received: from mailout05.sul.t-online.com ([194.25.134.82]:22713 "EHLO
	mailout05.sul.t-online.com") by vger.kernel.org with ESMTP
	id S265223AbTFMHZb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Jun 2003 03:25:31 -0400
From: "Andreas Achtzehn" <linux-kernel@achtzehn.homelinux.org>
To: <linux-kernel@vger.kernel.org>
Subject: [OOPS] immediate reboot w/ compiled in CONFIG_FILTER, CONFIG_PPPOE,CONFIG_PPP
Date: Fri, 13 Jun 2003 09:38:57 +0200
Message-ID: <EMEAKOPCBDOCHKHEEBCGAEDBCDAA.linux-kernel@achtzehn.homelinux.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.6604 (9.0.2911.0)
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
Importance: Normal
X-AntiVirus: checked by AntiVir MailGate (version: 2.0.1.10; AVE: 6.20.0.0; VDF: 6.20.0.8; host: achtzehn.homelinux.org)
X-Seen: false
X-ID: rCLcTsZLgeV-uRGW-eaMKmkwXNIjvAfaAtZGX3SyMJ1rHK9JyX2dZu@t-dialin.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dear developers,

following default config causes the kernel to reboot immediately after
having been uncompressed by lilo. No message after "loading linux...." is
shown.

Regards, Andreas

------------------- config.kernel-oops -------------------------
11c11
< # CONFIG_EXPERIMENTAL is not set
---
> CONFIG_EXPERIMENTAL=y
116a117
> # CONFIG_ACPI is not set
171c172
< # CONFIG_FILTER is not set
---
> CONFIG_FILTER=y
179a181
> # CONFIG_ARPD is not set
181a184,186
> # CONFIG_IPV6 is not set
> # CONFIG_KHTTPD is not set
> # CONFIG_ATM is not set
191a197,204
> # CONFIG_X25 is not set
> # CONFIG_LAPB is not set
> # CONFIG_LLC is not set
> # CONFIG_NET_DIVERT is not set
> # CONFIG_ECONET is not set
> # CONFIG_WAN_ROUTER is not set
> # CONFIG_NET_FASTROUTE is not set
> # CONFIG_NET_HW_FLOWCONTROL is not set
303a317
> # CONFIG_SCSI_AACRAID is not set
335a350
> # CONFIG_SCSI_NCR53C8XX_SYMBIOS_COMPAT is not set
351a367
> # CONFIG_SCSI_DEBUG is not set
367a384,388
> # IEEE 1394 (FireWire) support (EXPERIMENTAL)
> #
> # CONFIG_IEEE1394 is not set
>
> #
389a411
> # CONFIG_ETHERTAP is not set
401c423,433
< # CONFIG_NET_VENDOR_3COM is not set
---
> CONFIG_NET_VENDOR_3COM=y
> # CONFIG_EL1 is not set
> # CONFIG_EL2 is not set
> # CONFIG_ELPLUS is not set
> # CONFIG_EL16 is not set
> CONFIG_EL3=m
> # CONFIG_3C515 is not set
> # CONFIG_ELMC is not set
> # CONFIG_ELMC_II is not set
> # CONFIG_VORTEX is not set
> # CONFIG_TYPHOON is not set
430c462
< # CONFIG_8139TOO is not set
---
> CONFIG_8139TOO=m
459a492
> # CONFIG_HIPPI is not set
461c494,501
< # CONFIG_PPP is not set
---
> CONFIG_PPP=y
> # CONFIG_PPP_MULTILINK is not set
> # CONFIG_PPP_FILTER is not set
> # CONFIG_PPP_ASYNC is not set
> # CONFIG_PPP_SYNC_TTY is not set
> # CONFIG_PPP_DEFLATE is not set
> # CONFIG_PPP_BSDCOMP is not set
> CONFIG_PPPOE=y
473a514,515
> # CONFIG_RCPCI is not set
> # CONFIG_SHAPER is not set
581a624
> # CONFIG_SONYPI is not set
712a756,761
> # CONFIG_MDA_CONSOLE is not set
>
> #
> # Frame-buffer support
> #
> # CONFIG_FB is not set
753a803
> # CONFIG_USB_BLUETOOTH is not set
------------------- config.kernel-oops -------------------------

