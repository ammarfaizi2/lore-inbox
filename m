Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280956AbRKOR0G>; Thu, 15 Nov 2001 12:26:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280954AbRKORZ5>; Thu, 15 Nov 2001 12:25:57 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:50701 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S280953AbRKORZy>; Thu, 15 Nov 2001 12:25:54 -0500
Subject: Re: Maestro 2E vs. Power mgmt
To: fauxpas@temp123.org (Faux Pas III)
Date: Thu, 15 Nov 2001 17:33:41 +0000 (GMT)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), linux-kernel@vger.kernel.org
In-Reply-To: <20011115122221.A11236@temp123.org> from "Faux Pas III" at Nov 15, 2001 12:22:21 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E164QOT-0000z0-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > Nothing immediately strikes me - could be its not got CLKRUN wired up
> > properly. What pci bridges does it have ?
> 
> frabjous:~# lspci
> 00:00.0 Host bridge: Intel Corporation 440BX/ZX - 82443BX/ZX Host bridge (AGP disabled) (rev 03)
> 00:04.0 VGA compatible controller: Neomagic Corporation [MagicMedia 256AV] (rev 12)
> 00:05.0 Bridge: Intel Corporation 82371AB PIIX4 ISA (rev 02)

Ok. Well if it is the CLKRUN stuff then I can give you a diff to try if you
are happy rebuilding kernels

Alan
