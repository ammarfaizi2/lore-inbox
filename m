Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265958AbTGDKBh (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Jul 2003 06:01:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265960AbTGDKBh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Jul 2003 06:01:37 -0400
Received: from M913P012.adsl.highway.telekom.at ([62.47.146.12]:47489 "EHLO
	stallburg.dyndns.org") by vger.kernel.org with ESMTP
	id S265958AbTGDKBb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Jul 2003 06:01:31 -0400
Date: Fri, 4 Jul 2003 12:15:51 +0200
From: maximilian attems <maks@sternwelten.at>
To: Jeff Garzik <jgarzik@pobox.com>, '@mail.sternwelten.at
Cc: linux-kernel@vger.kernel.org, Adrian Bunk <bunk@fs.tum.de>
Subject: Re: "Will be removed in 2.4"
Message-ID: <20030704101551.GD1353@mail.sternwelten.at>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="/QKKmeG/X/bPShih"
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--/QKKmeG/X/bPShih
Content-Type: multipart/mixed; boundary="84ND8YJRMFlzkrP4"
Content-Disposition: inline


--84ND8YJRMFlzkrP4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> I would love it if someone (kernel janitors?) went through the kernel=20
> code and dug out all the comments like this.

grep -r ' [12]\.[0-9]' .|grep should > ~/comments.old
grep -r ' [12]\.[0-9]' .|grep remove >> ~/comments.old

this file has 85 lines for kernel 2.5.74
removed some occurence of firmware foo 1.1
still 63 occurences of this sort of comment
and attached the file for further work :)

a++ maks


--84ND8YJRMFlzkrP4
Content-Type: application/x-trash
Content-Disposition: attachment; filename="comments.old"
Content-Transfer-Encoding: quoted-printable

=2E/arch/i386/kernel/dmi_scan.c: *	and machine entries. For 2.5 we should p=
ull the smbus controller info=0A./arch/x86_64/ia32/sys_ia32.c: * environmen=
t. In 2.5 most of this should be moved to a generic directory. =0A./include=
/linux/mtd/mtd.h:	/* This really shouldn't be here. It can go away in 2.5 *=
/=0A./include/linux/if_bonding.h: * We can remove these ioctl definitions i=
n 2.5.  People should use the=0A./drivers/pci/setup-bus.c:/* To be fixed in=
 2.5: we should have sort of HAVE_ISA=0A./drivers/net/ibmlana.c:	added usag=
e of the isa_functions for Linux 2.3 .  Things should=0A./drivers/char/ftap=
e/RELEASE-NOTES:  This version should work with all kernel versions from 1.=
0.9 up=0A./drivers/char/dsp56k.c:/* As of 2.1.26 this should be dsp56k_poll=
,=0A./drivers/scsi/ini9100u.c: *                should work with Kernel 2.1=
.118.=0A./drivers/scsi/dpt_i2o.c:// On the real kernel ADDR32 should always=
 be zero for 2.4. GFP_HIGH allocates=0A./drivers/mtd/mtdchar.c:/* FIXME: Th=
is _really_ needs to die. In 2.5, we should lock the=0A./drivers/usb/core/h=
cd.h:/* for portability to 2.4, hcds should call this */=0A./drivers/usb/ne=
t/usbnet.c: * This should interop with whatever the 2.4 "CDCEther.c" driver=
=0A./drivers/usb/net/usbnet.c: * completion callbacks.  2.5 should have fix=
ed those bugs...=0A./drivers/usb/host/ohci-hcd.c: * 2002/01/18 package as a=
 patch for 2.5.3; this should match the=0A./drivers/ide/ide-probe.c: *	devi=
ces, so in linux 2.3.x we should change this to just treat all=0A./net/ethe=
rnet/eth.c:	 *	This ALLMULTI check should be redundant by 1.4=0A./fs/hfs/Ch=
angeLog:	re-wrote it to be similar to 2.1.x inode.c. this should=0A./fs/efs=
/inode.c:	 * during 2.3 when 32-bit dev_t become available, we should test=
=0A./Documentation/DocBook/wanbook.tmpl:	generic PPP interface that is new =
in Linux 2.3.x. The API should=0A./Documentation/video4linux/Zoran:You shou=
ld run a 2.2.x kernel in order to use this driver. The driver=0A./Documenta=
tion/networking/smc9.txt:  1. The driver should work on all kernels from 1.=
2.13 until 1.3.71.=0A./Documentation/networking/x25-iface.txt:(1) Drivers f=
or kernel versions 2.4.x and above should always check the=0A./Documentatio=
n/networking/x25-iface.txt:(2) Drivers for kernel versions 2.2.x should alw=
ays check the global=0A./Documentation/scsi/BusLogic.txt:This distribution =
was prepared for Linux kernel version 2.0.35, but should be=0A./Documentati=
on/scsi/tmscsim.txt:  and should be updated accordingly. To be fixed for 2.=
0d24.=0A./Documentation/scsi/ibmmca.txt:      driver to kernel 2.0.x and 2.=
1.x. It should therefore also run with =0A./Documentation/arm/SA1100/Itsy:T=
his should get you a properly booting 2.4 kernel on the itsy.=0A./Documenta=
tion/fb/sstfb.txt:	  This driver (should) work on ix86, with "late" 2.2.x k=
ernel (tested=0A./Documentation/cdrom/cdrom-standard.tex:drivers should imp=
lement them. Currently (as of the \linux\ 2.1.$x$=0A./Documentation/cdrom/i=
de-cd:The ide-cd driver should work with all ATAPI ver 1.2 to ATAPI 2.6 com=
pliant =0A./Documentation/magic-number.txt:Now it should be up to date with=
 Linux 2.1.112. Because=0A./Documentation/SubmittingDrivers:	The same rules=
 apply as 2.4 except that you should follow linux-kernel=0A./Documentation/=
Changes:architecture independent and any version from 2.0.0 onward should=
=0A./arch/cris/mm/init.c: *  2.4.0-test6 removed MAP_NR and inserted virt_t=
o_page=0A./arch/cris/mm/fault.c: *  * 2.4.0-test10 removed the set_pgdir in=
stantaneous kernel global mapping=0A./include/asm-x86_64/io.h: * unmapped I=
SA addresses. Will be removed in 2.4.=0A./include/linux/wait.h: * We plan t=
o remove these interfaces during 2.7.=0A./include/linux/if_bonding.h: * We =
can remove these ioctl definitions in 2.5.  People should use the=0A./inclu=
de/asm-i386/io.h: * unmapped ISA addresses. Will be removed in 2.4.=0A./dri=
vers/net/natsemi.c:	case SIOCDEVPRIVATE:		/* for binary compat, remove in 2=
.5 */=0A./drivers/net/natsemi.c:	case SIOCDEVPRIVATE+1:		/* for binary comp=
at, remove in 2.5 */=0A./drivers/net/natsemi.c:	case SIOCDEVPRIVATE+2:		/* =
for binary compat, remove in 2.5 */=0A./drivers/net/bonding/bond_main.c:		 =
* We can remove this in 2.5 because our ifenslave takes=0A./drivers/char/cy=
clades.c: * removed kernel series (2.0.x / 2.1.x) conditional compilation.=
=0A./drivers/char/cyclades.c: * was removed from latest releases of 2.1.x k=
ernel.=0A./drivers/char/cyclades.c: * in 1.3.41 kernel to remove a possible=
 race condition, extend=0A./drivers/char/specialix.c:/* * This section can =
be removed when 2.0 becomes outdated....  * */=0A./drivers/char/README.epca=
:                        4.  Updated to 2.1.36, removed #ifdefs for earlier=
=0A./drivers/serial/Kconfig:	  and will be removed during later 2.5 develop=
ment.=0A./drivers/scsi/advansys.c:         1. Now that 2.4 is released remo=
ve ifdef code for kernel versions=0A./drivers/scsi/advansys.c:            T=
his was supposed to be removed before 2.4 was released but never=0A./driver=
s/usb/input/wacom.c: *		   - Since 2.5 now has input_sync(), remove MSC_SER=
IAL abuse=0A./drivers/usb/core/inode.c: * It will be removed when the 2.7.x=
 development cycle is started.=0A./fs/ntfs/ChangeLog:	  we still do support=
 them but they will be removed with kernel 2.7.x.=0A./Documentation/network=
ing/cs89x0.txt:The compile-time optionality for DMA was removed in the 2.3 =
kernel=0A./Documentation/networking/ethertap.txt:      to be removed in the=
 2.5.x kernel series.  Those writing=0A./Documentation/sound/oss/NEWS:OSS/F=
ree configuration to userspace. In Linux 2.3 they were removed because=0A./=
Documentation/sound/oss/Introduction:required for 2.4.x kernels.  Reference=
s have been removed=0A./Documentation/ramdisk.txt:for compatibility reasons=
, but it will probably be removed in 2.1.x.=0A./Documentation/cli-sti-remov=
al.txt:as of 2.5.28, five popular macros have been removed on SMP, and=0A./=
Documentation/iostats.txt:removed from /proc/stat.  In 2.4, they appear in =
both /proc/partitions=0A./Documentation/block/biodoc.txt:The global io_requ=
est_lock has been removed as of 2.5, to avoid=0A
--84ND8YJRMFlzkrP4--

--/QKKmeG/X/bPShih
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE/BVPX6//kSTNjoX0RAuzQAJ97D5HcGRR5/CivQa2ZQ3o3CR7iBwCfbawp
GS/f90/ZcnSNMJIh7d1+ErQ=
=kscF
-----END PGP SIGNATURE-----

--/QKKmeG/X/bPShih--
