Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262462AbVCBSTN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262462AbVCBSTN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Mar 2005 13:19:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262422AbVCBSSC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Mar 2005 13:18:02 -0500
Received: from mail-in-09.arcor-online.net ([151.189.21.49]:64420 "EHLO
	mail-in-09.arcor-online.net") by vger.kernel.org with ESMTP
	id S262383AbVCBSRQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Mar 2005 13:17:16 -0500
Subject: Strange crashes of kernel v2.6.11
From: Steffen Michalke <StMichalke@web.de>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Date: Wed, 02 Mar 2005 18:17:08 +0000
Message-Id: <1109787428.6828.14.camel@pinky.local>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi:

I recently upgraded from linux kernel v2.6.10 to v2.6.11.
Some programs like evolution 2.0 and leafnode2 crash the whole system
immediatedly now.

I would like to provide some further information if i could gather them.

The ones I have:

/usr/src/linux/scripts/ver_linux 
If some fields are empty or look unusual you may have an old version.
Compare to the current minimal requirements in Documentation/Changes.
 
Linux pinky 2.6.10 #6 Wed Feb 9 12:14:53 CET 2005 i686 i686 i386
GNU/Linux
 
Gnu C                  3.4.3
Gnu make               3.80
binutils               2.15.91.0.2
util-linux             2.12c
mount                  2.12c
module-init-tools      3.1-pre5
e2fsprogs              1.35
jfsutils               1.1.7
reiserfsprogs          3.6.18
reiser4progs           line
nfs-utils              1.0.6
Linux C Library        02 02:30 /lib/tls/libc.so.6
Dynamic linker (ldd)   2.3.3
Linux C++ Library      6.0.3
Procps                 3.2.3
Net-tools              1.60
Kbd                    1.12
Sh-utils               5.2.1
udev                   030
Modules Loaded         snd_pcm_oss snd_mixer_oss snd_intel8x0 aes_i586
loop floppy psmouse parport_pc lp parport usblp snd_ac97_codec snd_pcm
snd_timer snd soundcore snd_page_alloc md5 ipv6 nfs lockd sunrpc rtc
pcspkr dm_crypt dm_mod joydev sg scsi_mod ide_cd cdrom natsemi crc32
intel_agp agpgart uhci_hcd hw_random usbcore unix

I did not change the configuration except of inserting the sound card
module.

I have never experienced such a disaster before coming out from a kernel
cahnge from one version to its succesor.

Ciaoi
Steffen


