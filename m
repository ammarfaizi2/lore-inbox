Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264999AbTFLVDa (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jun 2003 17:03:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265000AbTFLVDa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jun 2003 17:03:30 -0400
Received: from scrye.com ([216.17.180.1]:10221 "HELO scrye.com")
	by vger.kernel.org with SMTP id S264999AbTFLVDZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jun 2003 17:03:25 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Date: Thu, 12 Jun 2003 15:17:02 -0600
From: Kevin Fenzi <kevin@scrye.com>
To: linux-kernel@vger.kernel.org
X-Mailer: VM 7.07 under 21.4 (patch 12) "Portable Code" XEmacs Lucid
Subject: Re: 2.4.21-rc8-laptop1 released
References: <20030612223940.7fcc00a1.hanno@gmx.de>
Message-Id: <20030612211707.2266BF7FE0@voldemort.scrye.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1


Hanno> The second release of laptopkernel is out.  Get it at
Hanno> https://savannah.nongnu.org/projects/laptopkernel/
Hanno> 2.4.21-rc8-laptop1

Humm... doesn't seem to compile here...

am I missing something?

make[5]: Entering directory `/usr/src/redhat/BUILD/kernel-2.4.21rc8laptop1/drivers/char/agp'
gcc -D__KERNEL__ -I/usr/src/redhat/BUILD/kernel-2.4.21rc8laptop1/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -fomit-frame-pointer -pipe -mpreferred-stack-boundary=2 -march=pentium4 -g  -nostdinc -iwithprefix include -DKBUILD_BASENAME=agpgart_fe  -c -o agpgart_fe.o agpgart_fe.c
gcc -D__KERNEL__ -I/usr/src/redhat/BUILD/kernel-2.4.21rc8laptop1/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -fomit-frame-pointer -pipe -mpreferred-stack-boundary=2 -march=pentium4 -g  -nostdinc -iwithprefix include -DKBUILD_BASENAME=agpgart_be  -DEXPORT_SYMTAB -c agpgart_be.c
agpgart_be.c:5108: `PCI_DEVICE_ID_VIA_8375' undeclared here (not in a function)
agpgart_be.c:5108: initializer element is not constant
agpgart_be.c:5108: (near initialization for `agp_bridge_info[55].device_id')
agpgart_be.c:5113: initializer element is not constant
agpgart_be.c:5113: (near initialization for `agp_bridge_info[55]')
agpgart_be.c:5119: initializer element is not constant
agpgart_be.c:5119: (near initialization for `agp_bridge_info[56]')
agpgart_be.c:5125: initializer element is not constant
agpgart_be.c:5125: (near initialization for `agp_bridge_info[57]')
agpgart_be.c:5126: `PCI_DEVICE_ID_VIA_P4M266' undeclared here (not in a function)
agpgart_be.c:5126: initializer element is not constant
agpgart_be.c:5126: (near initialization for `agp_bridge_info[58].device_id')
agpgart_be.c:5131: initializer element is not constant
agpgart_be.c:5131: (near initialization for `agp_bridge_info[58]')
agpgart_be.c:5137: initializer element is not constant
agpgart_be.c:5137: (near initialization for `agp_bridge_info[59]')
agpgart_be.c:5170: initializer element is not constant
agpgart_be.c:5170: (near initialization for `agp_bridge_info[60]')
make[5]: *** [agpgart_be.o] Error 1
make[5]: Leaving directory `/usr/src/redhat/BUILD/kernel-2.4.21rc8laptop1/drivers/char/agp'
make[4]: *** [first_rule] Error 2
make[4]: Leaving directory `/usr/src/redhat/BUILD/kernel-2.4.21rc8laptop1/drivers/char/agp'
make[3]: *** [_subdir_agp] Error 2
make[3]: Leaving directory `/usr/src/redhat/BUILD/kernel-2.4.21rc8laptop1/drivers/char'
make[2]: *** [_subdir_char] Error 2
make[2]: Leaving directory `/usr/src/redhat/BUILD/kernel-2.4.21rc8laptop1/drivers'
make[1]: *** [_dir_drivers] Error 2
make[1]: Leaving directory `/usr/src/redhat/BUILD/kernel-2.4.21rc8laptop1'
error: Bad exit status from /var/tmp/rpm-tmp.44930 (%build)

kevin
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)
Comment: Processed by Mailcrypt 3.5.8 <http://mailcrypt.sourceforge.net/>

iD8DBQE+6O3S3imCezTjY0ERAnOAAJ90W5wzb1ihU3ZUL1Cmgrb/m8sX8QCcDgOT
3Dl21YiuuOeFKI5gdsEIdgc=
=KLrM
-----END PGP SIGNATURE-----
