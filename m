Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313181AbSEVMzE>; Wed, 22 May 2002 08:55:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313182AbSEVMzD>; Wed, 22 May 2002 08:55:03 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:4112 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S313181AbSEVMzC>; Wed, 22 May 2002 08:55:02 -0400
Subject: Re: nVidia NIC/IDE/something support?
To: fchabaud@free.fr
Date: Wed, 22 May 2002 14:15:16 +0100 (BST)
Cc: pavel@suse.cz, linux-kernel@vger.kernel.org
In-Reply-To: <200205220605.g4M65cI14609@colombe.home.perso> from "fchabaud@free.fr" at May 22, 2002 08:05:35 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E17AVxU-0001bm-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> nvidia help for swsusp would be nice also. I tried the patch on my
> desktop for the first time and it seems to work reliably (even from X)
> except that 3D is lost after resume. That's rather curious: menus
> without highlights or things like that.

I've seen a few machines where you have to reinitialize the GART. Thats
where the pm hooks for the agpgart code came from. That may be worth a try.
