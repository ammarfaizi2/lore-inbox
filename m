Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265536AbSKABQ2>; Thu, 31 Oct 2002 20:16:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265541AbSKABQ2>; Thu, 31 Oct 2002 20:16:28 -0500
Received: from rwcrmhc53.attbi.com ([204.127.198.39]:49072 "EHLO
	rwcrmhc53.attbi.com") by vger.kernel.org with ESMTP
	id <S265536AbSKABQ1>; Thu, 31 Oct 2002 20:16:27 -0500
Message-ID: <3DC1D768.6000104@attbi.com>
Date: Thu, 31 Oct 2002 17:22:48 -0800
From: Miles Lane <miles.lane@attbi.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2b) Gecko/20021022
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: 2.5.45 -- usbaudio.c: 1882: structure has no member named `bInterfaceClass'
 in function `snd_usb_create_streams'
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

gcc -Wp,-MD,sound/usb/.usbaudio.o.d -D__KERNEL__ -Iinclude -Wall 
-Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer 
-fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2 
-march=athlon -Iarch/i386/mach-generic -nostdinc -iwithprefix include    
-DKBUILD_BASENAME=usbaudio   -c -o sound/usb/usbaudio.o 
sound/usb/usbaudio.c
sound/usb/usbaudio.c: In function `snd_usb_create_streams':
sound/usb/usbaudio.c:1882: structure has no member named `bInterfaceClass'
make[2]: *** [sound/usb/usbaudio.o] Error 1

#
# Sound
#
CONFIG_SOUND=y

#
# Advanced Linux Sound Architecture
#
CONFIG_SND=y
CONFIG_SND_SEQUENCER=y
CONFIG_SND_SEQ_DUMMY=y
CONFIG_SND_OSSEMUL=y
CONFIG_SND_MIXER_OSS=y
CONFIG_SND_PCM_OSS=y
CONFIG_SND_SEQUENCER_OSS=y
CONFIG_SND_RTCTIMER=y
CONFIG_SND_VERBOSE_PRINTK=y
CONFIG_SND_DEBUG=y
CONFIG_SND_DEBUG_MEMORY=y
CONFIG_SND_DEBUG_DETECT=y

#
# Generic devices
#
CONFIG_SND_DUMMY=y
CONFIG_SND_VIRMIDI=y
CONFIG_SND_MTPAV=y
CONFIG_SND_SERIAL_U16550=y
CONFIG_SND_MPU401=y

#
# PCI devices
#
CONFIG_SND_EMU10K1=y

#
# ALSA USB devices
#
CONFIG_SND_USB_AUDIO=y


