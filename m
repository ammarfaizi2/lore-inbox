Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315414AbSH0HyC>; Tue, 27 Aug 2002 03:54:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315415AbSH0HyC>; Tue, 27 Aug 2002 03:54:02 -0400
Received: from smtp-out-6.wanadoo.fr ([193.252.19.25]:65218 "EHLO
	mel-rto6.wanadoo.fr") by vger.kernel.org with ESMTP
	id <S315414AbSH0HyB>; Tue, 27 Aug 2002 03:54:01 -0400
Message-ID: <3D6B30E4.EE502613@wanadoo.fr>
Date: Tue, 27 Aug 2002 09:57:24 +0200
From: Jean-Luc Coulon <jean-luc.coulon@wanadoo.fr>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.20-pre4 i586)
X-Accept-Language: fr-FR, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: 2.4.20-pre4-ac2 does not compile
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi !

ld -m elf_i386  -r -o idedriver.o ide-probe.o ide-geometry.o ide-iops.o
ide-taskfile.o ide.o ide-lib.o ide-disk.o ide-dma.o ide-proc.o
setup-pci.o pci/idedriver-pci.o legacy/idedriver-legacy.o
ppc/idedriver-ppc.o arm/idedriver-arm.o raid/idedriver-raid.o
ld: cannot open pci/idedriver-pci.o: No such file or directory
make[4]: *** [idedriver.o] Erreur 1
make[4]: Leaving directory `/usr/src/linux/drivers/ide'
make[3]: *** [first_rule] Erreur 2
make[3]: Leaving directory `/usr/src/linux/drivers/ide'
make[2]: *** [_subdir_ide] Erreur 2
make[2]: Leaving directory `/usr/src/linux/drivers'
make[1]: *** [_dir_drivers] Erreur 2
make[1]: Leaving directory `/usr/src/linux'
make: *** [stamp-build] Erreur 2

--------
Regards
	Jean-Luc
