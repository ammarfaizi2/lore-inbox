Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132171AbRCVTzh>; Thu, 22 Mar 2001 14:55:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132169AbRCVTz1>; Thu, 22 Mar 2001 14:55:27 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:16905 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S132166AbRCVTzX>; Thu, 22 Mar 2001 14:55:23 -0500
Subject: Re: Weird bttv errors and video hangs with 2.4.2-ac21
To: sorisor@Hell.WH8.TU-Dresden.De (Udo A. Steinberg)
Date: Thu, 22 Mar 2001 19:57:19 +0000 (GMT)
Cc: kraxel@strusel007.de, linux-kernel@vger.kernel.org (Linux Kernel)
In-Reply-To: <3ABA5089.9DE6E8B7@Hell.WH8.TU-Dresden.De> from "Udo A. Steinberg" at Mar 22, 2001 08:20:41 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14gBCz-0003Bw-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> With -ac21 I'm getting occasional long delays in video output with xawtv
> or the picture totally freezes until I click with the mouse in the xawtv
> window. dmesg shows:

You have a VIA chipset ?

> bttv0: resetting chip
> bttv0: PLL: 28636363 => 35468950 ... ok
> bttv0: irq: OCERR risc_count=0fb54810
> 
> All of this did not happen with -ac20 under the exact same circumstances,
> so -ac21 does something which the bttv driver (0.7.57) doesn't quite like.

The only candidate I can think of is the pci quirk stuff added for the VIA
chipsets

