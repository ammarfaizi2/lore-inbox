Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135947AbREAOwH>; Tue, 1 May 2001 10:52:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136620AbREAOvs>; Tue, 1 May 2001 10:51:48 -0400
Received: from ulima.unil.ch ([130.223.144.143]:7180 "EHLO ulima.unil.ch")
	by vger.kernel.org with ESMTP id <S135947AbREAOvl>;
	Tue, 1 May 2001 10:51:41 -0400
Date: Tue, 1 May 2001 16:51:38 +0200
From: FAVRE Gregoire <greg@ulima.unil.ch>
To: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.4-ac2 Compilation error...
Message-ID: <20010501165138.B5946@ulima.unil.ch>
Mail-Followup-To: FAVRE Gregoire <greg@ulima.unil.ch>,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="gatW/ieO32f1wygP"
Content-Disposition: inline
User-Agent: Mutt/1.3.15i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--gatW/ieO32f1wygP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Thus spake Alan Cox (alan@lxorguk.ukuu.org.uk):

> 2.4.4-ac2

I got:

gcc -D__KERNEL__ -I/usr/src/linux-2.4.4-ac2/include -Wall
-Wstrict-prototypes -O2 -fomit-frame-pointer -fno-strict-aliasing
+-pipe -mpreferred-stack-boundary=2 -march=i686    -c -o pci-pc.o
pci-pc.c
{standard input}: Assembler messages:
{standard input}:784: Warning: indirect lcall without `*'
{standard input}:869: Warning: indirect lcall without `*'
{standard input}:955: Warning: indirect lcall without `*'
{standard input}:993: Warning: indirect lcall without `*'
{standard input}:1025: Warning: indirect lcall without `*'
{standard input}:1057: Warning: indirect lcall without `*'
{standard input}:1088: Warning: indirect lcall without `*'
{standard input}:1117: Warning: indirect lcall without `*'
{standard input}:1146: Warning: indirect lcall without `*'
{standard input}:1433: Warning: indirect lcall without `*'
{standard input}:1529: Warning: indirect lcall without `*'
gcc -D__KERNEL__ -I/usr/src/linux-2.4.4-ac2/include -Wall
-Wstrict-prototypes -O2 -fomit-frame-pointer -fno-strict-aliasing
+-pipe -mpreferred-stack-boundary=2 -march=i686    -c -o pci-irq.o
pci-irq.c
In file included from pci-irq.c:19:
/usr/src/linux-2.4.4-ac2/include/asm/io_apic.h:98: `MAX_IRQ_SOURCES'
undeclared here (not in a function)
make[1]: *** [pci-irq.o] Error 1
make[1]: Leaving directory `/usr/src/linux-2.4.4-ac2/arch/i386/kernel'
make: *** [_dir_arch/i386/kernel] Error 2
541.570u 48.620s 13:32.67 72.6% 0+0k 0+0io 609749pf+0w
Exit 2

gcc version 2.96 20000731 (Linux-Mandrake 7.3)

	Greg
________________________________________________________________
http://ulima.unil.ch/greg ICQ:16624071 mailto:greg@ulima.unil.ch

--gatW/ieO32f1wygP
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.4 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD4DBQE67s16FDWhsRXSKa0RAhhVAJidSyGwvfdpz+g/UfhAfcq36RoRAJ9MPOp2
B2q6Kx6bO+Eso+GBOYoJuw==
=Lpv1
-----END PGP SIGNATURE-----

--gatW/ieO32f1wygP--
