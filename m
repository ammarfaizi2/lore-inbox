Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132318AbRCaGhH>; Sat, 31 Mar 2001 01:37:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132323AbRCaGg6>; Sat, 31 Mar 2001 01:36:58 -0500
Received: from hypnos.cps.intel.com ([192.198.165.17]:48616 "EHLO
	hypnos.cps.intel.com") by vger.kernel.org with ESMTP
	id <S132318AbRCaGgo>; Sat, 31 Mar 2001 01:36:44 -0500
Message-ID: <4148FEAAD879D311AC5700A0C969E8905DE7DE@orsmsx35.jf.intel.com>
From: "Grover, Andrew" <andrew.grover@intel.com>
To: "'???'" <nso@icu.ac.kr>, linux-kernel@vger.kernel.org
Subject: RE: ACPI poweroff problem with 2.4.x on VIA chipset M/B
Date: Fri, 30 Mar 2001 22:35:41 -0800
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="KS_C_5601-1987"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

No there isn't a chipset patch for ACPI, because IMHO vendor-specific code
is the wrong way to go regarding this. ACPI defines how shutdown should
happen, and if it doesn't work on a given system, then either the code has
a bug or the hardware is not ACPI compliant.

(I think the ACPI code has a bug, but it's not immediately obvious to me
how to fix it, since we are doing what the spec says, so what more can we
do?)

Regards -- Andy

> From: nso@icu.ac.kr [mailto:nso@icu.ac.kr]
> My machine has ASUS CUV4X-E mainboard with Award BIOS.
> Using poweroff command, I can power off my machine
> with kernel 2.2.x.
> But with kernel 2.4.x, this machine doesn't change
> to soft-off(S5) state after poweroff command enters.
> The last message is "Could not enter S5".
> However, old via-chipset mainboard machine has
> no problem to poweroff with kernel 2.4.x.
> 
> I found 2.3.x VIA chipset patch for ACPI.
> Is there 2.4.x VIA chipser pach for ACPI?
> 
> Please CC any replies to my email address
> becausen I am not subscribed to linux-kernel

