Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262870AbSJLKiG>; Sat, 12 Oct 2002 06:38:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262875AbSJLKiG>; Sat, 12 Oct 2002 06:38:06 -0400
Received: from murphys.services.quay.plus.net ([212.159.14.225]:19880 "HELO
	murphys.services.quay.plus.net") by vger.kernel.org with SMTP
	id <S262870AbSJLKiG>; Sat, 12 Oct 2002 06:38:06 -0400
Date: Sat, 12 Oct 2002 11:39:01 +0100
From: Stig Brautaset <stig@brautaset.org>
To: linux-kernel@vger.kernel.org
Subject: 2.5.42: unresolved symbols ext2
Message-ID: <20021012103901.GA18408@arwen.brautaset.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-Location: London, UK
X-URL: http://brautaset.org
X-KeyServer: wwwkeys.nl.pgp.net
X-PGP/GnuPG-Key: 9336ADC1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

/usr/bin/make -f arch/i386/lib/Makefile modules_install
if [ -r System.map ]; then /sbin/depmod -ae -F System.map -b /usr/src/linux/debian/tmp-image -r 2.5.42; fi
depmod: *** Unresolved symbols in /usr/src/linux/debian/tmp-image/lib/modules/2.5.42/kernel/fs/ext2/ext2.o
depmod:         generic_file_aio_read
depmod:         generic_file_aio_write
make[2]: *** [_modinst_post] Error 1
make[2]: Leaving directory `/usr/src/linux-2.5.x'
make[1]: *** [real_stamp_image] Error 2
make[1]: Leaving directory `/usr/src/linux-2.5.x'


Stig
-- 
brautaset.org
