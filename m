Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310182AbSC1B2D>; Wed, 27 Mar 2002 20:28:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311288AbSC1B1y>; Wed, 27 Mar 2002 20:27:54 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:31496 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S310182AbSC1B1q>; Wed, 27 Mar 2002 20:27:46 -0500
Subject: Re: Compile error in kernel 2.2.21-rc2
To: pceric@holly.colostate.edu (Eric H)
Date: Thu, 28 Mar 2002 01:00:55 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org, pceric@holly.colostate.edu
In-Reply-To: <3CA26678.2000204@holly.colostate.edu> from "Eric H" at Mar 27, 2002 05:40:24 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16qOHf-0006bQ-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I receive the following error while trying to compile kernel 2.2.21-rc2 
> using gcc 2.96 (RedHat 7.2)
> ...
> drivers/scsi/scsi.a(aic7xxx.o): In function `aic7xxx_load_seeprom':
> aic7xxx.o(.text+0x1166f): undefined reference to `memcpy'
> make: *** [vmlinux] Error 1

Please don't use gcc 2.96/gcc 3.0/3.1 snapshots to build 2.2 kernels. The
kernel tree contains some assumptions that dont work with the newer compilers
