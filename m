Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262158AbULCLVN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262158AbULCLVN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Dec 2004 06:21:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261430AbULCLVN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Dec 2004 06:21:13 -0500
Received: from picard.ine.co.th ([203.152.41.3]:14252 "EHLO picard.ine.co.th")
	by vger.kernel.org with ESMTP id S262158AbULCLUs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Dec 2004 06:20:48 -0500
Subject: 2.6.9, 64bit, 4GB memory => panics ...
From: Rudolf Usselmann <rudi@asics.ws>
Reply-To: rudi@asics.ws
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Organization: ASICS.ws - Solutions for your ASICS & FPGA needs -
Message-Id: <1102072834.31282.1450.camel@cpu0>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Fri, 03 Dec 2004 18:20:34 +0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Dear Kernel Gurus ! :*)

I just installed Fedora Core 3, x86_64. It boots fine, but
crashes. The "crash" part occurs as soon as I start any
app that apparently uses some "larger" amount of memory.
At first I thought there was a problem with X, and my video
card. So I tried to login on one of the virtual screens (ALT-F1).
Here I was able to see a kernel panic screen when I started
several random apps. I am working in duplicating that and
capturing the full panic message.

My hardware is:
Tyan Tiger K8W (S2875) with two Opterons, 4 SATA drives
(with softraid) and a low end Nvidia MX-400 video card.
My BIOS version is 2.03.

I can use the system 100% with only 2GB of memory installed.
I have run the memtest86+ for over a day and did not get any
errors (with the full 4gb installed). Previously I was running
Fedora Core 2 but 32 bit, also with the 2.6.9 kernel and did
not have any problems with 4 GB of memory. My guess is the combination
of 64 bit and 4GB is causing the problem.

I have tried to compile my own kernel, and also got the 667
and 681 releases (for 2.6.9) from Fedora.org. Problem seems
to be persistent.

Here is the ver_linux output
-----------------------------------------------------------
Linux cpu10 2.6.9-1.681_FC3smp #1 SMP Thu Nov 18 15:30:11 EST 2004
x86_64 x86_64 x86_64 GNU
/Linux

Gnu C                  3.4.2
Gnu make               3.80
binutils               2.15.92.0.2
util-linux             2.12a
mount                  2.12a
module-init-tools      3.1-pre5
e2fsprogs              1.35
reiserfsprogs          line
reiser4progs           line
pcmcia-cs              3.2.7
quota-tools            3.12.
PPP                    2.4.2
isdn4k-utils           3.3
nfs-utils              1.0.6
Linux C Library        2.3.3
Dynamic linker (ldd)   2.3.3
Procps                 3.2.3
Net-tools              1.60
Kbd                    1.12
Sh-utils               5.2.1
Modules Loaded         autofs4 i2c_dev i2c_core nfs lockd sunrpc ds
yenta_socket pcmcia_cor
e dm_mod button battery ac nvidia md5 ipv6 ohci1394 ieee1394 ohci_hcd
uhci_hcd ehci_hcd hw_
random snd_intel8x0 snd_ac97_codec snd_pcm_oss snd_mixer_oss snd_pcm
snd_timer snd_page_all
oc gameport snd_mpu401_uart snd_rawmidi snd_seq_device snd soundcore
e1000 floppy ext3 jbd
raid5 xor sata_sil libata sd_mod scsi_mod
-----------------------------------------------------------

Any suggestions what may be causing the crashes ?

I do not subscribe to this list, so would sincerely appreciate
a cc of any replies. I'm sure I forgot to mention something,
please let me know what other information can be help full to
nail this down.

Thanks a lot in advance !

Kind Regards,
rudi

