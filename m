Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319784AbSIMUdH>; Fri, 13 Sep 2002 16:33:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319786AbSIMUdH>; Fri, 13 Sep 2002 16:33:07 -0400
Received: from mailout03.sul.t-online.com ([194.25.134.81]:12469 "EHLO
	mailout03.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S319784AbSIMUdC>; Fri, 13 Sep 2002 16:33:02 -0400
Date: Fri, 13 Sep 2002 22:37:37 +0200
From: Hans-Joachim Baader <hjb@pro-linux.de>
To: linux-kernel@vger.kernel.org
Subject: 2.4.20-pre7 MIPS compile error
Message-ID: <20020913203733.GB6178@mandel.hjbaader.home>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="hQiwHBbRI9kgIhsi"
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--hQiwHBbRI9kgIhsi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

in the MIPS architecture I get the following error:

gcc -D__KERNEL__ -I/var/src/linux-2.4.20-pre7/include -Wall -Wstrict-protot=
ypes
-Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -fomit-frame-pointer -I=
 /var/src/linux-2.4.20-pre7/include/asm/gcc -G 0 -mno-abicalls -fno-pic -pi=
pe -mcpu=3Dr4600 -mips2 -Wa,--trap   -nostdinc -iwithprefix include -DKBUIL=
D_BASENAME=3Dbinfmt_elf  -c -o binfmt_elf.o binfmt_elf.c
binfmt_elf.c: In function `load_elf_interp':
binfmt_elf.c:278: `EF_MIPS_ABI2' undeclared (first use in this function)
binfmt_elf.c:278: (Each undeclared identifier is reported only once
binfmt_elf.c:278: for each function it appears in.)
binfmt_elf.c:278: `EF_MIPS_ABI' undeclared (first use in this function)
binfmt_elf.c: In function `load_elf_binary':
binfmt_elf.c:458: `EF_MIPS_ABI2' undeclared (first use in this function)
binfmt_elf.c:458: `EF_MIPS_ABI' undeclared (first use in this function)
binfmt_elf.c: In function `load_elf_library':
binfmt_elf.c:825: `EF_MIPS_ABI2' undeclared (first use in this function)
binfmt_elf.c:825: `EF_MIPS_ABI' undeclared (first use in this function)
make[2]: *** [binfmt_elf.o] Error 1
make[2]: Leaving directory `/var/src/linux-2.4.20-pre7/fs'

Kernel config:

CONFIG_MIPS=3Dy
CONFIG_MIPS32=3Dy
CONFIG_EXPERIMENTAL=3Dy
CONFIG_MODULES=3Dy
CONFIG_KMOD=3Dy
CONFIG_SGI_IP22=3Dy
CONFIG_RWSEM_GENERIC_SPINLOCK=3Dy
CONFIG_ARC32=3Dy
CONFIG_ARC_CONSOLE=3Dy
CONFIG_ARC_MEMORY=3Dy
CONFIG_BOARD_SCACHE=3Dy
CONFIG_BOOT_ELF32=3Dy
CONFIG_SWAP_IO_SPACE=3Dy
CONFIG_IRQ_CPU=3Dy
CONFIG_NONCOHERENT_IO=3Dy
CONFIG_NEW_IRQ=3Dy
CONFIG_NEW_TIME_C=3Dy
CONFIG_NONCOHERENT_IO=3Dy
CONFIG_PC_KEYB=3Dy
CONFIG_SGI=3Dy
CONFIG_CPU_R4X00=3Dy
CONFIG_CPU_HAS_LLSC=3Dy
CONFIG_CPU_HAS_LLDSCD=3Dy
CONFIG_CPU_HAS_SYNC=3Dy
CONFIG_FORWARD_KEYBOARD=3Dy
CONFIG_ARC_CONSOLE=3Dy
CONFIG_NET=3Dy
CONFIG_SYSVIPC=3Dy
CONFIG_SYSCTL=3Dy
CONFIG_KCORE_ELF=3Dy
CONFIG_BINFMT_ELF=3Dy
CONFIG_PARPORT=3Dm
CONFIG_PARPORT_PC=3Dm
CONFIG_PARPORT_PC_FIFO=3Dy
CONFIG_PARPORT_PC_SUPERIO=3Dy
CONFIG_PARPORT_1284=3Dy
CONFIG_BLK_DEV_LOOP=3Dm
CONFIG_BLK_DEV_RAM=3Dm
CONFIG_BLK_STATS=3Dy
CONFIG_PACKET=3Dm
CONFIG_PACKET_MMAP=3Dy
CONFIG_UNIX=3Dy
CONFIG_INET=3Dy
CONFIG_IP_MULTICAST=3Dy
CONFIG_SCSI=3Dy
CONFIG_BLK_DEV_SD=3Dy
CONFIG_CHR_DEV_ST=3Dm
CONFIG_CHR_DEV_OSST=3Dm
CONFIG_BLK_DEV_SR=3Dm
CONFIG_BLK_DEV_SR_VENDOR=3Dy
CONFIG_CHR_DEV_SG=3Dm
CONFIG_SCSI_MULTI_LUN=3Dy
CONFIG_SCSI_CONSTANTS=3Dy
CONFIG_SGIWD93_SCSI=3Dy
CONFIG_SCSI_PPA=3Dm
CONFIG_SCSI_IMM=3Dm
CONFIG_NETDEVICES=3Dy
CONFIG_NET_ETHERNET=3Dy
CONFIG_SGISEEQ=3Dy
CONFIG_VT=3Dy
CONFIG_VT_CONSOLE=3Dy
CONFIG_UNIX98_PTYS=3Dy
CONFIG_PRINTER=3Dm
CONFIG_MOUSE=3Dy
CONFIG_PSMOUSE=3Dy
CONFIG_WATCHDOG=3Dy
CONFIG_INDYDOG=3Dy
CONFIG_SGI_NEWPORT_CONSOLE=3Dy
CONFIG_FONT_8x16=3Dy
CONFIG_DUMMY_CONSOLE=3Dy
CONFIG_AUTOFS4_FS=3Dm
CONFIG_EXT3_FS=3Dy
CONFIG_JBD=3Dy
CONFIG_FAT_FS=3Dm
CONFIG_MSDOS_FS=3Dm
CONFIG_VFAT_FS=3Dm
CONFIG_EFS_FS=3Dm
CONFIG_TMPFS=3Dy
CONFIG_RAMFS=3Dy
CONFIG_ISO9660_FS=3Dm
CONFIG_JOLIET=3Dy
CONFIG_ZISOFS=3Dy
CONFIG_PROC_FS=3Dy
CONFIG_DEVPTS_FS=3Dy
CONFIG_EXT2_FS=3Dy
CONFIG_INTERMEZZO_FS=3Dm
CONFIG_NFS_FS=3Dm
CONFIG_NFS_V3=3Dy
CONFIG_NFSD=3Dm
CONFIG_NFSD_V3=3Dy
CONFIG_NFSD_TCP=3Dy
CONFIG_SUNRPC=3Dm
CONFIG_LOCKD=3Dm
CONFIG_LOCKD_V4=3Dy
CONFIG_SMB_FS=3Dm
CONFIG_NCP_FS=3Dm
CONFIG_NCPFS_PACKET_SIGNING=3Dy
CONFIG_NCPFS_IOCTL_LOCKING=3Dy
CONFIG_NCPFS_STRONG=3Dy
CONFIG_NCPFS_NFS_NS=3Dy
CONFIG_NCPFS_OS2_NS=3Dy
CONFIG_NCPFS_SMALLDOS=3Dy
CONFIG_NCPFS_NLS=3Dy
CONFIG_NCPFS_EXTRAS=3Dy
CONFIG_ZISOFS_FS=3Dm
CONFIG_PARTITION_ADVANCED=3Dy
CONFIG_MSDOS_PARTITION=3Dy
CONFIG_SGI_PARTITION=3Dy
CONFIG_SMB_NLS=3Dy
CONFIG_NLS=3Dy
CONFIG_NLS_CODEPAGE_437=3Dm
CONFIG_NLS_CODEPAGE_850=3Dm
CONFIG_NLS_ISO8859_1=3Dm
CONFIG_NLS_ISO8859_15=3Dm
CONFIG_NLS_UTF8=3Dm
CONFIG_SOUND=3Dm
CONFIG_SGI_SERIAL=3Dy
CONFIG_SGI_DS1286=3Dy
CONFIG_SGI_NEWPORT_GFX=3Dm
CONFIG_MAGIC_SYSRQ=3Dy
CONFIG_ZLIB_INFLATE=3Dm

gcc version 2.95.4 20011002 (Debian prerelease)

Regards,
hjb
--=20
Pro-Linux - Germany's largest volunteer Linux support site
http://www.pro-linux.de/          Public Key ID 0x3DDBDDEA

--hQiwHBbRI9kgIhsi
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment:  

iD8DBQE9gkyMLbySPj3b3eoRAnh8AJ9OOxecvBH0N3MMOHaZuYxEbcDF/ACgmaeR
kcPB9+FhW8gwKHy6I7AY04s=
=Q7nz
-----END PGP SIGNATURE-----

--hQiwHBbRI9kgIhsi--
