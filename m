Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282918AbRLWDWh>; Sat, 22 Dec 2001 22:22:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283438AbRLWDW1>; Sat, 22 Dec 2001 22:22:27 -0500
Received: from CPE0002b3140673.cpe.net.cable.rogers.com ([24.156.0.228]:16588
	"EHLO pyre.virge.net") by vger.kernel.org with ESMTP
	id <S283288AbRLWDWU>; Sat, 22 Dec 2001 22:22:20 -0500
Date: Sat, 22 Dec 2001 22:22:13 -0500
To: linux-kernel@vger.kernel.org
Subject: [2.4.17] net/network.o(.text.lock+0x1a88): undefined reference to `local symbols...
Message-ID: <20011223032213.GA20031@pyre.virge.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="qDbXVdCdHGoSgWSk"
Content-Disposition: inline
User-Agent: Mutt/1.3.24i
From: nveber@pyre.virge.net (Norbert Veber)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--qDbXVdCdHGoSgWSk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

I read though the archives, and saw another problem with network.o and
gcc 3.x, however I didnt see anything about this yet.

I'm using gcc 2.95.4 and binutils 2.11.92.0.12.3, both from
debian/unstable.

Let me know if you need any more information.

make[1]: Leaving directory `/usr/src/linux/arch/i386/lib'
ld -m elf_i386 -T /usr/src/linux/arch/i386/vmlinux.lds -e stext arch/i386/kernel/head.o arch/i386/kernel/init_task.o init/main.o init/version.o \
        --start-group \
        arch/i386/kernel/kernel.o arch/i386/mm/mm.o kernel/kernel.o mm/mm.o fs/fs.o ipc/ipc.o \
         drivers/acpi/acpi.o drivers/char/char.o drivers/block/block.o drivers/misc/misc.o drivers/net/net.o drivers/media/media.o drivers/char/agp/agp.o drivers/char/drm/drm.o drivers/ide/idedriver.o drivers/cdrom/driver.o drivers/pci/driver.o drivers/pnp/pnp.o drivers/video/video.o \
        net/network.o \
        /usr/src/linux/arch/i386/lib/lib.a /usr/src/linux/lib/lib.a /usr/src/linux/arch/i386/lib/lib.a \
        --end-group \
        -o vmlinux
net/network.o(.text.lock+0x1a88): undefined reference to `local symbols in discarded section .text.exit'
make: *** [vmlinux] Error 1

PS. Please CC me any replies.

Thanks,

Norbert

--qDbXVdCdHGoSgWSk
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE8JU3kohfEw14utbQRAnuFAKC5OXYTM9Ab/xusVP/W7r2uL4KRlACfSfd1
No11sDzn8OtyCvKoNCyuhko=
=FZPx
-----END PGP SIGNATURE-----

--qDbXVdCdHGoSgWSk--
