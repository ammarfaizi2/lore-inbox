Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313111AbSC1JSn>; Thu, 28 Mar 2002 04:18:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313112AbSC1JSe>; Thu, 28 Mar 2002 04:18:34 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:36618 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S313111AbSC1JSY>; Thu, 28 Mar 2002 04:18:24 -0500
Subject: Re: IDE and hot-swap disk caddies
To: jerj@coplanar.net (Jeremy Jackson)
Date: Thu, 28 Mar 2002 09:33:48 +0000 (GMT)
Cc: andre@linux-ide.org (Andre Hedrick), bcrl@redhat.com (Benjamin LaHaise),
        andersen@codepoet.org (Erik Andersen), josh@stack.nl (Jos Hulzink),
        jw@pegasys.ws (jw schultz), linux-kernel@vger.kernel.org
In-Reply-To: <00c901c1d5fc$ec682e50$7e0aa8c0@bridge> from "Jeremy Jackson" at Mar 27, 2002 06:02:50 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16qWI0-0007Hb-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> -some very cheap IDE swap bays have a mechanical interlock
> with the power switch.  Your turn the key, and the drive shuts
> off, before you can pull it out.  power sequencing solved? don't

No - you also have to isolate the IDE bus

> -PCMCIA has electrical hot swap support...?

Yes - but PCMCIA is effectively hot swap ISA bus, the controller is on
the pcmcia card - different ball game
