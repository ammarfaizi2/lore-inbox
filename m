Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290973AbSBGA1D>; Wed, 6 Feb 2002 19:27:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291007AbSBGA04>; Wed, 6 Feb 2002 19:26:56 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:41231 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S290973AbSBGA0o>; Wed, 6 Feb 2002 19:26:44 -0500
Subject: Re: driverfs support for motherboard devices
To: pavel@suse.cz (Pavel Machek)
Date: Thu, 7 Feb 2002 00:38:39 +0000 (GMT)
Cc: mochel@osdl.org (Patrick Mochel), andre@linuxdiskcert.org (Andre Hedrick),
        rmk@arm.linux.org.uk (Russell King), pavel@suse.cz (Pavel Machek),
        linux-kernel@vger.kernel.org (kernel list)
In-Reply-To: <20020206122253.GB446@elf.ucw.cz> from "Pavel Machek" at Feb 06, 2002 01:22:55 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16YcaF-0006z9-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Case 5: 486 with both PCI and VLB, where ide is on the VLB?
> 
> cases 4 and 5 are IMO hard, because it is difficult to know where it
> really is... and I'm not sure current kernel knows it.

I suspect PnPBIOS knows for the 486. There is PnPbios code in 2.4-ac 
perfectly ready for a 2.5 merger
