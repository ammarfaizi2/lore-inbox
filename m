Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267086AbSLKJ3z>; Wed, 11 Dec 2002 04:29:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267094AbSLKJ3z>; Wed, 11 Dec 2002 04:29:55 -0500
Received: from CPE-203-51-35-111.nsw.bigpond.net.au ([203.51.35.111]:62446
	"EHLO e4.eyal.emu.id.au") by vger.kernel.org with ESMTP
	id <S267086AbSLKJ3y>; Wed, 11 Dec 2002 04:29:54 -0500
Message-ID: <3DF7075E.CB1C7201@eyal.emu.id.au>
Date: Wed, 11 Dec 2002 20:37:34 +1100
From: Eyal Lebedinsky <eyal@eyal.emu.id.au>
Organization: Eyal at Home
X-Mailer: Mozilla 4.8 [en] (X11; U; Linux 2.4.20-ac1 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Marcelo Tosatti <marcelo@conectiva.com.br>
CC: lkml <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4.21-pre1 compile failure: drivers/net/pcmcia/fmvj18x_cs.c
References: <Pine.LNX.4.50L.0212101834240.23096-100000@freak.distro.conectiva>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

gcc -D__KERNEL__ -I/data2/usr/local/src/linux-2.4-pre/include -Wall
-Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common
-fomit-frame-pointer -pipe -mpreferred-stack-boundary=2 -march=i686
-malign-functions=4  -DMODULE -DMODVERSIONS -include
/data2/usr/local/src/linux-2.4-pre/include/linux/modversions.h 
-nostdinc -iwithprefix include -DKBUILD_BASENAME=fmvj18x_cs  -c -o
fmvj18x_cs.o fmvj18x_cs.c
fmvj18x_cs.c: In function `fmvj18x_config':
fmvj18x_cs.c:489: `PRODID_TDK_GN3410' undeclared (first use in this
function)
fmvj18x_cs.c:489: (Each undeclared identifier is reported only once
fmvj18x_cs.c:489: for each function it appears in.)
fmvj18x_cs.c:529: `MANFID_UNGERMANN' undeclared (first use in this
function)
make[3]: *** [fmvj18x_cs.o] Error 1
make[3]: Leaving directory
`/data2/usr/local/src/linux-2.4-pre/drivers/net/pcmcia'

#
# PCMCIA network device support
#
CONFIG_NET_PCMCIA=y
CONFIG_PCMCIA_3C589=m
CONFIG_PCMCIA_3C574=m
CONFIG_PCMCIA_FMVJ18X=m
CONFIG_PCMCIA_PCNET=m
CONFIG_PCMCIA_AXNET=m
CONFIG_PCMCIA_NMCLAN=m
CONFIG_PCMCIA_SMC91C92=m
CONFIG_PCMCIA_XIRC2PS=m
CONFIG_ARCNET_COM20020_CS=m
CONFIG_PCMCIA_IBMTR=m
CONFIG_PCMCIA_XIRCOM=m
CONFIG_PCMCIA_XIRTULIP=m
CONFIG_NET_PCMCIA_RADIO=y
CONFIG_PCMCIA_RAYCS=m
CONFIG_PCMCIA_NETWAVE=m
CONFIG_PCMCIA_WAVELAN=m
CONFIG_AIRONET4500_CS=m

--
Eyal Lebedinsky (eyal@eyal.emu.id.au) <http://samba.org/eyal/>
