Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130741AbRCIX1p>; Fri, 9 Mar 2001 18:27:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130766AbRCIX1Z>; Fri, 9 Mar 2001 18:27:25 -0500
Received: from ulima.unil.ch ([130.223.144.143]:39437 "EHLO ulima.unil.ch")
	by vger.kernel.org with ESMTP id <S130741AbRCIX1X>;
	Fri, 9 Mar 2001 18:27:23 -0500
Date: Sat, 10 Mar 2001 00:26:40 +0100
From: FAVRE Gregoire <greg@ulima.unil.ch>
To: linux-kernel@vger.kernel.org
Subject: linux-2.4.2-ac1[67] aicam compil error
Message-ID: <20010310002640.A13924@ulima.unil.ch>
Mail-Followup-To: FAVRE Gregoire <greg@ulima.unil.ch>,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.15i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Sorry if that has already been posted, I read the m-l via newsgroups.
When I try to compile, I got:
make[4]: Entering directory
`/usr/src/linux-2.4.2-ac17/drivers/scsi/aic7xxx'
make -C aicasm
make[5]: Entering directory
`/usr/src/linux-2.4.2-ac17/drivers/scsi/aic7xxx/aicasm'
kgcc -I/usr/include -ldb aicasm_gram.c aicasm_scan.c aicasm.c
aicasm_symbol.c -o aicasm
aicasm/aicasm_gram.y:45: ../queue.h: No such file or directory
aicasm/aicasm_gram.y:50: aicasm.h: No such file or directory
aicasm/aicasm_gram.y:51: aicasm_symbol.h: No such file or directory
aicasm/aicasm_gram.y:52: aicasm_insformat.h: No such file or directory
aicasm/aicasm_scan.l:44: ../queue.h: No such file or directory
aicasm/aicasm_scan.l:49: aicasm.h: No such file or directory
aicasm/aicasm_scan.l:50: aicasm_symbol.h: No such file or directory
aicasm/aicasm_scan.l:51: y.tab.h: No such file or directory
make[5]: *** [aicasm] Error 1
make[5]: Leaving directory
`/usr/src/linux-2.4.2-ac17/drivers/scsi/aic7xxx/aicasm'
make[4]: *** [aicasm/aicasm] Error 2
make[4]: Leaving directory
`/usr/src/linux-2.4.2-ac17/drivers/scsi/aic7xxx'
make[3]: *** [first_rule] Error 2
make[3]: Leaving directory
`/usr/src/linux-2.4.2-ac17/drivers/scsi/aic7xxx'
make[2]: *** [_subdir_aic7xxx] Error 2
make[2]: Leaving directory `/usr/src/linux-2.4.2-ac17/drivers/scsi'
make[1]: *** [_subdir_scsi] Error 2
make[1]: Leaving directory `/usr/src/linux-2.4.2-ac17/drivers'
make: *** [_dir_drivers] Error 2
Exit 2

And voila...

	Greg
________________________________________________________________
http://ulima.unil.ch/greg ICQ:16624071 mailto:greg@ulima.unil.ch
