Return-Path: <linux-kernel-owner+w=401wt.eu-S965090AbXAEAGt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965090AbXAEAGt (ORCPT <rfc822;w@1wt.eu>);
	Thu, 4 Jan 2007 19:06:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965101AbXAEAGs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Jan 2007 19:06:48 -0500
Received: from ms-smtp-04.ohiordc.rr.com ([65.24.5.138]:61658 "EHLO
	ms-smtp-04.ohiordc.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965090AbXAEAGs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Jan 2007 19:06:48 -0500
Subject: PROBLEM: LSIFC909 mpt card fails to recognize devices
From: Justin Rosander <myrddinemrys@neo.rr.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Date: Thu, 04 Jan 2007 19:06:46 -0500
Message-Id: <1167955606.5133.13.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,
Please forward this to the appropriate maintainer.  Thank you.

[1.] One line summary of the problem:    My fibre channel drives fail to
be recognized by my LSIFC909 card. 
[2.] Full description of the problem/report:  see #1.
[3.] Keywords (i.e., modules, networking, kernel):
[4.] Kernel version (from /proc/version): 2.6.17-rt3 
[5.] Output of Oops.. message (if applicable) with symbolic information 
     resolved (see Documentation/oops-tracing.txt)
[6.] A small shell script or example program which triggers the
     problem (if possible) 
[7.] Environment
[7.1.] Software (add the output of the ver_linux script here)

If some fields are empty or look unusual you may have an old version.
Compare to the current minimal requirements in Documentation/Changes.

Linux pelleas 2.6.17-rt3 #1 PREEMPT Thu Jan 4 00:25:15 EST 2007 i686 GNU/Linux

Gnu C                  4.1.2 Gnu make               3.81
binutils               2.17 util-linux             2.12r
mount                  2.12r module-init-tools      3.3-pre2
e2fsprogs              1.39 xfsprogs               2.8.11
PPP                    2.4.4 Linux C Library        2.3.6 Dynamic
linker (ldd)   2.3.6 Procps                 3.2.7
Net-tools              1.60 Console-tools          0.2.3
Sh-utils               5.96 udev                   100 
Modules Loaded         mptctl mptfc mptscsih mptbase nvidia ppdev lp ipv6
dm_mod it87 hwmon_vid eeprom i2c_isa i2c_viapro snd_emu10k1_synth
snd_emux_synth snd_seq_virmidi snd_seq_midi_emul snd_seq_dummy
snd_seq_oss snd_seq_midi snd_seq_midi_event snd_seq tda9887 tuner
sd_mod snd_emu10k1 shpchp snd_rawmidi snd_ac97_codec snd_ac97_bus
pci_hotplug snd_pcm_oss snd_mixer_oss saa7134 video_buf compat_ioctl32
v4l2_common v4l1_compat snd_pcm snd_seq_device ir_kbd_i2c snd_timer
snd_page_alloc snd_util_mem snd_hwdep ir_common snd i2c_core psmouse
via_agp agpgart rtc eth1394 videodev analog evdev hci_usb joydev
mousedev pcspkr tsdev soundcore 8250_pnp bluetooth serio_raw ns558
gameport usblp parport_pc parport floppy ext3 jbd mbcache usb_storage
ide_cd cdrom ide_disk usbhid via82cxxx ohci1394 ieee1394 generic
ide_core scsi_transport_fc scsi_mod uhci_hcd ehci_hcd usbcore via_rhine
mii thermal processor fan



[7.2.] Processor information (from /proc/cpuinfo):

[7.3.] Module information (from /proc/modules):
mptctl 22468 0 - Live 0xd0d56000
mptfc 12872 0 - Live 0xd085a000
mptscsih 21376 1 mptfc, Live 0xd0cc8000
mptbase 46048 3 mptctl,mptfc,mptscsih, Live 0xd087d000
sd_mod 18952 0 - Live 0xd0aa8000
scsi_mod 123528 5 mptfc,mptscsih,sd_mod,usb_storage,scsi_transport_fc, Live 0xd08a4000



[7.4.] Loaded driver and hardware information (/proc/ioports, /proc/iomem)
[7.5.] PCI information ('lspci -vvv' as root)
[7.6.] SCSI information (from /proc/scsi/scsi)
[7.7.] Other information that might be relevant to the problem
       (please look in /proc and include all information that you
       think to be relevant):
[X.] Other notes, patches, fixes, workarounds:



