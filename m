Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129903AbRAMXlj>; Sat, 13 Jan 2001 18:41:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130781AbRAMXl2>; Sat, 13 Jan 2001 18:41:28 -0500
Received: from green.mif.pg.gda.pl ([153.19.42.8]:6148 "EHLO
	green.mif.pg.gda.pl") by vger.kernel.org with ESMTP
	id <S129903AbRAMXlR>; Sat, 13 Jan 2001 18:41:17 -0500
From: Andrzej Krzysztofowicz <ankry@green.mif.pg.gda.pl>
Message-Id: <200101132340.AAA00985@green.mif.pg.gda.pl>
Subject: Re: ide.2.4.1-p3.01112001.patch
To: vojtech@suse.cz (Vojtech Pavlik)
Date: Sun, 14 Jan 2001 00:40:58 +0100 (CET)
Cc: linux-kernel@vger.kernel.org (kernel list)
X-Mailer: ELM [version 2.5 PL0pre8]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>From kufel!ankry  Sun Jan 14 00:30:25 2001
Return-Path: <kufel!ankry>
Received: from kufel.UUCP (uucp@localhost)
	by green.mif.pg.gda.pl (8.9.3/8.9.3) with UUCP id AAA00889
	for green.mif.pg.gda.pl!ankry; Sun, 14 Jan 2001 00:30:25 +0100
Received: (from ankry@localhost)
	by kufel.dom (8.9.3/8.9.3) id WAA01107
	for green!ankry; Sat, 13 Jan 2001 22:00:40 +0100
From: Andrzej Krzysztofowicz <kufel!ankry>
Message-Id: <200101132100.WAA01107@kufel.dom>
Subject: Re: ide.2.4.1-p3.01112001.patch
To: kufel!green.mif.pg.gda.pl!ankry
Date: Sat, 13 Jan 2001 22:00:40 +0100 (CET)
In-Reply-To: <20010113144236.B1155@suse.cz> from "Vojtech Pavlik" at Jan 13, 2001 02:42:36 PM
X-Mailer: ELM [version 2.5 PL0pre8]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

vojtech@suse.cz (Vojtech Pavlik)

> > 2.4 has code in the pci quirks to disable the register which makes
> > the chip masquerade as a VP3, and forces it to identify itself as
> > an MVP3 part.  I'm curious whether this has an interaction here.
> 
> This doesn't do anything but change the ID so that Linux drivers are not
> confused anymore. This caused a lot of trouble in 2.2, especially with
> the old VIA IDE driver.
[...]
> Fortunately all these chips use PIIX-compatible extensions to the PCI
> bus, so they are all interchangeable to some degree.
> 
> > I'm curious if all of the other boards in Alans bug reports also
> > fall into the stranger category.
> 
> It's possible. I have a board (VA-503A), which has a masqueraded 598,
> which identifies itself as 597, and a 686a southbridge. This got the
> 2.2 ide driver completely confused, for example. 

Maybe the VIA IDE chipset support option should depend on PCI quirks now ?



-- 
=======================================================================
  Andrzej M. Krzysztofowicz               ankry@mif.pg.gda.pl
  tel.  (0-58) 347 14 61
Wydz.Fizyki Technicznej i Matematyki Stosowanej Politechniki Gdanskiej
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
