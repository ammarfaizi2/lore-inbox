Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131253AbQLMM4o>; Wed, 13 Dec 2000 07:56:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131315AbQLMM4e>; Wed, 13 Dec 2000 07:56:34 -0500
Received: from enterprise.cistron.net ([195.64.68.33]:51210 "EHLO
	enterprise.cistron.net") by vger.kernel.org with ESMTP
	id <S131253AbQLMM40>; Wed, 13 Dec 2000 07:56:26 -0500
From: reneb@orac.aais.nl (Rene Blokland)
Subject: [SOLVED]Trident sound does not work anymore!
Date: Wed, 13 Dec 2000 13:24:43 +0100
Organization: Cistron Internet Services B.V.
Message-ID: <slrn93eqkb.4r.reneb@orac.aais.nl>
Reply-To: reneb@cistron.nl
X-Trace: enterprise.cistron.net 976710366 26854 62.216.0.12 (13 Dec 2000 12:26:06 GMT)
X-Complaints-To: abuse@cistron.nl
To: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I wrote:
>Hi there, as the subject says the trident sound does not work since
>2.4.0-test9. this messages does dmesg:
>Trident 4DWave/SiS 7018/ALi 5451 PCI Audio, version 0.14.6, 12:36:52 Nov 20 2000
>trident: Trident 4DWave DX found at IO 0xd800, IRQ 0
>trident: unable to allocate irq 0
>any ideas?
After removing the soundcard and inserting it again to update the pci-bios
of the mb, found out that when the srcew is tight the irq 0.
when the screw is not tight it works like a charm!
So it was a hardware problem and NOT the kernel.
Sorry and regards, Rene.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
