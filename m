Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262933AbSJTPiY>; Sun, 20 Oct 2002 11:38:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262937AbSJTPiY>; Sun, 20 Oct 2002 11:38:24 -0400
Received: from ulima.unil.ch ([130.223.144.143]:17536 "HELO ulima.unil.ch")
	by vger.kernel.org with SMTP id <S262933AbSJTPiU>;
	Sun, 20 Oct 2002 11:38:20 -0400
Date: Sun, 20 Oct 2002 17:44:25 +0200
From: Gregoire Favre <greg@ulima.unil.ch>
To: linux-kernel@vger.kernel.org
Subject: 2.5.44 ISDN don't compil
Message-ID: <20021020154425.GB14338@ulima.unil.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I got this:

  gcc -Wp,-MD,drivers/isdn/i4l/.isdn_ppp.o.d -D__KERNEL__ -Iinclude -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2 -march=i686 -Iarch/i386/mach-generic -nostdinc -iwithprefix include    -DKBUILD_BASENAME=isdn_ppp   -c -o drivers/isdn/i4l/isdn_ppp.o drivers/isdn/i4l/isdn_ppp.c
drivers/isdn/i4l/isdn_ppp.c: In function `ipppd_ioctl':
drivers/isdn/i4l/isdn_ppp.c:361: warning: int format, long unsigned int arg (arg 4)
drivers/isdn/i4l/isdn_ppp.c:362: warning: implicit declaration of function `isdn_ppp_bundle'
drivers/isdn/i4l/isdn_ppp.c: At top level:
drivers/isdn/i4l/isdn_ppp.c:597: warning: `isdn_ppp_bundle' was declared implicitly `extern' and later `static'
drivers/isdn/i4l/isdn_ppp.c:362: warning: previous declaration of `isdn_ppp_bundle'
drivers/isdn/i4l/isdn_ppp.c: In function `isdn_ppp_bind':
drivers/isdn/i4l/isdn_ppp.c:766: `lp' undeclared (first use in this function)
drivers/isdn/i4l/isdn_ppp.c:766: (Each undeclared identifier is reported only once
drivers/isdn/i4l/isdn_ppp.c:766: for each function it appears in.)
drivers/isdn/i4l/isdn_ppp.c: In function `isdn_ppp_disconnected':
drivers/isdn/i4l/isdn_ppp.c:818: `lp' undeclared (first use in this function)
drivers/isdn/i4l/isdn_ppp.c: In function `isdn_ppp_receive':
drivers/isdn/i4l/isdn_ppp.c:941: structure has no member named `compflags'
drivers/isdn/i4l/isdn_ppp.c:941: `SC_LINK_DECOMP_ON' undeclared (first use in this function)
drivers/isdn/i4l/isdn_ppp.c:942: warning: implicit declaration of function `isdn_ppp_decompress'
drivers/isdn/i4l/isdn_ppp.c:942: warning: assignment makes pointer from integer without a cast
drivers/isdn/i4l/isdn_ppp.c:947: structure has no member named `mpppcfg'
drivers/isdn/i4l/isdn_ppp.c: In function `isdn_ppp_start_xmit':
drivers/isdn/i4l/isdn_ppp.c:1184: `ipt' undeclared (first use in this function)
drivers/isdn/i4l/isdn_ppp.c:1186: `ipts' undeclared (first use in this function)
drivers/isdn/i4l/isdn_ppp.c:1189: warning: implicit declaration of function `isdn_ppp_skb_push'
drivers/isdn/i4l/isdn_ppp.c:1189: warning: initialization makes pointer from integer without a cast
drivers/isdn/i4l/isdn_ppp.c:1197: warning: initialization makes pointer from integer without a cast
drivers/isdn/i4l/isdn_ppp.c:1191: label `unlock' used but not defined
drivers/isdn/i4l/isdn_ppp.c: In function `isdn_ppp_mp_init':
drivers/isdn/i4l/isdn_ppp.c:1284: structure has no member named `netdev'
drivers/isdn/i4l/isdn_ppp.c:1287: structure has no member named `ppp_slot'
drivers/isdn/i4l/isdn_ppp.c:1289: structure has no member named `ppp_slot'
drivers/isdn/i4l/isdn_ppp.c:1293: `ippp_table' undeclared (first use in this function)
drivers/isdn/i4l/isdn_ppp.c:1293: structure has no member named `ppp_slot'
drivers/isdn/i4l/isdn_ppp.c:1295: structure has no member named `netdev'
drivers/isdn/i4l/isdn_ppp.c:1296: structure has no member named `netdev'
drivers/isdn/i4l/isdn_ppp.c:1297: structure has no member named `netdev'
drivers/isdn/i4l/isdn_ppp.c:1299: structure has no member named `mp_seqno'
drivers/isdn/i4l/isdn_ppp.c:1300: structure has no member named `netdev'
drivers/isdn/i4l/isdn_ppp.c:1303: structure has no member named `netdev'
drivers/isdn/i4l/isdn_ppp.c:1304: structure has no member named `netdev'
drivers/isdn/i4l/isdn_ppp.c:1305: structure has no member named `netdev'
drivers/isdn/i4l/isdn_ppp.c:1307: structure has no member named `netdev'
drivers/isdn/i4l/isdn_ppp.c:1309: structure has no member named `pppseq'
drivers/isdn/i4l/isdn_ppp.c: In function `isdn_ppp_mp_receive':
drivers/isdn/i4l/isdn_ppp.c:1325: structure has no member named `netdev'
drivers/isdn/i4l/isdn_ppp.c:1335: structure has no member named `netdev'
drivers/isdn/i4l/isdn_ppp.c:1336: structure has no member named `netdev'
drivers/isdn/i4l/isdn_ppp.c:1338: structure has no member named `ppp_slot'
drivers/isdn/i4l/isdn_ppp.c:1347: `ippp_table' undeclared (first use in this function)
drivers/isdn/i4l/isdn_ppp.c:1354: structure has no member named `mpppcfg'
drivers/isdn/i4l/isdn_ppp.c:1355: structure has no member named `pppseq'
drivers/isdn/i4l/isdn_ppp.c:1373: structure has no member named `pppseq'
drivers/isdn/i4l/isdn_ppp.c:1375: structure has no member named `ppp_slot'
drivers/isdn/i4l/isdn_ppp.c:1472: structure has no member named `netdev'
drivers/isdn/i4l/isdn_ppp.c: In function `isdn_ppp_mp_cleanup':
drivers/isdn/i4l/isdn_ppp.c:1544: structure has no member named `netdev'
drivers/isdn/i4l/isdn_ppp.c:1548: structure has no member named `netdev'
drivers/isdn/i4l/isdn_ppp.c:1551: structure has no member named `netdev'
drivers/isdn/i4l/isdn_ppp.c: In function `isdn_ppp_mp_reassembly':
drivers/isdn/i4l/isdn_ppp.c:1603: structure has no member named `netdev'
drivers/isdn/i4l/isdn_ppp.c:1609: structure has no member named `ppp_slot'
drivers/isdn/i4l/isdn_ppp.c:1609: structure has no member named `ppp_slot'
drivers/isdn/i4l/isdn_ppp.c:1611: structure has no member named `ppp_slot'
drivers/isdn/i4l/isdn_ppp.c:1615: `ippp_table' undeclared (first use in this function)
drivers/isdn/i4l/isdn_ppp.c:1615: structure has no member named `ppp_slot'
drivers/isdn/i4l/isdn_ppp.c:1628: structure has no member named `ppp_slot'
drivers/isdn/i4l/isdn_ppp.c: At top level:
drivers/isdn/i4l/isdn_ppp.c:1668: warning: `isdn_ppp_bundle' was declared implicitly `extern' and later `static'
drivers/isdn/i4l/isdn_ppp.c:362: warning: previous declaration of `isdn_ppp_bundle'
drivers/isdn/i4l/isdn_ppp.c: In function `isdn_ppp_bundle':
drivers/isdn/i4l/isdn_ppp.c:1676: warning: implicit declaration of function `isdn_net_findif'
drivers/isdn/i4l/isdn_ppp.c:1676: warning: assignment makes pointer from integer without a cast
drivers/isdn/i4l/isdn_ppp.c:1686: structure has no member named `ppp_slot'
drivers/isdn/i4l/isdn_ppp.c:1686: structure has no member named `ppp_slot'
drivers/isdn/i4l/isdn_ppp.c:1687: structure has no member named `ppp_slot'
drivers/isdn/i4l/isdn_ppp.c:1687: structure has no member named `ppp_slot'
drivers/isdn/i4l/isdn_ppp.c:1689: structure has no member named `ppp_slot'
drivers/isdn/i4l/isdn_ppp.c:1689: structure has no member named `ppp_slot'
drivers/isdn/i4l/isdn_ppp.c:1690: structure has no member named `ppp_slot'
drivers/isdn/i4l/isdn_ppp.c:1690: structure has no member named `ppp_slot'
drivers/isdn/i4l/isdn_ppp.c:1695: warning: implicit declaration of function `isdn_net_add_to_bundle'
drivers/isdn/i4l/isdn_ppp.c:1697: `ippp_table' undeclared (first use in this function)
drivers/isdn/i4l/isdn_ppp.c:1697: structure has no member named `ppp_slot'
drivers/isdn/i4l/isdn_ppp.c:1697: structure has no member named `ppp_slot'
drivers/isdn/i4l/isdn_ppp.c:1700: structure has no member named `ppp_slot'
drivers/isdn/i4l/isdn_ppp.c:1700: structure has no member named `ppp_slot'
drivers/isdn/i4l/isdn_ppp.c:1702: structure has no member named `ppp_slot'
drivers/isdn/i4l/isdn_ppp.c:1702: structure has no member named `ppp_slot'
drivers/isdn/i4l/isdn_ppp.c: In function `isdn_ppp_dial_slave':
drivers/isdn/i4l/isdn_ppp.c:1821: warning: assignment makes pointer from integer without a cast
drivers/isdn/i4l/isdn_ppp.c:1825: warning: implicit declaration of function `isdn_net_bound'
drivers/isdn/i4l/isdn_ppp.c:1828: structure has no member named `slave'
drivers/isdn/i4l/isdn_ppp.c:1832: structure has no member named `slave'
drivers/isdn/i4l/isdn_ppp.c: In function `isdn_ppp_hangup_slave':
drivers/isdn/i4l/isdn_ppp.c:1850: warning: assignment makes pointer from integer without a cast
drivers/isdn/i4l/isdn_ppp.c:1857: structure has no member named `slave'
make[3]: *** [drivers/isdn/i4l/isdn_ppp.o] Error 1
make[2]: *** [drivers/isdn/i4l] Error 2
make[1]: *** [drivers/isdn] Error 2
make: *** [drivers] Error 2
20.157u 1.578s 0:30.52 71.1%	0+0k 0+0io 86179pf+0w
Exit 2

I know it's written obsolete, but it doesn't seems to possible to use my
AVM A1 card with the new driver, or???

Thank you very much,

	Grégoire
________________________________________________________________
http://ulima.unil.ch/greg ICQ:16624071 mailto:greg@ulima.unil.ch
