Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279886AbRJ3JRr>; Tue, 30 Oct 2001 04:17:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279898AbRJ3JRh>; Tue, 30 Oct 2001 04:17:37 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:11793 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S279886AbRJ3JR3>; Tue, 30 Oct 2001 04:17:29 -0500
Subject: Re: SiS sound driver
To: sgy@amc.com.au (Stuart Young)
Date: Tue, 30 Oct 2001 09:24:11 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org, alan@lxorguk.ukuu.org.uk (Alan Cox)
In-Reply-To: <5.1.0.14.0.20011030133431.00a70b90@mail.amc.localnet> from "Stuart Young" at Oct 30, 2001 02:50:14 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15yV7z-0005sP-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>   PCI: Sharing IRQ 5 with 00:0c.1
>   trident: SiS 7018 PCI Audio found at IO 0x1000, IRQ 5
>   ac97_codec: AC97  codec, id: 0x0000:0x0000 (Unknown)

It's failing to initialise the AC97 codec. That may be timing (try longer
delays for one). Also try load, unload, load sequences. It may be the ac97
is wired strangely on your box.
