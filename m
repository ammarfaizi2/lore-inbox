Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271079AbRHOHis>; Wed, 15 Aug 2001 03:38:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271078AbRHOHii>; Wed, 15 Aug 2001 03:38:38 -0400
Received: from pD9E0E4A2.dip.t-dialin.net ([217.224.228.162]:28016 "EHLO
	mousehomenet.homenet") by vger.kernel.org with ESMTP
	id <S271079AbRHOHiW>; Wed, 15 Aug 2001 03:38:22 -0400
Message-ID: <3B7A26F3.8070501@rz.uni-potsdam.de>
Date: Wed, 15 Aug 2001 09:38:27 +0200
From: Juergen Rose <rose@rz.uni-potsdam.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.2+) Gecko/20010728
X-Accept-Language: en-us
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: emu10k1-devel@opensource.creative.com
Subject: Can't make module emu10k1.o with linux-2.4.8
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,ld -m elf_i386  -r -o emu10k1.o audio.o cardmi.o cardmo.o cardwi.o 
cardwo.o ecard.o efxmgr.o emuadxmg.o hwaccess.o irqmgr.o joystick.o 
main.o midi.o mixer.o passthrough.o recmgr.o timer.o voicemgr.o
main.o(.modinfo+0x40): multiple definition of `__module_author'
joystick.o(.modinfo+0x80): first defined here
ld: Warning: size of symbol `__module_author' changed from 67 to 81 in 
main.o
main.o(.modinfo+0xa0): multiple definition of `__module_description'
joystick.o(.modinfo+0xe0): first defined here
ld: Warning: size of symbol `__module_description' changed from 83 to 96 
in main.o
main.o: In function `init_module':
main.o(.text+0x18d0): multiple definition of `init_module'
joystick.o(.text+0x240): first defined here
main.o: In function `cleanup_module':
main.o(.text+0x1910): multiple definition of `cleanup_module'
joystick.o(.text+0x280): first defined here
make[3]: *** [emu10k1.o] Error 1



I have the following tools installed:

Linux mousehomenet 2.4.3 #1 Sun Apr 1 23:25:51 CEST 2001 i686 unknown
 
Gnu C                  2.95.3
Gnu make               3.79
binutils               2.11
util-linux             2.11b
mount                  2.11b
modutils               2.4.5
e2fsprogs              1.20-WIP
PPP                    2.4.0
Linux C Library        2.2.2
Dynamic linker (ldd)   2.2.2
Procps                 2.0.6
Net-tools              1.55
Kbd                    0.99
Sh-utils               1.16
Modules Loaded         ipv6 nfs lockd sunrpc i2c-matroxfb lirc_i2c 
lirc_dev tvaudio bttv tuner msp3400 i2c-algo-bit videodev ddcmon w83781d 
eeprom adm1021 sensors i2c-isa i2c-viapro i2c-core lvm-mod ipchains mga 
agpgart autofs4 epic100 emu10k1 soundcore ppp_deflate ppp_async 
ppp_generic lp parport_pc parport nls_iso8859-1 nls_cp437 msdos fat

I hope you fix it.

With best regards.
        Juergen


make modules gives:



