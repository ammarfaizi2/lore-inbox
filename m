Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279202AbRJ2L1Y>; Mon, 29 Oct 2001 06:27:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279207AbRJ2L1N>; Mon, 29 Oct 2001 06:27:13 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:21764 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S279202AbRJ2L1E>; Mon, 29 Oct 2001 06:27:04 -0500
Subject: Re: 2.4.13-acX: NM256 hangs at boot
To: jgarzik@mandrakesoft.com (Jeff Garzik)
Date: Mon, 29 Oct 2001 11:33:46 +0000 (GMT)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), suonpaa@iki.fi (Samuli Suonpaa),
        linux-kernel@vger.kernel.org
In-Reply-To: <3BDD3A87.B98104B0@mandrakesoft.com> from "Jeff Garzik" at Oct 29, 2001 06:16:23 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15yAfr-0002Qa-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> IIRC now, nm256 had trouble with completely locking the PCI bus if you
> touched the wrong AC97 registers.  The solution was to create
> ac97_codec_{read,write} that filtered register numbers depending on a

Certainly some setups (the Dell ones notably) you couldnt play with the 
codec except in strictly controlled manners. I thought those were just the
non ac97 weird dell ones tho

Alan
