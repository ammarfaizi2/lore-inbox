Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313189AbSEMOaE>; Mon, 13 May 2002 10:30:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313307AbSEMOaD>; Mon, 13 May 2002 10:30:03 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:5893 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S313189AbSEMOaC>; Mon, 13 May 2002 10:30:02 -0400
Subject: Re: More UDMA Troubles
To: ap.leblanc@shaw.ca (Andre LeBlanc)
Date: Mon, 13 May 2002 15:49:49 +0100 (BST)
Cc: linux-kernel@vger.kernel.org, Lionel.Bouton@inet6.fr (Lionel Bouton),
        andre@linux-ide.org
In-Reply-To: <001801c1faa0$fcb7cd60$2000a8c0@metalbox> from "Andre LeBlanc" at May 13, 2002 10:09:47 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E177H93-0005Yf-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I think that running that, hdparm command may have actually done some damage
> to my computer... since then my BIOS Occasionally doesn't recognize my hard
> drive, and Windows 2000 keeps getting bluescreens during the boot process,
> it took 4 tries to get it to boot properly, and I ahve a feeling it will
> lock up eventually. (I've never had a bluescreen uder 2000 before.)

hdparm just sets configuration variables, they should be lost on physical
power off but might survive a warm boot (even then the bios ought to have
shoved things back into its idea of ide happy mode)

