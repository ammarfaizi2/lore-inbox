Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278106AbRJOUlT>; Mon, 15 Oct 2001 16:41:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278281AbRJOUlK>; Mon, 15 Oct 2001 16:41:10 -0400
Received: from m1.bezeqint.net ([192.115.106.45]:20571 "EHLO m1.bezeqint.net")
	by vger.kernel.org with ESMTP id <S278106AbRJOUkx>;
	Mon, 15 Oct 2001 16:40:53 -0400
Message-ID: <3BCB4880.5020401@pisem.net>
Date: Mon, 15 Oct 2001 22:35:12 +0200
From: CuPoTKa <cupotka@pisem.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.5) Gecko/20011012
X-Accept-Language: ru, en-us, he
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>, alan@redhat.com
Subject: CM8338A audio chip bud report
Content-Type: text/plain; charset=KOI8-R; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

Problem: bad sound when playing MP3s with xmms or mpg123. It can be 
solved by switching to 8bit output with xmms (configuring MPEG plugin 
libmpg123.so to use 8bit instead of 16).

Problem with kernels from 2.4.6 to 2.4.12-ac2.
With kernels prior to 2.4.5 16bit output in xmms worked fine. With sound 
driver from 2.4.5 copied to 2.4.6-2.4.12 16bit audio works too.

Hardware : CM8338A sound chip based internal on-board sound card.
Software: Debian GNU Linux unstable on PII 400.

Linux cupotka.mine.nu 2.4.12-ac2 #1 Пнд Окт 15 17:04:14 IST 2001 i686 
unknown

Gnu C                  2.95.4
Gnu make               3.79.1
util-linux             2.11l
mount                  2.11l
modutils               2.4.10
e2fsprogs              1.25
reiserfsprogs          3.x.0j
PPP                    2.4.1
Linux C Library        2.2.4
Dynamic linker (ldd)   2.2.4
Procps                 2.0.7
Net-tools              1.60
Kbd                    [ключи...]
Console-tools          0.2.3
Sh-utils               2.0.11

Part of kernel .config file:

#
# Sound
#
CONFIG_SOUND=y
# CONFIG_SOUND_BT878 is not set
CONFIG_SOUND_CMPCI=y
CONFIG_SOUND_CMPCI_FM=y
CONFIG_SOUND_CMPCI_FMIO=388
CONFIG_SOUND_CMPCI_FMIO=388
CONFIG_SOUND_CMPCI_MIDI=y
CONFIG_SOUND_CMPCI_MPUIO=330
# CONFIG_SOUND_CMPCI_JOYSTICK is not set
CONFIG_SOUND_CMPCI_CM8738=y
# CONFIG_SOUND_CMPCI_SPDIFINVERSE is not set
CONFIG_SOUND_CMPCI_SPDIFLOOP=y
CONFIG_SOUND_CMPCI_SPEAKERS=2
# CONFIG_SOUND_EMU10K1 is not set
# CONFIG_MIDI_EMU10K1 is not set
# CONFIG_SOUND_FUSION is not set
# CONFIG_SOUND_CS4281 is not set
# CONFIG_SOUND_ES1370 is not set
# CONFIG_SOUND_ES1371 is not set
# CONFIG_SOUND_ESSSOLO1 is not set
# CONFIG_SOUND_MAESTRO is not set
# CONFIG_SOUND_MAESTRO3 is not set
# CONFIG_SOUND_ICH is not set
# CONFIG_SOUND_RME96XX is not set
# CONFIG_SOUND_SONICVIBES is not set
# CONFIG_SOUND_TRIDENT is not set
# CONFIG_SOUND_MSNDCLAS is not set
# CONFIG_SOUND_MSNDPIN is not set
# CONFIG_SOUND_VIA82CXXX is not set
# CONFIG_MIDI_VIA82CXXX is not set
# CONFIG_SOUND_OSS is not set
# CONFIG_SOUND_TVMIXER is not set


Part of /var/log/messages file:
kernel: cmpci: version $Revision: 5.64 $ time 17:09:32 Oct 15 2001
kernel: PCI: Found IRQ 10 for device 00:0f.0
kernel: cmpci: found CM8338A adapter at io 0xdc00 irq 10

-- 
        ____,
       /.---|
       `    |     ___
           (=\.  /-. \
            |\/\_|"|  |
B   R   C   |_\ |;-|  ;
e   e   u   | / \| |_/ \
S   G   P   | )/\/      \
t   a   o   | ( '|  \   |
     R   T   |    \_ /   \
     d   K   |    /  \_.--\
     S   a   \    |    (|\`
              |   |     \
              |   |      '.
              |  /         \
        jgs   \  \.__.__.-._)



