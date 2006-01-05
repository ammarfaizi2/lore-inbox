Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750752AbWAEN7H@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750752AbWAEN7H (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jan 2006 08:59:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750831AbWAEN7H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jan 2006 08:59:07 -0500
Received: from server5.web4a.de ([82.149.231.244]:9658 "EHLO server5.web4a.de")
	by vger.kernel.org with ESMTP id S1750752AbWAEN7G (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jan 2006 08:59:06 -0500
Date: Thu, 5 Jan 2006 14:58:58 +0100
From: Martin Bretschneider <mailing-lists-mmv@bretschneidernet.de>
To: linux-kernel@vger.kernel.org
Subject: PROBLEM: PS/2 keyboard does not work with 2.6.15
X-Mailer: Sylpheed-Claws 1.9.100 (GTK+ 2.8.8; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="MP_6X0CxFosJZSt=MUnAT26l_G"
Message-Id: <E1EuVds-0000n9-00@mars.bretschneidernet.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--MP_6X0CxFosJZSt=MUnAT26l_G
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
Content-Disposition: inline

Hi kernel-devs,

[1.]
a keyboard that is connected to to PS/2 port does not work with
kernel 2.6.15. That is to say that no action is seen at the login
promt if I enter any key.


[2.]
I used PS/2 keyboards for a long time with kernels < 2.6.15
like 2.6.14.2, 2.6.13 or 2.6.11.10. I used "make oldconfig" to move
the .config file form 2.6.14.2 to 2.6.15 and answered "no" to every
question¹

The keyboard is pluged the right way since I can walk around in the
lilo menu before the kernel is being loaded. If I choose another
kernel the PS/2 keyboard does work. I can connect to the pc with a
running 2.6.15 from another pc using ssh. Everything looks normal,
there are no strange errors in /var/log/syslog or from the output
dmesg. I can also use the soundcard...

I also tried another keyboard that do work on kernels < 2.6.15 with
no success.

I cannot tell if the PS/2 mouse does not work either since I cannot
start X.


[3.]
PS/2 keyboard, input


[4.] cat /proc/version
Linux version 2.6.15-06.01.03 (root@mars.bretschneidernet.de)
(gcc-Version 4.0.3 20051201 (prerelease) (Debian 4.0.2-5)) #1 PREEMPT
Tue Jan 3 20:50:32 CET 2006


[5.]
2.6.14.2


[8.1] ver_linux
If some fields are empty or look unusual you may have an old version.
Compare to the current minimal requirements in Documentation/Changes.

Linux mars.bretschneidernet.de 2.6.15-06.01.03 #1 PREEMPT Tue Jan 3
20:50:32 CET 2006 i686 GNU/Linux

Gnu C                  4.0.3
Gnu make               3.81beta4
binutils               2.16.91
util-linux             2.12p
mount                  2.12p
module-init-tools      3.2.2
e2fsprogs              1.38
reiserfsprogs          line
reiser4progs           line
xfsprogs               2.6.28
PPP                    2.4.4b1
Linux C Library        2.3.5
Dynamic linker (ldd)   2.3.5
Procps                 3.1.14
Net-tools              1.60
Console-tools          0.2.3
Sh-utils               5.93
udev                   079
Modules Loaded         parport_pc lp parport binfmt_misc rfcomm l2cap
bluetooth ipt_state ip_conntrack nfnetlink iptable_filter ip_tables
nls_iso8859_1 nls_cp437 vfat fat isofs it87 hwmon_vid hwmon i2c_isa
cryptoloop loop ppp_deflate zlib_deflate zlib_inflate bsd_comp
ppp_generic slhc thermal processor snd_emu10k1_synth snd_emux_synth
snd_seq_virmidi snd_seq_midi_emul snd_seq_oss snd_seq_midi
snd_seq_midi_event snd_seq snd_emu10k1 snd_rawmidi snd_seq_device
snd_ac97_codec snd_pcm_oss snd_mixer_oss snd_pcm snd_timer
snd_ac97_bus snd_page_alloc snd_util_mem snd_hwdep ehci_hcd ohci_hcd
forcedeth usbcore i2c_nforce2 i2c_core

[other information are attached]


[8.7.]
The motherboard is a Gigabyte GA-K8NF-9 using the nforce4 chipset.
The CPU in an AMD64 that does only run in the 32bit mode.


Kind regards from Martin

[1] The .config files can be seen on
http://www.bretschneidernet.de/tmp/config-2.6.14.2 and 
http://www.bretschneidernet.de/tmp/config-2.6.15
-- 
http://www.bretschneidernet.de        OpenPGP-key: 0x4EA52583
          (o__  (O_                Philip R. Zimmermann:
          //\'  //\               If privacy is outlawed,
          V_/_  V_/_          only outlaws will have privacy.

--MP_6X0CxFosJZSt=MUnAT26l_G
Content-Type: application/x-gzip; name=more_information.txt.gz
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename=more_information.txt.gz

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

--MP_6X0CxFosJZSt=MUnAT26l_G--
