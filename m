Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266488AbRIPNt2>; Sun, 16 Sep 2001 09:49:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271129AbRIPNtT>; Sun, 16 Sep 2001 09:49:19 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:31494 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S266488AbRIPNtH>; Sun, 16 Sep 2001 09:49:07 -0400
Subject: Re: Athlon: Try this (was: Re: Athlon bug stomping #2)
To: vojtech@suse.cz (Vojtech Pavlik)
Date: Sun, 16 Sep 2001 14:53:17 +0100 (BST)
Cc: vandrove@vc.cvut.cz (Petr Vandrovec), linux-kernel@vger.kernel.org,
        VDA@port.imtp.ilyichevsk.odessa.ua, alan@lxorguk.ukuu.org.uk
In-Reply-To: <20010916130201.A1327@suse.cz> from "Vojtech Pavlik" at Sep 16, 2001 01:02:01 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15icMH-0005H3-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > to 0x89 and it happilly lives... So maybe some BIOS vendors
> > used KT133 instead of KT133A BIOS image?
> 
> Same here ...

One way to test this hypthesis maybe to run dmidecode on the machines and
see if they report KT133 or KT133A. Its also possible some BIOS code does
blindly program bit 7 even tho its reserved and should have been kept
unchanged.

Alan
