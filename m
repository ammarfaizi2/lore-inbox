Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317938AbSGQA4l>; Tue, 16 Jul 2002 20:56:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317949AbSGQA4k>; Tue, 16 Jul 2002 20:56:40 -0400
Received: from rwcrmhc53.attbi.com ([204.127.198.39]:28122 "EHLO
	rwcrmhc53.attbi.com") by vger.kernel.org with ESMTP
	id <S317938AbSGQA4j>; Tue, 16 Jul 2002 20:56:39 -0400
Date: Tue, 16 Jul 2002 19:59:30 -0500 (CDT)
From: "Justin M. Forbes" <kernelmail@attbi.com>
X-X-Sender: jmforbes@leaper.linuxtx.org
To: marcelo@conectiva.com.br
cc: linux-kernel@vger.kernel.org
Subject: 2.4.19-rc2 compile fail
Message-ID: <Pine.LNX.4.44.0207161957140.11639-100000@leaper.linuxtx.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I get this failure when trying to compile 2.4.19-rc2


gcc -E -D__KERNEL__ -I/usr/src/linux-2.4.19-rc2/include -traditional 
-DCHIP=710 fake7.c | grep -v '^#' | perl -s script_asm.pl -ncr7x0_family
script_asm.pl : Illegal combination of registers in line 72 : 	MOVE 
CTEST7 & 0xef TO CTEST7
	Either source and destination registers must be the same,
	or either source or destination register must be SFBR.
make[2]: *** [sim710_d.h] Error 255
make[2]: Leaving directory `/usr/src/linux-2.4.19-rc2/drivers/scsi'
make[1]: *** [_modsubdir_scsi] Error 2
make[1]: Leaving directory `/usr/src/linux-2.4.19-rc2/drivers'
make: *** [_mod_drivers] Error 

Justin M. Forbes

