Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284140AbRL1ULA>; Fri, 28 Dec 2001 15:11:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286995AbRL1UKk>; Fri, 28 Dec 2001 15:10:40 -0500
Received: from front2.mail.megapathdsl.net ([66.80.60.30]:19973 "EHLO
	front2.mail.megapathdsl.net") by vger.kernel.org with ESMTP
	id <S284140AbRL1UKc>; Fri, 28 Dec 2001 15:10:32 -0500
Subject: 2.5.1-dj7 -- Compile errors in ieee1394/sbp2.c
From: Miles Lane <miles@megapathdsl.net>
To: Dave Jones <davej@suse.de>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20011228173428.A25102@suse.de>
In-Reply-To: <20011228173428.A25102@suse.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.1.99+cvs.2001.12.21.18.01 (Preview Release)
Date: 28 Dec 2001 12:11:45 -0800
Message-Id: <1009570306.1816.81.camel@stomata.megapathdsl.net>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

gcc -D__KERNEL__ -I/usr/src/linux/include -Wall -Wstrict-prototypes
-Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common
-pipe -mpreferred-stack-boundary=2 -march=athlon  -DMODULE   -c -o
sbp2.o sbp2.c
sbp2.c: In function `sbp2_module_init':
sbp2.c:2948: warning: implicit declaration of function
`scsi_register_module'
sbp2.c:2948: `MODULE_SCSI_HA' undeclared (first use in this function)
sbp2.c:2948: (Each undeclared identifier is reported only once
sbp2.c:2948: for each function it appears in.)
sbp2.c: In function `sbp2_module_exit':
sbp2.c:2971: warning: implicit declaration of function
`scsi_unregister_module'
sbp2.c:2971: `MODULE_SCSI_HA' undeclared (first use in this function)
make[2]: *** [sbp2.o] Error 1
make[2]: Leaving directory `/usr/src/linux/drivers/ieee1394'

#
# IEEE 1394 (FireWire) support (EXPERIMENTAL)
#
CONFIG_IEEE1394=m
CONFIG_IEEE1394_PCILYNX=m
CONFIG_IEEE1394_PCILYNX_LOCALRAM=y
CONFIG_IEEE1394_PCILYNX_PORTS=y
CONFIG_IEEE1394_OHCI1394=m
CONFIG_IEEE1394_VIDEO1394=m
CONFIG_IEEE1394_SBP2=m
CONFIG_IEEE1394_RAWIO=m
CONFIG_IEEE1394_VERBOSEDEBUG=y


