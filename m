Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274666AbRJAHKz>; Mon, 1 Oct 2001 03:10:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274667AbRJAHKq>; Mon, 1 Oct 2001 03:10:46 -0400
Received: from front2.mail.megapathdsl.net ([66.80.60.30]:60936 "EHLO
	front2.mail.megapathdsl.net") by vger.kernel.org with ESMTP
	id <S274666AbRJAHKc>; Mon, 1 Oct 2001 03:10:32 -0400
Subject: Re: 2.4.11-pre1 -- Unresolved symbols in media/radio/miropcm20.o --
	aci_port, aci_version and aci_rw_cmd
From: Miles Lane <miles@megapathdsl.net>
To: LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <1001919223.1247.13.camel@stomata.megapathdsl.net>
In-Reply-To: <1001919223.1247.13.camel@stomata.megapathdsl.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.14.99 (Preview Release)
Date: 01 Oct 2001 00:02:55 -0700
Message-Id: <1001919795.1247.20.camel@stomata.megapathdsl.net>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I don't actually have this device, but am testing compile options.

/sbin/depmod -ae -F System.map  2.4.11-pre1
depmod: *** Unresolved symbols in /lib/modules/2.4.11-pre1/kernel/drivers/media/radio/miropcm20.o
depmod: 	aci_port
depmod: 	aci_version
depmod: 	aci_rw_cmd

My .config file includes:

#
# Amateur Radio support
#
CONFIG_HAMRADIO=y
CONFIG_AX25=m
CONFIG_AX25_DAMA_SLAVE=y
CONFIG_NETROM=m
CONFIG_ROSE=m

ver_linux gives:

Linux stomata.megapathdsl.net 2.4.11-pre1 #1 Sun Sep 30 22:03:05 PDT 2001 i686 unknown
 
Gnu C                  2.96
Gnu make               3.79.1
binutils               2.10.91.0.2
util-linux             2.10s
mount                  2.11b
modutils               2.4.9
e2fsprogs              1.25
reiserfsprogs          3.x.0f
pcmcia-cs              3.1.22
PPP                    2.4.0
isdn4k-utils           3.1pre1
Linux C Library        2.2.2
Dynamic linker (ldd)   2.2.2
Procps                 2.0.7
Net-tools              1.57
Console-tools          0.3.3
Sh-utils               2.0
Modules Loaded         emu10k1 sound ac97_codec soundcore serial_cs af_packet 3c59x keybdev hid input usb-ohci nls_iso8859-1 nls_cp850


