Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261391AbSJMA1N>; Sat, 12 Oct 2002 20:27:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261395AbSJMA1N>; Sat, 12 Oct 2002 20:27:13 -0400
Received: from marstons.services.quay.plus.net ([212.159.14.223]:971 "HELO
	marstons.services.quay.plus.net") by vger.kernel.org with SMTP
	id <S261391AbSJMA1N>; Sat, 12 Oct 2002 20:27:13 -0400
Date: Sun, 13 Oct 2002 01:28:06 +0100
From: Stig Brautaset <stig@brautaset.org>
To: linux-kernel@vger.kernel.org
Subject: 2.5.42: xircom_tulip_cb driver compile warnings
Message-ID: <20021013002806.GA817@arwen.brautaset.org>
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

I get these warnings when compiling the xircom_tulip_cb driver:

  gcc -Wp,-MD,drivers/net/tulip/.xircom_tulip_cb.o.d -D__KERNEL__ -Iinclude -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2 -march=i686 -Iarch/i386/mach-generic -nostdinc -iwithprefix include -DMODULE   -DKBUILD_BASENAME=xircom_tulip_cb   -c -o drivers/net/tulip/xircom_tulip_cb.o drivers/net/tulip/xircom_tulip_cb.c
drivers/net/tulip/xircom_tulip_cb.c: In function `xircom_up':
drivers/net/tulip/xircom_tulip_cb.c:791: warning: unsigned int format, long unsigned int arg (arg 3)
drivers/net/tulip/xircom_tulip_cb.c:791: warning: unsigned int format, long unsigned int arg (arg 4)
drivers/net/tulip/xircom_tulip_cb.c:791: warning: unsigned int format, long unsigned int arg (arg 5)
drivers/net/tulip/xircom_tulip_cb.c: In function `xircom_interrupt':
drivers/net/tulip/xircom_tulip_cb.c:1073: warning: unsigned int format, long unsigned int arg (arg 4)
drivers/net/tulip/xircom_tulip_cb.c:1146: warning: unsigned int format, long unsigned int arg (arg 4)
drivers/net/tulip/xircom_tulip_cb.c:1185: warning: unsigned int format, long unsigned int arg (arg 3)
drivers/net/tulip/xircom_tulip_cb.c: In function `xircom_close':
drivers/net/tulip/xircom_tulip_cb.c:1317: warning: unsigned int format, long unsigned int arg (arg 3)


Stig
-- 
brautaset.org
