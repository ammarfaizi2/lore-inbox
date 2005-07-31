Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261634AbVGaRdK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261634AbVGaRdK (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 31 Jul 2005 13:33:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261795AbVGaRdJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Jul 2005 13:33:09 -0400
Received: from smtp.osdl.org ([65.172.181.4]:23724 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261634AbVGaRdI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Jul 2005 13:33:08 -0400
Date: Sun, 31 Jul 2005 10:31:56 -0700
From: Andrew Morton <akpm@osdl.org>
To: cijoml@volny.cz
Cc: linux-kernel@vger.kernel.org, video4linux-list@redhat.com
Subject: Re: 2 errors in 2.6.12
Message-Id: <20050731103156.69536415.akpm@osdl.org>
In-Reply-To: <200507311351.52631.cijoml@volny.cz>
References: <200506190958.00267.cijoml@volny.cz>
	<20050728214851.44877164.akpm@osdl.org>
	<200507311351.52631.cijoml@volny.cz>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Michal Semler <cijoml@volny.cz> wrote:
>
>  I tested both - problem with SB Live! is fixed, but tuning problem in PV951 
>  still exist :(
> 
> 
>  This is what I gets into dmesg:
> 
> 
>  Linux video capture interface: v1.00
>  bttv: driver version 0.9.15 loaded
>  bttv: using 8 buffers with 2080k (520 pages) each for capture
>  bttv: Bt8xx card found (0).
>  ACPI: PCI Interrupt 0000:01:0b.0[A] -> Link [LNKH] -> GSI 9 (level, low) -> 
>  IRQ 9
>  bttv0: Bt878 (rev 17) at 0000:01:0b.0, irq: 9, latency: 32, mmio: 0xb69fe000
>  bttv0: using: ProVideo PV951 [card=42,insmod option]
>  bttv0: gpio: en=00000000, out=00000000 in=00ffffff [init]
>  bttv0: using tuner=1
>  bttv0: i2c: checking for TDA9875 @ 0xb0... not found
>  bttv0: i2c: checking for TDA7432 @ 0x8a... not found
>  tvaudio: TV audio decoder + audio/video mux driver
>  tvaudio: known chips: 
>  tda9840,tda9873h,tda9874h/a,tda9850,tda9855,tea6300,tea6320,tea6420,tda8425,pic16c54 
>  (PV951),ta8874z
>  tvaudio: found pic16c54 (PV951) @ 0x96
>  bttv0: i2c: checking for TDA9887 @ 0x86... not found
>  tuner: Unknown parameter `type'
>  bttv0: registered device video0
>  bttv0: registered device vbi0
>  bttv0: registered device radio0
>  bttv0: PLL: 28636363 => 35468950 .. ok
>  ACPI: PCI Interrupt Link [LNKB] enabled at IRQ 10
>  PCI: setting IRQ 10 as level-triggered
>  ACPI: PCI Interrupt 0000:01:0c.0[A] -> Link [LNKB] -> GSI 10 (level, low) -> 
>  IRQ 10

(cc the v4l list)

The above is with 2.6.13-rc4.  2.6.11 was OK.
