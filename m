Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316636AbSEVS1g>; Wed, 22 May 2002 14:27:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316649AbSEVS0W>; Wed, 22 May 2002 14:26:22 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:60677 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S316636AbSEVSZs>; Wed, 22 May 2002 14:25:48 -0400
Subject: Re: Orinoco Wireless driver bugs in 2.5.17
To: jt@hpl.hp.com
Date: Wed, 22 May 2002 19:24:37 +0100 (BST)
Cc: linux-kernel@vger.kernel.org (Linux kernel mailing list),
        alan@lxorguk.ukuu.org.uk (Alan Cox),
        hermes@gibson.dropbear.id.au (David Gibson)
In-Reply-To: <20020522103834.B10921@bougret.hpl.hp.com> from "Jean Tourrilhes" at May 22, 2002 10:38:35 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E17Aams-0002Ue-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 	Alan,
> 	Could you be more precise and point out which kernel start
> failing ?

Certainly in 2.4.18 (and I've seen a pile of other similar reports).

> 	If I remember properly my debug session with Alan (that was a
> long while ago), the COR reset was screwing up the firmware (well, how
> many time did I told you to not make it mandatory ?).

Long time ago -its been behaving well until fairly recently

> 	Alan has an old Compaq card (the Intersil PrismII variety, not
> the new Lucent one) and his firmware is probably not very fresh.

Oldish firmware definitely. The newer driver finds the card registers
it but fails on all tx/rx and reports no signal and noise of
130/150 or so (as opposed to db). Flipping back to the older kernel it
works happily. 

Any specific info/debug/traces that would help ?


Alan
