Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129985AbRALShd>; Fri, 12 Jan 2001 13:37:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129655AbRALShX>; Fri, 12 Jan 2001 13:37:23 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:7442 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S129985AbRALShN>; Fri, 12 Jan 2001 13:37:13 -0500
To: linux-kernel@vger.kernel.org
From: torvalds@transmeta.com (Linus Torvalds)
Subject: Re: ide.2.4.1-p3.01112001.patch
Date: 12 Jan 2001 10:37:09 -0800
Organization: Transmeta Corporation
Message-ID: <93nisl$20g$1@penguin.transmeta.com>
In-Reply-To: <Pine.LNX.4.10.10101120949040.1858-100000@penguin.transmeta.com> <E14H8hl-0004ji-00@the-village.bc.nu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <E14H8hl-0004ji-00@the-village.bc.nu>,
Alan Cox  <alan@lxorguk.ukuu.org.uk> wrote:
>
>The PCI ids I kill autodma on for 2.2 to cover this are:
>
>                /*
>                 *      Don't try and tune a VIA 82C586 or 586A
>                 */
>                if (IDE_PCI_DEVID_EQ(devid, DEVID_VP_IDE))
>                {
>                        autodma_default = 0;
>                        break;
>                }
>                if (IDE_PCI_DEVID_EQ(devid, DEVID_VP_OLDIDE))
>                {
>                        autodma_default = 0;
>                        break;
>                }
>
>
>PCI_VENDOR_ID_VIA,     PCI_DEVICE_ID_82C586_0
>PCI_VENDOR_ID_VIA,     PCI_DEVICE_ID_82C586_1

Can I get a patch, Andre?

		Linus
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
