Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131162AbQJ1Rhh>; Sat, 28 Oct 2000 13:37:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131166AbQJ1Rh1>; Sat, 28 Oct 2000 13:37:27 -0400
Received: from panic.ohr.gatech.edu ([130.207.47.194]:49169 "EHLO
	havoc.gtf.org") by vger.kernel.org with ESMTP id <S131162AbQJ1RhQ>;
	Sat, 28 Oct 2000 13:37:16 -0400
Message-ID: <39FB0EAB.C87F816C@mandrakesoft.com>
Date: Sat, 28 Oct 2000 13:36:43 -0400
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.0-test10 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Remi Turk <remi@a2zis.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: No IRQ known for interrupt pin A of device 00:0f.0
In-Reply-To: <39FB024B.220A025C@a2zis.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Remi Turk wrote:
> Uniform Multi-Platform E-IDE driver Revision: 6.31
> ide: Assuming 33MHz system bus speed for PIO modes; override with
> idebus=xx
> ALI15X3: IDE controller on PCI bus 00 dev 78
> PCI: No IRQ known for interrupt pin A of device 00:0f.0. Please try
> using pci=biosirq.

test10-pre6 gives this warning?

Can you post the output of dump_pirq, from the pcmcia_cs package?  (if
you don't have it already, http://pcmcia-cs.sourceforge.net/)

-- 
Jeff Garzik             | "Mind if I drive?"  -Sam
Building 1024           | "Not if you don't mind me clawing at the
MandrakeSoft            |  dash and shrieking like a cheerleader."
                        |                     -Max
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
