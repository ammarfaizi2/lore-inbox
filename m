Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272282AbRIPOnr>; Sun, 16 Sep 2001 10:43:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272322AbRIPOnh>; Sun, 16 Sep 2001 10:43:37 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:46854 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S272282AbRIPOn2>; Sun, 16 Sep 2001 10:43:28 -0400
Subject: Re: Athlon: Try this (was: Re: Athlon bug stomping #2)
To: vojtech@suse.cz (Vojtech Pavlik)
Date: Sun, 16 Sep 2001 15:47:55 +0100 (BST)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), vandrove@vc.cvut.cz (Petr Vandrovec),
        linux-kernel@vger.kernel.org, VDA@port.imtp.ilyichevsk.odessa.ua
In-Reply-To: <20010916155045.A5671@suse.cz> from "Vojtech Pavlik" at Sep 16, 2001 03:50:45 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15idD9-0005LA-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > One way to test this hypthesis maybe to run dmidecode on the machines and
> > see if they report KT133 or KT133A. Its also possible some BIOS code does
> > blindly program bit 7 even tho its reserved and should have been kept
> > unchanged.
> 
> I think it's possible to decide whether a chipset is KT133 or KT133A
> based on the hostbridge revision. Mine is KT133 and is rev 03.

That tells you the chipset of the bridge. dmidecode dumps bios strings which
may tell you the chipset the bios was actually for..
