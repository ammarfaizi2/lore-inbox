Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129078AbRBNTHj>; Wed, 14 Feb 2001 14:07:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129144AbRBNTHc>; Wed, 14 Feb 2001 14:07:32 -0500
Received: from Guard.PolyNet.Lviv.UA ([217.9.2.1]:55309 "HELO
	guard.polynet.lviv.ua") by vger.kernel.org with SMTP
	id <S129078AbRBNTHX>; Wed, 14 Feb 2001 14:07:23 -0500
Date: 14 Feb 2001 21:03:08 +0200
Message-ID: <15273990267.20010214210308@polynet.lviv.ua>
From: "Andriy Korud" <akorud@polynet.lviv.ua>
Reply-To: "Andriy Korud" <akorud@polynet.lviv.ua>
To: linux-kernel@vger.kernel.org
X-Mailer: The Bat! (v1.49)
X-Priority: 3 (Normal)
Subject: Re: Linux 2.2.19pre12
In-Reply-To: <E14T4sK-0005O1-00@the-village.bc.nu>
In-Reply-To: <E14T4sK-0005O1-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Alan,

Wednesday, February 14, 2001, 6:33:49 PM, you wrote:


Alan> 2.2.19pre12
Alan> o       Update the DAC960 driver                        (Leonard Zubkoff)
Alan> o       Small PPC fixes                                 (Benjamin Herrenschmidt)
Alan> o       Document irda options config                    (Steven Cole)
Alan> o       Small isdn fixes/obsolete code removal          (Kai Germaschewski)
Alan> o       Fix alpha kernel builds                         (Michal Jaegermann)
Alan> o       Update ver_linux to match the 2.4 one           (Steven Cole)
Alan> o       AVM isdn driver updates                         (Carsten Paeth)
Alan> o       ISDN capi/ppp fixes                             (Kai Germaschewski)

When trying to compile:

rm -f scsi_n_syms.o
ld -m elf_i386  -r -o scsi_n_syms.o scsi.o
cc -D__KERNEL__ -I/usr/src/linux/include -Wall -Wstrict-prototypes -O2 -fomit-fr
ame-pointer -fno-strict-aliasing -pipe -fno-strength-reduce -m486 -malign-loops=
2 -malign-jumps=2 -malign-functions=2 -DCPU=686   -c -o hosts.o hosts.c
hosts.c:139: aic7xxx.h: No such file or directory
hosts.c:500: `AIC7XXX' undeclared here (not in a function)
hosts.c:500: initializer element for `builtin_scsi_hosts[0]' is not constant
make[3]: *** [hosts.o] Error 1
make[3]: Leaving directory `/usr/src/linux/drivers/scsi'
make[2]: *** [first_rule] Error 2
make[2]: Leaving directory `/usr/src/linux/drivers/scsi'
make[1]: *** [_subdir_scsi] Error 2
make[1]: Leaving directory `/usr/src/linux/drivers'
make: *** [_dir_drivers] Error 2


-- 
Best regards,
 Andriy                            mailto:akorud@polynet.lviv.ua


