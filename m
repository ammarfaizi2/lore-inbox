Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314227AbSFDPgg>; Tue, 4 Jun 2002 11:36:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314149AbSFDPgf>; Tue, 4 Jun 2002 11:36:35 -0400
Received: from grunt.ksu.ksu.edu ([129.130.12.17]:45749 "EHLO
	mailhub.cns.ksu.edu") by vger.kernel.org with ESMTP
	id <S314101AbSFDPge>; Tue, 4 Jun 2002 11:36:34 -0400
Date: Tue, 4 Jun 2002 10:36:34 -0500
From: Joseph Pingenot <trelane@digitasaru.net>
To: linux-kernel@vger.kernel.org
Subject: Build error on 2.5.20 under unstable debian
Message-ID: <20020604103633.A14326@ksu.edu>
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
X-School: Kansas State University
X-vi-or-emacs: vi
X-MSMail-Priority: High
X-Priority: 1 (Highest)
X-MS-TNEF-Correlator: <AFJAUFHRUOGRESULWAOIHFEAUIOFBVHSHNRAIU.monkey@spamcentral.invalid>
X-MimeOLE: Not Produced By Microsoft MimeOLE V5.50.4522.1200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ld -m elf_i386 -T /usr/local/src/kernel/linux-2.5.20/arch/i386/vmlinux.lds -e stext arch/i386/kernel/head.o arch/i386/kernel/init_task.o init/init.o --start-group arch/i386/kernel/kernel.o arch/i386/mm/mm.o kernel/kernel.o mm/mm.o fs/fs.o ipc/ipc.o /usr/local/src/kernel/linux-2.5.20/arch/i386/lib/lib.a /usr/local/src/kernel/linux-2.5.20/lib/lib.a /usr/local/src/kernel/linux-2.5.20/arch/i386/lib/lib.a drivers/built-in.o sound/sound.o arch/i386/pci/pci.o net/network.o --end-group -o vmlinux
drivers/built-in.o(.rodata+0x20298): undefined reference to `local symbols in discarded section .text.exit'
make: *** [vmlinux] Error 1

Not sure how to debug this further.  Anyone know how to fix this or how
  to get more info?

Thanks!

-Joseph
-- 
Joseph======================================================jap3003@ksu.edu
"Ich bin ein Penguin."  --/. poster mmarlett, responding to news that the
  Bundestag will move to IBM/SuSE Linux.  
                      http://slashdot.org/comments.pl?sid=33588&cid=3631032
