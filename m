Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751348AbVK2Mq7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751348AbVK2Mq7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Nov 2005 07:46:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751349AbVK2Mq6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Nov 2005 07:46:58 -0500
Received: from khc.piap.pl ([195.187.100.11]:2308 "EHLO khc.piap.pl")
	by vger.kernel.org with ESMTP id S1751348AbVK2Mq6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Nov 2005 07:46:58 -0500
To: Duncan Sands <duncan.sands@free.fr>
Cc: Alistair John Strachan <s0348365@sms.ed.ac.uk>,
       linux-kernel@vger.kernel.org
Subject: Re: speedtch driver, 2.6.14.2
References: <200511232125.25254.s0348365@sms.ed.ac.uk>
	<200511281234.45023.duncan.sands@free.fr>
	<m3sltgu1wn.fsf@defiant.localdomain>
	<200511291214.08104.duncan.sands@free.fr>
From: Krzysztof Halasa <khc@pm.waw.pl>
Date: Tue, 29 Nov 2005 13:46:53 +0100
In-Reply-To: <200511291214.08104.duncan.sands@free.fr> (Duncan Sands's
 message of "Tue, 29 Nov 2005 12:14:07 +0100")
Message-ID: <m3sltf1v0i.fsf@defiant.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Duncan Sands <duncan.sands@free.fr> writes:

>> 17:03:15 ATM dev 0: speedtch_check_status entered
>> 17:03:17 usb 1-1: events/0 timed out on ep0in len=0/4
>> 17:03:17 ATM dev 0: speedtch_read_status: MSG D failed
>> 17:03:17 ATM dev 0: error -110 fetching device status
>
> Is it always MSG D that fails?

I think so. Since yesterday I have 7 identical MSG D faults and nothing
else.

>  Is failure of this message
> correlated with anything else, eg: heavy network use?

I don't think so. The ADSL was mostly idle last 24 hrs. Only inbound SMTP
mail and the Windows viruses etc. trying to attack something.

I can perform a test with inactive PPP (=no any flow) but I think it will
show up the same.

BTW: it's an old notebook PC, i440BX (PIIX4) based:

00:00.0 Host bridge: Intel 440BX/ZX/DX - 82443BX/ZX/DX Host bridge (rev 03)
00:01.0 PCI bridge: Intel 440BX/ZX/DX - 82443BX/ZX/DX AGP bridge (rev 03)
00:07.0 ISA bridge: Intel 82371AB/EB/MB PIIX4 ISA (rev 02)
00:07.1 IDE interface: Intel 82371AB/EB/MB PIIX4 IDE (rev 01)
00:07.2 USB Controller: Intel 82371AB/EB/MB PIIX4 USB (rev 01)
00:07.3 Bridge: Intel 82371AB/EB/MB PIIX4 ACPI (rev 03)
00:0a.0 CardBus bridge: Texas Instruments PCI1225 (rev 01)
00:0a.1 CardBus bridge: Texas Instruments PCI1225 (rev 01)
00:0d.0 ESS Technology ES1983S Maestro-3i PCI Audio Accelerator
00:0d.1 ESS Technology ES1983S Maestro-3i PCI Modem Accelerator
01:00.0 VGA: Silicon Motion, Inc. SM720 Lynx3DM (rev b1)
02:00.0 Ethernet: DECchip 21142/43 (rev 41)
-- 
Krzysztof Halasa
