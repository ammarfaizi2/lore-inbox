Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271631AbRH0AX2>; Sun, 26 Aug 2001 20:23:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271633AbRH0AXR>; Sun, 26 Aug 2001 20:23:17 -0400
Received: from sproxy.gmx.net ([213.165.64.20]:13752 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id <S271631AbRH0AXC>;
	Sun, 26 Aug 2001 20:23:02 -0400
Date: Sun, 26 Aug 2001 12:00:18 +0200
From: "Manfred H. Winter" <mahowi@gmx.net>
To: Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: [2.4.9] aic7xxx modules don't compile
Message-ID: <20010826120017.A2998@marvin.mahowi.de>
Mail-Followup-To: Linux Kernel List <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
User-Agent: Mutt/1.3.18i
X-Operating-System: Linux 2.4.7 i686
X-Editor: VIM - Vi IMproved 5.7 (2000 Jun 24, compiled Apr  6 2001 09:59:07)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

The compilation of the kernel modules (2.4.9) stops with:

make -C aic7xxx modules
make[3]: Entering directory `/usr/src/linux-2.4.9/drivers/scsi/aic7xxx'
make -C aicasm
make[4]: Entering directory `/usr/src/linux-2.4.9/drivers/scsi/aic7xxx/aicasm'
gcc -I/usr/include -I. -ldb aicasm_gram.c aicasm_scan.c aicasm.c aicasm_symbol.c -o aicasm
aicasm/aicasm_scan.l: In function `yylex':
aicasm/aicasm_scan.l:115: `T_VERSION' undeclared (first use in this function)
aicasm/aicasm_scan.l:115: (Each undeclared identifier is reported only once
aicasm/aicasm_scan.l:115: for each function it appears in.)
aicasm/aicasm_scan.l:132: `T_STRING' undeclared (first use in this function)
make[4]: *** [aicasm] Error 1
make[4]: Leaving directory `/usr/src/linux-2.4.9/drivers/scsi/aic7xxx/aicasm'
make[3]: *** [aicasm/aicasm] Error 2
make[3]: Leaving directory `/usr/src/linux-2.4.9/drivers/scsi/aic7xxx'
make[2]: *** [_modsubdir_aic7xxx] Error 2
make[2]: Leaving directory `/usr/src/linux-2.4.9/drivers/scsi'
make[1]: *** [_modsubdir_scsi] Error 2
make[1]: Leaving directory `/usr/src/linux-2.4.9/drivers'
make: *** [_mod_drivers] Error 2

Is this a known problem?

Bye,

Manfred
-- 
 /"\                        |  *  AIM: mahowi42  *  ICQ: 61597169  *
 \ /  ASCII ribbon campaign | PGP-Key available at Public Key Servers
  X   against HTML mail     | or "http://www.mahowi.de/pgp/mahowi.asc"
 / \  and postings          |  * RSA: 0xC05BC0F5 * DSS: 0x4613B5CA *
