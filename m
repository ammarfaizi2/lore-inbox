Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129299AbRBLXq4>; Mon, 12 Feb 2001 18:46:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129274AbRBLXqp>; Mon, 12 Feb 2001 18:46:45 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:14854 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S129159AbRBLXqc>; Mon, 12 Feb 2001 18:46:32 -0500
Subject: Re: opl3sa not detected anymore
To: jauge@club-internet.fr (Jérôme Augé)
Date: Mon, 12 Feb 2001 23:46:39 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <3A8873F3.772D75E7@club-internet.fr> from "Jérôme Augé" at Feb 13, 2001 12:38:27 AM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14SSg6-00004v-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > The midi works fine, but 'modprobe sound' reports:
> > opl3sa2: No cards found
> > opl3sa2: 0 PnP card(s) found.

Thats ok, it may not be set up for isapnp

> Try to add "isapnp=3D0" to the opl3sa2 options list :
> 
> opl3sa2 mss_io=3D0x530 irq=3D5 dma=3D1 dma2=3D0 mpu_io=3D0x330 io=3D0x3=
> 70 isapnp=3D0
> 
> I had the same problem and adding isapnp=3D0 solved it, but PNP isn't
> supposed to automaticaly detect those options ?

No, but if you set options it would kind of make sense to turn off the
isapnp automatically 8). I'll look into that.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://vger.kernel.org/lkml/
