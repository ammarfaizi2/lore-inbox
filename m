Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292418AbSBPQpH>; Sat, 16 Feb 2002 11:45:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292428AbSBPQo5>; Sat, 16 Feb 2002 11:44:57 -0500
Received: from ulima.unil.ch ([130.223.144.143]:10112 "HELO ulima.unil.ch")
	by vger.kernel.org with SMTP id <S292418AbSBPQou>;
	Sat, 16 Feb 2002 11:44:50 -0500
Date: Sat, 16 Feb 2002 17:44:48 +0100
From: Gregoire Favre <greg@ulima.unil.ch>
To: linux-kernel@vger.kernel.org
Subject: matrox and 2.5.5-pre1 don't compile
Message-ID: <20020216164448.GB19843@ulima.unil.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

make[2]: Entering directory `/usr/src/linux-2.5/drivers/video'
make -C matrox
make[3]: Entering directory `/usr/src/linux-2.5/drivers/video/matrox'
make all_targets
make[4]: Entering directory `/usr/src/linux-2.5/drivers/video/matrox'
gcc -D__KERNEL__ -I/usr/src/linux-2.5/include -Wall -Wstrict-prototypes -Wno-trigra
phs -O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common -pipe -mpreferred-sta
ck-boundary=2 -march=i686   -DKBUILD_BASENAME=matroxfb_base  -DEXPORT_SYMTAB -c mat
roxfb_base.c
matroxfb_base.c: In function `matroxfb_ioctl':
matroxfb_base.c:1062: warning: implicit declaration of function `matroxfb_switch'
matroxfb_base.c: In function `initMatrox2':
matroxfb_base.c:1792: incompatible types in assignment
make[4]: *** [matroxfb_base.o] Error 1
make[4]: Leaving directory `/usr/src/linux-2.5/drivers/video/matrox'
make[3]: *** [first_rule] Error 2
make[3]: Leaving directory `/usr/src/linux-2.5/drivers/video/matrox'
make[2]: *** [_subdir_matrox] Error 2
make[2]: Leaving directory `/usr/src/linux-2.5/drivers/video'
make[1]: *** [_subdir_video] Error 2
make[1]: Leaving directory `/usr/src/linux-2.5/drivers'
make: *** [_dir_drivers] Error 2
363.240u 23.050s 6:48.24 94.6%  0+0k 0+0io 506239pf+0w
Exit 2

	Grégoire
________________________________________________________________
http://ulima.unil.ch/greg ICQ:16624071 mailto:greg@ulima.unil.ch
