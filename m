Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291041AbSBZQVP>; Tue, 26 Feb 2002 11:21:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290965AbSBZQVF>; Tue, 26 Feb 2002 11:21:05 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:16657 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S290958AbSBZQUw>; Tue, 26 Feb 2002 11:20:52 -0500
Subject: Re: Problems with orinoco_cs and i810_audio
To: haegar@sdinet.de (Sven Koch)
Date: Tue, 26 Feb 2002 16:35:38 +0000 (GMT)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), linux-kernel@vger.kernel.org,
        hermes@gibson.dropbear.id.au
In-Reply-To: <Pine.LNX.4.40.0202261340220.695-100000@space.comunit.de> from "Sven Koch" at Feb 26, 2002 01:44:16 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16fkZm-0001AB-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > Exclude IRQ11 in your /etc/pcmcia/config - the orinoco card probably isnt
> > going to like sharing if its pcmcia not cardbus
> 
> This does not work.
> 
> Even with "exclude irq 11" in /etc/pcmcia/config.opts (included by
> /etc/pcmcia/config) orinoco_cs reports on loading:

You don't have IRQ 11 excluded

> Feb 26 13:38:46 aurora kernel: eth1: index 0x01: Vcc 3.3, irq 11, io
                                                           ^^^^^^^^
> 0x0100-0x013f


Make sure you restart pcmcia-cs and check for any errors in the logs
