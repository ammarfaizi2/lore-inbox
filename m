Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261640AbTKTKiB (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Nov 2003 05:38:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261680AbTKTKiA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Nov 2003 05:38:00 -0500
Received: from rusty.kulnet.kuleuven.ac.be ([134.58.240.42]:49808 "EHLO
	rusty.kulnet.kuleuven.ac.be") by vger.kernel.org with ESMTP
	id S261640AbTKTKh5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Nov 2003 05:37:57 -0500
From: Frank Dekervel <kervel@drie.kotnet.org>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.0-test9-mm4 (does not boot)
Date: Thu, 20 Nov 2003 11:37:55 +0100
User-Agent: KMail/1.5.93
Cc: linux-kernel@vger.kernel.org
References: <200311191749.28327.kervel@drie.kotnet.org> <20031119165928.70a1d077.akpm@osdl.org> <200311201134.04050.kervel@drie.kotnet.org>
In-Reply-To: <200311201134.04050.kervel@drie.kotnet.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
Message-Id: <200311201137.55553.kervel@drie.kotnet.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Op Thursday 20 November 2003 11:34, schreef Frank Dekervel:
> pnpbios says something like this:
>  found installation structure 0xc00f5560
>  version 1.0 entry 0xf0000:0x6149 dseg 0xf0000
>
> i'm going to try without pnpbios i think.
>
> my working 2.6.0test9 also has pnpbios setup:
> kervel@bakvis:~$ cat /boot/config-2.6.0-test9 | grep -i pnpbios
> CONFIG_PNPBIOS=y

ok, replying to myself to be more specific:

working pnpbios gives this:
ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 5 6 7 10 *11 12 14 15)
Linux Plug and Play Support v0.97 (c) Adam Belay
PnPBIOS: Scanning system for PnP BIOS support...
PnPBIOS: Found PnP BIOS installation structure at 0xc00f5560
PnPBIOS: PnP BIOS version 1.0, entry 0xf0000:0x614a, dseg 0xf0000
PnPBIOS: 15 nodes reported by PnP BIOS; 15 recorded by driver
SCSI subsystem initialized

mm4 pnpbios gives the same numbers, but never says 
PnPBIOS: 15 nodes reported by PnP BIOS; 15 recorded by driver
instead it says general protection fault

sorry,
greetings,
frank


-- 
Frank Dekervel - frank.dekervel@student.kuleuven.ac.be
Mechelsestraat 88
3000 Leuven (Belgium)
