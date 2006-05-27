Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751482AbWE0MSX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751482AbWE0MSX (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 27 May 2006 08:18:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751487AbWE0MSW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 27 May 2006 08:18:22 -0400
Received: from wr-out-0506.google.com ([64.233.184.234]:1601 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1751482AbWE0MSW convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 27 May 2006 08:18:22 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=dqqjt7mysORJ1UOkVOtVKlCLOwLnp018HO6MX1GdKnD9YS/VwFRURA1dEoO1Wpa61EOvOUs9kv5/Cnk1Ngpbl+miGs2mU1LVbSkjGfWhJ4LHfPvEg7WNL/pcJe33vwQnYc6OsG9JltpHnGkrMOSnXFcF97G/EVkoTiLqdyQ+7Lg=
Message-ID: <9a8748490605270518w76c062d2jcd1517fa7e977131@mail.gmail.com>
Date: Sat, 27 May 2006 14:18:21 +0200
From: "Jesper Juhl" <jesper.juhl@gmail.com>
To: "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
Subject: Section mismatch warning in usb-storage
Cc: weissg@vienna.at
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	format=flowed
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Just got this while building 2.6.17-rc5-git3 :

WARNING: drivers/usb/storage/usb-storage.o - Section mismatch:
reference to .exit.text: from .smp_locks after '' (at offset 0x60)


$ scripts/ver_linux
If some fields are empty or look unusual you may have an old version.
Compare to the current minimal requirements in Documentation/Changes.

Linux dragon 2.6.17-rc5 #1 SMP PREEMPT Thu May 25 21:45:32 CEST 2006
i686 athlon-4 i386 GNU/Linux

Gnu C                  3.4.6
Gnu make               3.81
binutils               2.15.92.0.2
util-linux             2.12r
mount                  2.12r
module-init-tools      3.2.2
e2fsprogs              1.38
reiserfsprogs          3.6.19
quota-tools            3.12.
PPP                    2.4.4b1
Linux C Library        2.3.6
Dynamic linker (ldd)   2.3.6
Linux C++ Library      6.0.3
Procps                 3.2.6
Net-tools              1.60
Kbd                    1.12
Sh-utils               5.95
udev                   071
Modules Loaded         snd_seq_oss snd_seq_midi_event snd_seq
snd_pcm_oss snd_mixer_oss uhci_hcd usbcore snd_emu10k1 snd_rawmidi
snd_ac97_codec snd_ac97_bus snd_pcm snd_seq_device snd_timer
snd_page_alloc snd_util_mem snd_hwdep snd agpgart


-- 
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
