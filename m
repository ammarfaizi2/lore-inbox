Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316906AbSFQR6p>; Mon, 17 Jun 2002 13:58:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316910AbSFQR6o>; Mon, 17 Jun 2002 13:58:44 -0400
Received: from [193.129.76.82] ([193.129.76.82]:43627 "EHLO
	ophelia.goddamn.co.uk") by vger.kernel.org with ESMTP
	id <S316906AbSFQR6m>; Mon, 17 Jun 2002 13:58:42 -0400
Date: Mon, 17 Jun 2002 19:00:26 +0100
From: Toby Inkster <tobyink@goddamn.co.uk>
To: linux-kernel@vger.kernel.org
Subject: .i2c-old.ver.d: No such file or directory
Message-Id: <20020617190026.0c0f60b2.tobyink@goddamn.co.uk>
Organization: goddamn.co.uk
X-Mailer: Sylpheed version 0.7.6claws48 (GTK+ 1.2.10; i686-pc-linux-gnu)
X-Accept-Language: en-GB en-US de
X-Disclaimer-1: The opinions in this email are not mine, nor those of my employers. I
X-Disclaimer-2: stole them from the guy sitting next to me. If you don't like them, I
X-Disclaimer-3: can ask him for his address and you can track him down and kill him.
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 boundary="=.J:wg'SE)fImL2t"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--=.J:wg'SE)fImL2t
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

I'm experiencing an odd problem during "make dep". This is with 2.5.22, although it happened with 2.5.21 too.

Below are the last few lines of output before the errors start. I can send my .config if anyone thinks it might help.

  	mkdir -p /usr/src/linux-2.5.22/include/linux/modules/drivers/media/video/; gcc -E -Wp,-MD,/usr/src/linux-2.5.22/include/linux/modules/drivers/media/video/.video-buf.ver.d -D__KERNEL__ -I/usr/src/linux-2.5.22/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2 -march=i686 -nostdinc -iwithprefix include    -DKBUILD_BASENAME=video_buf   video-buf.c | /sbin/genksyms  -k 2.5.22 > /usr/src/linux-2.5.22/include/linux/modules/drivers/media/video/video-buf.ver.tmp; if [ ! -r /usr/src/linux-2.5.22/include/linux/modules/drivers/media/video/video-buf.ver ] || cmp -s /usr/src/linux-2.5.22/include/linux/modules/drivers/media/video/video-buf.ver /usr/src/linux-2.5.22/include/linux/modules/drivers/media/video/video-buf.ver.tmp; then touch /usr/src/linux-2.5.22/include/linux/modversions.h; fi; mv -f /usr/src/linux-2.5.22/include/linux/modules/drivers/media/video/video-buf.ver.tmp /usr/src/linux-2.5.22
 /include/linux/modules/drivers/media/video/video-buf.ver
  	mkdir -p /usr/src/linux-2.5.22/include/linux/modules/drivers/media/video/; gcc -E -Wp,-MD,/usr/src/linux-2.5.22/include/linux/modules/drivers/media/video/.i2c-old.ver.d -D__KERNEL__ -I/usr/src/linux-2.5.22/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2 -march=i686 -nostdinc -iwithprefix include    -DKBUILD_BASENAME=i2c_old   i2c-old.c | /sbin/genksyms  -k 2.5.22 > /usr/src/linux-2.5.22/include/linux/modules/drivers/media/video/i2c-old.ver.tmp; if [ ! -r /usr/src/linux-2.5.22/include/linux/modules/drivers/media/video/i2c-old.ver ] || cmp -s /usr/src/linux-2.5.22/include/linux/modules/drivers/media/video/i2c-old.ver /usr/src/linux-2.5.22/include/linux/modules/drivers/media/video/i2c-old.ver.tmp; then touch /usr/src/linux-2.5.22/include/linux/modversions.h; fi; mv -f /usr/src/linux-2.5.22/include/linux/modules/drivers/media/video/i2c-old.ver.tmp /usr/src/linux-2.5.22/include/linux/m
 odules/drivers/media/video/i2c-old.ver
i2c-old.c:17:27: linux/i2c-old.h: No such file or directory
/usr/src/linux-2.5.22/include/linux/modules/drivers/media/video/.i2c-old.ver.d: No such file or directory
make[5]: *** [/usr/src/linux-2.5.22/include/linux/modules/drivers/media/video/i2c-old.ver] Error 2
make[5]: Leaving directory `/usr/src/linux-2.5.22/drivers/media/video'
make[4]: *** [video] Error 2
make[4]: Leaving directory `/usr/src/linux-2.5.22/drivers/media'
make[3]: *** [media] Error 2
make[3]: Leaving directory `/usr/src/linux-2.5.22/drivers'
make[2]: *** [_sfdep_drivers] Error 2
make[2]: Leaving directory `/usr/src/linux-2.5.22'
make[1]: *** [include/linux/modversions.h] Error 2
make[1]: Leaving directory `/usr/src/linux-2.5.22'
make: *** [.hdepend] Error 2
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.7 (GNU/Linux)

iD4DBQE9DgLKzr+BKGoqfTkRAjiqAKCpyQyzfVoyHCCKUoS/V0cFgq5/2wCXezNg
cCU6GUFP0bJX8CRV3/Slxg==
=ZJCY
-----END PGP SIGNATURE-----

-- 
T. Inkster {e-mail tobyink<at>goddamn.co.uk}{web goddamn.co.uk/tobyink/}
{please encrypt private e-mails goddamn.co.uk/tobyink/personal/pgp.html}
{jabber tobyink<at>amessage.de}{icq #6622880}{aim inka80}{yahoo tobyink}

Yow!  It's a hole all the way to downtown Burbank!

--=.J:wg'SE)fImL2t
Content-Type: application/pgp-signature
Content-Disposition: attachment; filename=signature.txt;
Content-Description: For security, this message has been digitally signed.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.7 (GNU/Linux)

iD8DBQE9DiO6zr+BKGoqfTkRArvqAJ9jPCMwGr0tiFcqPIDtdDXgWm3dagCfbLO4
L5XgDqm4ij5jHrMb+UsVb08=
=rd15
-----END PGP SIGNATURE-----

--=.J:wg'SE)fImL2t--

