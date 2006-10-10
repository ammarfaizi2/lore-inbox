Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965020AbWJJGzP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965020AbWJJGzP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Oct 2006 02:55:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965043AbWJJGzP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Oct 2006 02:55:15 -0400
Received: from holoclan.de ([62.75.158.126]:37002 "EHLO mail.holoclan.de")
	by vger.kernel.org with ESMTP id S965020AbWJJGzK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Oct 2006 02:55:10 -0400
Date: Tue, 10 Oct 2006 08:44:14 +0200
From: Martin Lorenz <martin@lorenz.eu.org>
To: linux-kernel@vger.kernel.org
Cc: linux-thinkpad@linux-thinkpad.org
Subject: 2.6.19-rc1-git oops on wakeup
Message-ID: <20061010064413.GE9895@gimli>
Mail-Followup-To: linux-kernel@vger.kernel.org,
	linux-thinkpad@linux-thinkpad.org
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="qtZFehHsKgwS5rPz"
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
X-Spam-Score: -1.4 (-)
X-Spam-Report: Spam detection software, running on the system "www.holoclan.de", has
	identified this incoming email as possible spam.  The original message
	has been attached to this so you can view it (if it isn't spam) or label
	similar future email.  If you have any questions, see
	the administrator of that system for details.
	Content preview:  [60027.250000] BUG: unable to handle kernel paging
	request at virtual address 756e6567 [60027.250000] printing eip:
	[60027.250000] c016f2ee [60027.250000] *pde = 00000000 [60027.250000]
	Oops: 0000 [#1] [60027.250000] SMP [60027.250000] Modules linked in:
	ppp_deflate zlib_deflate zlib_inflate bsd_comp ppp_async ppp_generic
	slhc ip_gre nls_cp437 vfat fat usb_storage usbhid i915 snd_hda_intel
	snd_hda_codec snd_pcm_oss snd_mixer_oss snd_pcm snd_timer snd soundcore
	snd_page_alloc binfmt_misc cpufreq_ondemand container video thermal
	i2c_ec fan dock button battery ac tun speedstep_centrino freq_table
	processor ibm_acpi sbp2 nvram eth1394 hci_usb bluetooth pcmcia
	firmware_class irtty_sir sir_dev generic ohci1394 nsc_ircc ide_core irda
	psmouse ieee1394 crc_ccitt yenta_socket rsrc_nonstatic pcmcia_core
	ehci_hcd uhci_hcd serio_raw usbcore sdhci mmc_core evdev pcspkr
	[60027.250000] CPU: 1 [60027.250000] EIP: 0060:[<c016f2ee>] Not tainted
	VLI [60027.250000] EFLAGS: 00010286
	(2.6.19-rc1+tpsmapi-ieee80211-nohdaps-gf1d08f71-dirty #1) [60027.250000]
	EIP is at iput+0xd/0x66 [60027.250000] eax: 756e6547 ebx: c041ed90 ecx:
	c016e2ab edx: e999c114 [60027.250000] esi: e9996d18 edi: e9996df8 ebp:
	f78b3600 esp: e6839de4 [60027.250000] ds: 007b es: 007b ss: 0068
	[60027.250000] Process mount (pid: 2292, ti=e6838000 task=d6b7c030
	task.ti=e6838000) [60027.250000] Stack: e9996df8 c016e41c e9996e20
	e9996d18 c016e71e fffffff3 00000000 f78b3600 [60027.250000] c36d7000
	c0161053 00000000 f78b363c 00000000 f78b3600 00000000 c017227d
	[60027.250000] 00000000 c36d7000 00000000 d5e17000 c36e5000 000003bb
	00000020 0cf68720 [60027.250000] Call Trace: [60027.251000] [<c016e41c>]
	prune_one_dentry+0x53/0x74 [60027.252000] [<c016e71e>]
	shrink_dcache_sb+0x8f/0xb3 [60027.253000] [<c0161053>]
	do_remount_sb+0x40/0x120 [60027.253000] [<c017227d>]
	do_mount+0x1b0/0x66c [60027.254000] [<c01727b0>] sys_mount+0x77/0xb3
	[60027.255000] [<c0102dc3>] syscall_call+0x7/0xb [60027.255000] DWARF2
	unwinder stuck at syscall_call+0x7/0xb [60027.255000] [60027.255000]
	Leftover [...] 
	Content analysis details:   (-1.4 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	-1.4 ALL_TRUSTED            Passed through trusted hosts only via SMTP
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--qtZFehHsKgwS5rPz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

[60027.250000] BUG: unable to handle kernel paging request at virtual
address 756e6567
[60027.250000]  printing eip:
[60027.250000] c016f2ee
[60027.250000] *pde = 00000000
[60027.250000] Oops: 0000 [#1]
[60027.250000] SMP
[60027.250000] Modules linked in: ppp_deflate zlib_deflate zlib_inflate
bsd_comp ppp_async ppp_generic slhc ip_gre nls_cp437 vfat fat usb_storage
usbhid i915 snd_hda_intel snd_hda_codec snd_pcm_oss snd_mixer_oss snd_pcm
snd_timer snd soundcore snd_page_alloc binfmt_misc cpufreq_ondemand
container video thermal i2c_ec fan dock button battery ac tun
speedstep_centrino freq_table processor ibm_acpi sbp2 nvram eth1394 hci_usb
bluetooth pcmcia firmware_class irtty_sir sir_dev generic ohci1394 nsc_ircc
ide_core irda psmouse ieee1394 crc_ccitt yenta_socket rsrc_nonstatic
pcmcia_core ehci_hcd uhci_hcd serio_raw usbcore sdhci mmc_core evdev pcspkr
[60027.250000] CPU:    1
[60027.250000] EIP:    0060:[<c016f2ee>]    Not tainted VLI
[60027.250000] EFLAGS: 00010286
(2.6.19-rc1+tpsmapi-ieee80211-nohdaps-gf1d08f71-dirty #1)
[60027.250000] EIP is at iput+0xd/0x66
[60027.250000] eax: 756e6547   ebx: c041ed90   ecx: c016e2ab   edx: e999c114
[60027.250000] esi: e9996d18   edi: e9996df8   ebp: f78b3600   esp: e6839de4
[60027.250000] ds: 007b   es: 007b   ss: 0068
[60027.250000] Process mount (pid: 2292, ti=e6838000 task=d6b7c030
task.ti=e6838000)
[60027.250000] Stack: e9996df8 c016e41c e9996e20 e9996d18 c016e71e fffffff3
00000000 f78b3600
[60027.250000]        c36d7000 c0161053 00000000 f78b363c 00000000 f78b3600
00000000 c017227d
[60027.250000]        00000000 c36d7000 00000000 d5e17000 c36e5000 000003bb
00000020 0cf68720
[60027.250000] Call Trace:
[60027.251000]  [<c016e41c>] prune_one_dentry+0x53/0x74
[60027.252000]  [<c016e71e>] shrink_dcache_sb+0x8f/0xb3
[60027.253000]  [<c0161053>] do_remount_sb+0x40/0x120
[60027.253000]  [<c017227d>] do_mount+0x1b0/0x66c
[60027.254000]  [<c01727b0>] sys_mount+0x77/0xb3
[60027.255000]  [<c0102dc3>] syscall_call+0x7/0xb
[60027.255000] DWARF2 unwinder stuck at syscall_call+0x7/0xb
[60027.255000]
[60027.255000] Leftover inexact backtrace:
[60027.255000]
[60027.255000]  =======================
[60027.255000] Code: ba 03 00 00 00 e9 97 07 fc ff 83 a0 2c 01 00 00 b7 e9
e0 ff ff ff e8 8a 36 17 00 31 c0 c3 53 89 c3 85 c0 74 5d 8b 80 98 00 00 00
<8b> 40 20 83 bb 2c 01 00 00 20 75 08 0f 0b 5d 04 a0 59 30 c0 85
[60027.255000] EIP: [<c016f2ee>] iput+0xd/0x66 SS:ESP 0068:e6839de4
[60027.255000]

dmesg attached

belive it or not: after that acpi events work again
I did not reboot but only suspended to ram and resumed again

so that makes: whenever I suspend/resume something strange happens which
makes my ACPI events diappear/reappear

I will reboot now to avoid instabilities

gruss
  mlo
--
Dipl.-Ing. Martin Lorenz

            They that can give up essential liberty 
	    to obtain a little temporary safety 
	    deserve neither liberty nor safety.
                                   Benjamin Franklin

please encrypt your mail to me
GnuPG key-ID: F1AAD37D
get it here:
http://blackhole.pca.dfn.de:11371/pks/lookup?op=get&search=0xF1AAD37D

ICQ UIN: 33588107

--qtZFehHsKgwS5rPz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="dmesg.now"

ound at 14
[22692.825000] usb-storage: waiting for device to settle before scanning
[22697.826000] scsi 9:0:0:0: Direct-Access     USB 2.0  memory           0.00 PQ: 0 ANSI: 2
[22697.828000] SCSI device sdb: 1024000 512-byte hdwr sectors (524 MB)
[22697.828000] sdb: Write Protect is off
[22697.828000] sdb: Mode Sense: 00 00 00 00
[22697.828000] sdb: assuming drive cache: write through
[22697.830000] SCSI device sdb: 1024000 512-byte hdwr sectors (524 MB)
[22697.831000] sdb: Write Protect is off
[22697.831000] sdb: Mode Sense: 00 00 00 00
[22697.831000] sdb: assuming drive cache: write through
[22697.831000]  sdb: sdb1
[22698.019000] sd 9:0:0:0: Attached scsi removable disk sdb
[22698.019000] usb-storage: device scan complete
[22980.504000] usb 5-5: USB disconnect, address 14
[56763.356000] ACPI: PCI interrupt for device 0000:03:00.0 disabled
[56763.357000] ieee80211_crypt: unregistered algorithm 'NULL'
[56767.070000] Disabling non-boot CPUs ...
[56767.178000] CPU 1 is now offline
[56767.178000] SMP alternatives: switching to UP code
[56767.182000] CPU1 is down
[56767.182000] Stopping tasks: =======================================================================================================================================================================================================================================================================|
[56767.441000] Suspending console(s)
[56767.453000]  usbdev4.8_ep83: PM: suspend 0->2, parent 4-2:1.0 already 2
[56767.453000]  usbdev4.8_ep02: PM: suspend 0->2, parent 4-2:1.0 already 2
[56767.453000]  usbdev4.8_ep81: PM: suspend 0->2, parent 4-2:1.0 already 2
[56767.453000] usb 4-2:1.0: PM: suspend 2->2, parent 4-2 already 2
[56767.453000]  usbdev4.8_ep00: PM: suspend 0->2, parent 4-2 already 2
[56769.134000] pnp: Device 00:0a disabled.
[56769.134000] ACPI: PCI interrupt for device 0000:15:00.2 disabled
[56769.156000] ACPI: PCI interrupt for device 0000:15:00.0 disabled
[56769.200000] ACPI: PCI interrupt for device 0000:02:00.0 disabled
[56769.213000] ACPI: PCI interrupt for device 0000:00:1f.2 disabled
[56769.224000] ACPI: PCI interrupt for device 0000:00:1d.7 disabled
[56769.335000] ACPI: PCI interrupt for device 0000:00:1d.3 disabled
[56769.335000] ACPI: PCI interrupt for device 0000:00:1d.2 disabled
[56769.335000] ACPI: PCI interrupt for device 0000:00:1d.1 disabled
[56769.335000] ACPI: PCI interrupt for device 0000:00:1d.0 disabled
[56769.337000] ACPI: PCI interrupt for device 0000:00:1b.0 disabled
[56769.337000] Intel machine check architecture supported.
[56769.337000] Intel machine check reporting enabled on CPU#0.
[56769.337000] Back to C!
[57422.955000] PM: Writing back config space on device 0000:00:02.1 at offset 1 (was 900000, writing 900003)
[57422.955000] PM: Writing back config space on device 0000:00:1b.0 at offset 1 (was 100106, writing 100100)
[57422.955000] PCI: Enabling device 0000:00:1b.0 (0100 -> 0102)
[57422.955000] ACPI: PCI Interrupt 0000:00:1b.0[B] -> GSI 17 (level, low) -> IRQ 22
[57422.955000] PCI: Setting latency timer of device 0000:00:1b.0 to 64
[57422.974000] PM: Writing back config space on device 0000:00:1c.0 at offset 1 (was 100107, writing 100507)
[57422.974000] PCI: Setting latency timer of device 0000:00:1c.0 to 64
[57422.974000] PM: Writing back config space on device 0000:00:1c.1 at offset 1 (was 100107, writing 100507)
[57422.974000] PCI: Setting latency timer of device 0000:00:1c.1 to 64
[57422.974000] PM: Writing back config space on device 0000:00:1c.2 at offset 1 (was 100107, writing 100507)
[57422.974000] PCI: Setting latency timer of device 0000:00:1c.2 to 64
[57422.974000] PM: Writing back config space on device 0000:00:1c.3 at offset f (was 40400, writing 4040b)
[57422.974000] PM: Writing back config space on device 0000:00:1c.3 at offset 9 (was 10001, writing e421e421)
[57422.974000] PM: Writing back config space on device 0000:00:1c.3 at offset 8 (was 0, writing ebf0ea00)
[57422.974000] PM: Writing back config space on device 0000:00:1c.3 at offset 7 (was 20000000, writing 8070)
[57422.974000] PM: Writing back config space on device 0000:00:1c.3 at offset 3 (was 810000, writing 810010)
[57422.974000] PM: Writing back config space on device 0000:00:1c.3 at offset 1 (was 100000, writing 100507)
[57422.974000] PCI: Setting latency timer of device 0000:00:1c.3 to 64
[57422.974000] ACPI: PCI Interrupt 0000:00:1d.0[A] -> GSI 16 (level, low) -> IRQ 20
[57422.974000] PCI: Setting latency timer of device 0000:00:1d.0 to 64
[57422.974000] usb usb1: root hub lost power or was reset
[57422.974000] ACPI: PCI Interrupt 0000:00:1d.1[B] -> GSI 17 (level, low) -> IRQ 22
[57422.974000] PCI: Setting latency timer of device 0000:00:1d.1 to 64
[57422.974000] usb usb2: root hub lost power or was reset
[57422.974000] ACPI: PCI Interrupt 0000:00:1d.2[C] -> GSI 18 (level, low) -> IRQ 21
[57422.974000] PCI: Setting latency timer of device 0000:00:1d.2 to 64
[57422.974000] usb usb3: root hub lost power or was reset
[57422.974000] ACPI: PCI Interrupt 0000:00:1d.3[D] -> GSI 19 (level, low) -> IRQ 23
[57422.974000] PCI: Setting latency timer of device 0000:00:1d.3 to 64
[57422.974000] usb usb4: root hub lost power or was reset
[57423.285000] ACPI: PCI Interrupt 0000:00:1d.7[D] -> GSI 19 (level, low) -> IRQ 23
[57423.285000] PCI: Setting latency timer of device 0000:00:1d.7 to 64
[57423.285000] PM: Writing back config space on device 0000:00:1e.0 at offset 1 (was 100005, writing 100007)
[57423.285000] PCI: Setting latency timer of device 0000:00:1e.0 to 64
[57423.296000] ACPI: PCI Interrupt 0000:00:1f.2[B] -> GSI 16 (level, low) -> IRQ 20
[57423.296000] PCI: Setting latency timer of device 0000:00:1f.2 to 64
[57424.308000] ACPI: PCI Interrupt 0000:02:00.0[A] -> GSI 16 (level, low) -> IRQ 20
[57424.308000] PCI: Setting latency timer of device 0000:02:00.0 to 64
[57424.351000] PM: Writing back config space on device 0000:03:00.0 at offset 1 (was 100106, writing 100100)
[57424.351000] PM: Writing back config space on device 0000:15:00.0 at offset 1 (was 2100000, writing 2100007)
[57424.351000] ACPI: PCI Interrupt 0000:15:00.0[A] -> GSI 16 (level, low) -> IRQ 20
[57424.393000] PM: Writing back config space on device 0000:15:00.1 at offset 4 (was 0, writing e4301000)
[57424.393000] PM: Writing back config space on device 0000:15:00.1 at offset 3 (was 800000, writing 804000)
[57424.393000] PM: Writing back config space on device 0000:15:00.1 at offset 1 (was 2100000, writing 2100006)
[57424.404000] PM: Writing back config space on device 0000:15:00.2 at offset 4 (was 0, writing e4301800)
[57424.404000] PM: Writing back config space on device 0000:15:00.2 at offset 3 (was 800000, writing 804000)
[57424.404000] PM: Writing back config space on device 0000:15:00.2 at offset 1 (was 2100000, writing 2100006)
[57424.404000] ACPI: PCI Interrupt 0000:15:00.2[C] -> GSI 18 (level, low) -> IRQ 21
[57424.415000] pnp: Device 00:08 does not support activation.
[57424.415000] pnp: Device 00:09 does not support activation.
[57424.416000] pnp: Device 00:0a activated.
[57424.600000] ata2: SATA link down (SStatus 0 SControl 0)
[57424.600000] ata3: SATA link down (SStatus 0 SControl 0)
[57424.600000] ata4: SATA link down (SStatus 0 SControl 0)
[57424.830000] nsc_ircc_init_dongle_interface(), No dongle connected
[57424.830000] nsc_ircc_change_dongle_speed(), No dongle connected is not for IrDA mode
[57424.842000]  usbdev4.8_ep00: PM: resume from 0, parent 4-2 still 2
[57424.842000]  usbdev4.8_ep81: PM: resume from 0, parent 4-2:1.0 still 2
[57424.842000]  usbdev4.8_ep02: PM: resume from 0, parent 4-2:1.0 still 2
[57424.842000]  usbdev4.8_ep83: PM: resume from 0, parent 4-2:1.0 still 2
[57424.842000]  usbdev4.9_ep00: PM: resume from 0, parent 4-1 still 2
[57424.842000] hci_usb 4-1:1.0: PM: resume from 2, parent 4-1 still 2
[57424.842000]  hci0: PM: resume from 0, parent 4-1:1.0 still 2
[57424.842000]  usbdev4.9_ep81: PM: resume from 0, parent 4-1:1.0 still 2
[57424.842000]  usbdev4.9_ep82: PM: resume from 0, parent 4-1:1.0 still 2
[57424.842000]  usbdev4.9_ep02: PM: resume from 0, parent 4-1:1.0 still 2
[57424.842000] hci_usb 4-1:1.1: PM: resume from 2, parent 4-1 still 2
[57424.842000]  usbdev4.9_ep83: PM: resume from 0, parent 4-1:1.1 still 2
[57424.842000]  usbdev4.9_ep03: PM: resume from 0, parent 4-1:1.1 still 2
[57424.842000] usb 4-1:1.2: PM: resume from 2, parent 4-1 still 2
[57424.842000]  usbdev4.9_ep84: PM: resume from 0, parent 4-1:1.2 still 2
[57424.842000]  usbdev4.9_ep04: PM: resume from 0, parent 4-1:1.2 still 2
[57424.842000] usb 4-1:1.3: PM: resume from 2, parent 4-1 still 2
[57424.843000] Restarting tasks...<6>usb 4-1: USB disconnect, address 9
[57424.868000]  done
[57424.868000] Enabling non-boot CPUs ...
[57424.900000] SMP alternatives: switching to SMP code
[57424.901000] Booting processor 1/1 eip 3000
[57424.911000] Initializing CPU#1
[57424.972000] Calibrating delay using timer specific routine.. 3325.04 BogoMIPS (lpj=1662520)
[57424.972000] CPU: After generic identify, caps: bfe9fbff 00100000 00000000 00000000 0000c1a9 00000000 00000000
[57424.972000] monitor/mwait feature present.
[57424.972000] CPU: L1 I cache: 32K, L1 D cache: 32K
[57424.972000] CPU: L2 cache: 2048K
[57424.972000] CPU: Physical Processor ID: 0
[57424.972000] CPU: Processor Core ID: 1
[57424.972000] CPU: After all inits, caps: bfe9fbff 00100000 00000000 00000940 0000c1a9 00000000 00000000
[57424.972000] Intel machine check architecture supported.
[57424.972000] Intel machine check reporting enabled on CPU#1.
[57424.972000] CPU1: Intel Genuine Intel(R) CPU           L2400  @ 1.66GHz stepping 08
[57424.999000] usb 4-2: USB disconnect, address 8
[57425.205000] usb 4-2: new full speed USB device using uhci_hcd and address 10
[57425.369000] usb 4-2: configuration #1 chosen from 1 choice
[57425.624000] CPU1 is up
[57425.787000] usb 4-1: new full speed USB device using uhci_hcd and address 11
[57425.823000] ata1: waiting for device to spin up (7 secs)
[57425.998000] usb 4-1: configuration #1 chosen from 1 choice
[57433.805000] ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[57433.809000] ata1.00: configured for UDMA/100
[57433.810000] SCSI device sda: 156301488 512-byte hdwr sectors (80026 MB)
[57433.810000] sda: Write Protect is off
[57433.810000] sda: Mode Sense: 00 3a 00 00
[57433.810000] SCSI device sda: drive cache: write back
[58268.899000] Disabling non-boot CPUs ...
[58269.008000] CPU 1 is now offline
[58269.008000] SMP alternatives: switching to UP code
[58269.013000] CPU1 is down
[58269.013000] Stopping tasks: ===============================================================================================================|
[58270.649000] Suspending console(s)
[58270.661000]  usbdev4.10_ep83: PM: suspend 0->2, parent 4-2:1.0 already 2
[58270.661000]  usbdev4.10_ep02: PM: suspend 0->2, parent 4-2:1.0 already 2
[58270.661000]  usbdev4.10_ep81: PM: suspend 0->2, parent 4-2:1.0 already 2
[58270.661000] usb 4-2:1.0: PM: suspend 2->2, parent 4-2 already 2
[58270.661000]  usbdev4.10_ep00: PM: suspend 0->2, parent 4-2 already 2
[58272.370000] pnp: Device 00:0a disabled.
[58272.371000] ACPI: PCI interrupt for device 0000:15:00.2 disabled
[58272.393000] ACPI: PCI interrupt for device 0000:15:00.0 disabled
[58272.437000] ACPI: PCI interrupt for device 0000:02:00.0 disabled
[58272.450000] ACPI: PCI interrupt for device 0000:00:1f.2 disabled
[58272.461000] ACPI: PCI interrupt for device 0000:00:1d.7 disabled
[58272.872000] ACPI: PCI interrupt for device 0000:00:1d.3 disabled
[58272.872000] ACPI: PCI interrupt for device 0000:00:1d.2 disabled
[58272.872000] ACPI: PCI interrupt for device 0000:00:1d.1 disabled
[58272.872000] ACPI: PCI interrupt for device 0000:00:1d.0 disabled
[58272.873000] ACPI: PCI interrupt for device 0000:00:1b.0 disabled
[58272.873000] Intel machine check architecture supported.
[58272.873000] Intel machine check reporting enabled on CPU#0.
[58272.873000] Back to C!
[58806.491000] PM: Writing back config space on device 0000:00:02.1 at offset 1 (was 900000, writing 900003)
[58806.491000] PM: Writing back config space on device 0000:00:1b.0 at offset 1 (was 100106, writing 100100)
[58806.491000] PCI: Enabling device 0000:00:1b.0 (0100 -> 0102)
[58806.492000] ACPI: PCI Interrupt 0000:00:1b.0[B] -> GSI 17 (level, low) -> IRQ 22
[58806.492000] PCI: Setting latency timer of device 0000:00:1b.0 to 64
[58806.510000] PM: Writing back config space on device 0000:00:1c.0 at offset 1 (was 100107, writing 100507)
[58806.510000] PCI: Setting latency timer of device 0000:00:1c.0 to 64
[58806.510000] PM: Writing back config space on device 0000:00:1c.1 at offset 1 (was 100107, writing 100507)
[58806.510000] PCI: Setting latency timer of device 0000:00:1c.1 to 64
[58806.510000] PM: Writing back config space on device 0000:00:1c.2 at offset 1 (was 100107, writing 100507)
[58806.510000] PCI: Setting latency timer of device 0000:00:1c.2 to 64
[58806.510000] PM: Writing back config space on device 0000:00:1c.3 at offset f (was 40400, writing 4040b)
[58806.510000] PM: Writing back config space on device 0000:00:1c.3 at offset 9 (was 10001, writing e421e421)
[58806.510000] PM: Writing back config space on device 0000:00:1c.3 at offset 8 (was 0, writing ebf0ea00)
[58806.510000] PM: Writing back config space on device 0000:00:1c.3 at offset 7 (was 20000000, writing 20008070)
[58806.510000] PM: Writing back config space on device 0000:00:1c.3 at offset 3 (was 810000, writing 810010)
[58806.510000] PM: Writing back config space on device 0000:00:1c.3 at offset 1 (was 100000, writing 100507)
[58806.510000] PCI: Setting latency timer of device 0000:00:1c.3 to 64
[58806.510000] ACPI: PCI Interrupt 0000:00:1d.0[A] -> GSI 16 (level, low) -> IRQ 20
[58806.510000] PCI: Setting latency timer of device 0000:00:1d.0 to 64
[58806.510000] usb usb1: root hub lost power or was reset
[58806.510000] ACPI: PCI Interrupt 0000:00:1d.1[B] -> GSI 17 (level, low) -> IRQ 22
[58806.510000] PCI: Setting latency timer of device 0000:00:1d.1 to 64
[58806.510000] usb usb2: root hub lost power or was reset
[58806.510000] ACPI: PCI Interrupt 0000:00:1d.2[C] -> GSI 18 (level, low) -> IRQ 21
[58806.510000] PCI: Setting latency timer of device 0000:00:1d.2 to 64
[58806.510000] usb usb3: root hub lost power or was reset
[58806.510000] ACPI: PCI Interrupt 0000:00:1d.3[D] -> GSI 19 (level, low) -> IRQ 23
[58806.510000] PCI: Setting latency timer of device 0000:00:1d.3 to 64
[58806.510000] usb usb4: root hub lost power or was reset
[58806.821000] ACPI: PCI Interrupt 0000:00:1d.7[D] -> GSI 19 (level, low) -> IRQ 23
[58806.821000] PCI: Setting latency timer of device 0000:00:1d.7 to 64
[58806.821000] PM: Writing back config space on device 0000:00:1e.0 at offset 1 (was 100005, writing 100007)
[58806.821000] PCI: Setting latency timer of device 0000:00:1e.0 to 64
[58806.832000] ACPI: PCI Interrupt 0000:00:1f.2[B] -> GSI 16 (level, low) -> IRQ 20
[58806.832000] PCI: Setting latency timer of device 0000:00:1f.2 to 64
[58807.844000] ACPI: PCI Interrupt 0000:02:00.0[A] -> GSI 16 (level, low) -> IRQ 20
[58807.844000] PCI: Setting latency timer of device 0000:02:00.0 to 64
[58807.887000] PM: Writing back config space on device 0000:03:00.0 at offset 1 (was 100106, writing 100100)
[58807.887000] PM: Writing back config space on device 0000:15:00.0 at offset 1 (was 2100000, writing 2100007)
[58807.887000] ACPI: PCI Interrupt 0000:15:00.0[A] -> GSI 16 (level, low) -> IRQ 20
[58807.929000] PM: Writing back config space on device 0000:15:00.1 at offset 4 (was 0, writing e4301000)
[58807.929000] PM: Writing back config space on device 0000:15:00.1 at offset 3 (was 800000, writing 804000)
[58807.929000] PM: Writing back config space on device 0000:15:00.1 at offset 1 (was 2100000, writing 2100006)
[58807.940000] PM: Writing back config space on device 0000:15:00.2 at offset 4 (was 0, writing e4301800)
[58807.940000] PM: Writing back config space on device 0000:15:00.2 at offset 3 (was 800000, writing 804000)
[58807.940000] PM: Writing back config space on device 0000:15:00.2 at offset 1 (was 2100000, writing 2100006)
[58807.940000] ACPI: PCI Interrupt 0000:15:00.2[C] -> GSI 18 (level, low) -> IRQ 21
[58807.951000] pnp: Device 00:08 does not support activation.
[58807.951000] pnp: Device 00:09 does not support activation.
[58807.952000] pnp: Device 00:0a activated.
[58808.136000] ata2: SATA link down (SStatus 0 SControl 0)
[58808.136000] ata3: SATA link down (SStatus 0 SControl 0)
[58808.136000] ata4: SATA link down (SStatus 0 SControl 0)
[58808.359000] nsc_ircc_init_dongle_interface(), No dongle connected
[58808.359000] nsc_ircc_change_dongle_speed(), No dongle connected is not for IrDA mode
[58808.371000]  usbdev4.10_ep00: PM: resume from 0, parent 4-2 still 2
[58808.371000]  usbdev4.10_ep81: PM: resume from 0, parent 4-2:1.0 still 2
[58808.371000]  usbdev4.10_ep02: PM: resume from 0, parent 4-2:1.0 still 2
[58808.371000]  usbdev4.10_ep83: PM: resume from 0, parent 4-2:1.0 still 2
[58808.371000]  usbdev4.11_ep00: PM: resume from 0, parent 4-1 still 2
[58808.371000] hci_usb 4-1:1.0: PM: resume from 2, parent 4-1 still 2
[58808.371000]  hci0: PM: resume from 0, parent 4-1:1.0 still 2
[58808.371000]  usbdev4.11_ep81: PM: resume from 0, parent 4-1:1.0 still 2
[58808.371000]  usbdev4.11_ep82: PM: resume from 0, parent 4-1:1.0 still 2
[58808.371000]  usbdev4.11_ep02: PM: resume from 0, parent 4-1:1.0 still 2
[58808.371000] hci_usb 4-1:1.1: PM: resume from 2, parent 4-1 still 2
[58808.371000]  usbdev4.11_ep83: PM: resume from 0, parent 4-1:1.1 still 2
[58808.371000]  usbdev4.11_ep03: PM: resume from 0, parent 4-1:1.1 still 2
[58808.371000] usb 4-1:1.2: PM: resume from 2, parent 4-1 still 2
[58808.371000]  usbdev4.11_ep84: PM: resume from 0, parent 4-1:1.2 still 2
[58808.371000]  usbdev4.11_ep04: PM: resume from 0, parent 4-1:1.2 still 2
[58808.371000] usb 4-1:1.3: PM: resume from 2, parent 4-1 still 2
[58808.372000] Restarting tasks...<6>usb 4-1: USB disconnect, address 11
[58808.439000]  done
[58808.439000] Enabling non-boot CPUs ...
[58808.451000] SMP alternatives: switching to SMP code
[58808.452000] Booting processor 1/1 eip 3000
[58808.463000] Initializing CPU#1
[58808.523000] Calibrating delay using timer specific routine.. 3325.03 BogoMIPS (lpj=1662517)
[58808.523000] CPU: After generic identify, caps: bfe9fbff 00100000 00000000 00000000 0000c1a9 00000000 00000000
[58808.523000] monitor/mwait feature present.
[58808.523000] CPU: L1 I cache: 32K, L1 D cache: 32K
[58808.523000] CPU: L2 cache: 2048K
[58808.523000] CPU: Physical Processor ID: 0
[58808.523000] CPU: Processor Core ID: 1
[58808.523000] CPU: After all inits, caps: bfe9fbff 00100000 00000000 00000940 0000c1a9 00000000 00000000
[58808.523000] Intel machine check architecture supported.
[58808.523000] Intel machine check reporting enabled on CPU#1.
[58808.523000] CPU1: Intel Genuine Intel(R) CPU           L2400  @ 1.66GHz stepping 08
[58808.524000] usb 4-2: USB disconnect, address 10
[58808.730000] usb 4-2: new full speed USB device using uhci_hcd and address 12
[58808.893000] usb 4-2: configuration #1 chosen from 1 choice
[58809.316000] usb 4-1: new full speed USB device using uhci_hcd and address 13
[58809.363000] ata1: waiting for device to spin up (7 secs)
[58809.476000] usb 4-1: configuration #1 chosen from 1 choice
[58809.829000] CPU1 is up
[58817.341000] ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[58817.345000] ata1.00: configured for UDMA/100
[58817.346000] SCSI device sda: 156301488 512-byte hdwr sectors (80026 MB)
[58817.346000] sda: Write Protect is off
[58817.347000] sda: Mode Sense: 00 3a 00 00
[58817.347000] SCSI device sda: drive cache: write back
[59739.489000] Disabling non-boot CPUs ...
[59739.594000] CPU 1 is now offline
[59739.594000] SMP alternatives: switching to UP code
[59739.597000] CPU1 is down
[59739.597000] Stopping tasks: ===========================================================================================================|
[59741.371000] Suspending console(s)
[59741.383000]  usbdev4.12_ep83: PM: suspend 0->2, parent 4-2:1.0 already 2
[59741.383000]  usbdev4.12_ep02: PM: suspend 0->2, parent 4-2:1.0 already 2
[59741.383000]  usbdev4.12_ep81: PM: suspend 0->2, parent 4-2:1.0 already 2
[59741.383000] usb 4-2:1.0: PM: suspend 2->2, parent 4-2 already 2
[59741.383000]  usbdev4.12_ep00: PM: suspend 0->2, parent 4-2 already 2
[59743.031000] pnp: Device 00:0a disabled.
[59743.031000] ACPI: PCI interrupt for device 0000:15:00.2 disabled
[59743.053000] ACPI: PCI interrupt for device 0000:15:00.0 disabled
[59743.097000] ACPI: PCI interrupt for device 0000:02:00.0 disabled
[59743.110000] ACPI: PCI interrupt for device 0000:00:1f.2 disabled
[59743.121000] ACPI: PCI interrupt for device 0000:00:1d.7 disabled
[59743.532000] ACPI: PCI interrupt for device 0000:00:1d.3 disabled
[59743.532000] ACPI: PCI interrupt for device 0000:00:1d.2 disabled
[59743.532000] ACPI: PCI interrupt for device 0000:00:1d.1 disabled
[59743.532000] ACPI: PCI interrupt for device 0000:00:1d.0 disabled
[59743.533000] ACPI: PCI interrupt for device 0000:00:1b.0 disabled
[59743.533000] Intel machine check architecture supported.
[59743.533000] Intel machine check reporting enabled on CPU#0.
[59743.533000] Back to C!
[60014.557000] PM: Writing back config space on device 0000:00:02.1 at offset 1 (was 900000, writing 900003)
[60014.557000] PM: Writing back config space on device 0000:00:1b.0 at offset 1 (was 100106, writing 100100)
[60014.557000] PCI: Enabling device 0000:00:1b.0 (0100 -> 0102)
[60014.557000] ACPI: PCI Interrupt 0000:00:1b.0[B] -> GSI 17 (level, low) -> IRQ 22
[60014.557000] PCI: Setting latency timer of device 0000:00:1b.0 to 64
[60014.575000] PM: Writing back config space on device 0000:00:1c.0 at offset 1 (was 100107, writing 100507)
[60014.575000] PCI: Setting latency timer of device 0000:00:1c.0 to 64
[60014.575000] PM: Writing back config space on device 0000:00:1c.1 at offset 1 (was 100107, writing 100507)
[60014.575000] PCI: Setting latency timer of device 0000:00:1c.1 to 64
[60014.575000] PM: Writing back config space on device 0000:00:1c.2 at offset 1 (was 100107, writing 100507)
[60014.575000] PCI: Setting latency timer of device 0000:00:1c.2 to 64
[60014.575000] PM: Writing back config space on device 0000:00:1c.3 at offset f (was 40400, writing 4040b)
[60014.575000] PM: Writing back config space on device 0000:00:1c.3 at offset 9 (was 10001, writing e421e421)
[60014.575000] PM: Writing back config space on device 0000:00:1c.3 at offset 8 (was 0, writing ebf0ea00)
[60014.575000] PM: Writing back config space on device 0000:00:1c.3 at offset 7 (was 20000000, writing 8070)
[60014.575000] PM: Writing back config space on device 0000:00:1c.3 at offset 3 (was 810000, writing 810010)
[60014.575000] PM: Writing back config space on device 0000:00:1c.3 at offset 1 (was 100000, writing 100507)
[60014.575000] PCI: Setting latency timer of device 0000:00:1c.3 to 64
[60014.575000] ACPI: PCI Interrupt 0000:00:1d.0[A] -> GSI 16 (level, low) -> IRQ 20
[60014.575000] PCI: Setting latency timer of device 0000:00:1d.0 to 64
[60014.575000] usb usb1: root hub lost power or was reset
[60014.575000] ACPI: PCI Interrupt 0000:00:1d.1[B] -> GSI 17 (level, low) -> IRQ 22
[60014.575000] PCI: Setting latency timer of device 0000:00:1d.1 to 64
[60014.575000] usb usb2: root hub lost power or was reset
[60014.575000] ACPI: PCI Interrupt 0000:00:1d.2[C] -> GSI 18 (level, low) -> IRQ 21
[60014.575000] PCI: Setting latency timer of device 0000:00:1d.2 to 64
[60014.575000] usb usb3: root hub lost power or was reset
[60014.575000] ACPI: PCI Interrupt 0000:00:1d.3[D] -> GSI 19 (level, low) -> IRQ 23
[60014.575000] PCI: Setting latency timer of device 0000:00:1d.3 to 64
[60014.575000] usb usb4: root hub lost power or was reset
[60014.586000] ACPI: PCI Interrupt 0000:00:1d.7[D] -> GSI 19 (level, low) -> IRQ 23
[60014.586000] PCI: Setting latency timer of device 0000:00:1d.7 to 64
[60014.587000] PM: Writing back config space on device 0000:00:1e.0 at offset 1 (was 100005, writing 100007)
[60014.587000] PCI: Setting latency timer of device 0000:00:1e.0 to 64
[60014.598000] ACPI: PCI Interrupt 0000:00:1f.2[B] -> GSI 16 (level, low) -> IRQ 20
[60014.598000] PCI: Setting latency timer of device 0000:00:1f.2 to 64
[60015.610000] ACPI: PCI Interrupt 0000:02:00.0[A] -> GSI 16 (level, low) -> IRQ 20
[60015.610000] PCI: Setting latency timer of device 0000:02:00.0 to 64
[60015.653000] PM: Writing back config space on device 0000:03:00.0 at offset 1 (was 100106, writing 100100)
[60015.653000] PM: Writing back config space on device 0000:15:00.0 at offset 1 (was 2100000, writing 2100007)
[60015.653000] ACPI: PCI Interrupt 0000:15:00.0[A] -> GSI 16 (level, low) -> IRQ 20
[60015.695000] PM: Writing back config space on device 0000:15:00.1 at offset 4 (was 0, writing e4301000)
[60015.695000] PM: Writing back config space on device 0000:15:00.1 at offset 3 (was 800000, writing 804000)
[60015.695000] PM: Writing back config space on device 0000:15:00.1 at offset 1 (was 2100000, writing 2100006)
[60015.706000] PM: Writing back config space on device 0000:15:00.2 at offset 4 (was 0, writing e4301800)
[60015.706000] PM: Writing back config space on device 0000:15:00.2 at offset 3 (was 800000, writing 804000)
[60015.706000] PM: Writing back config space on device 0000:15:00.2 at offset 1 (was 2100000, writing 2100006)
[60015.706000] ACPI: PCI Interrupt 0000:15:00.2[C] -> GSI 18 (level, low) -> IRQ 21
[60015.717000] pnp: Device 00:08 does not support activation.
[60015.717000] pnp: Device 00:09 does not support activation.
[60015.718000] pnp: Device 00:0a activated.
[60015.902000] ata2: SATA link down (SStatus 0 SControl 0)
[60015.902000] ata3: SATA link down (SStatus 0 SControl 0)
[60015.902000] ata4: SATA link down (SStatus 0 SControl 0)
[60016.130000] nsc_ircc_init_dongle_interface(), No dongle connected
[60016.130000] nsc_ircc_change_dongle_speed(), No dongle connected is not for IrDA mode
[60016.142000]  usbdev4.12_ep00: PM: resume from 0, parent 4-2 still 2
[60016.142000]  usbdev4.12_ep81: PM: resume from 0, parent 4-2:1.0 still 2
[60016.142000]  usbdev4.12_ep02: PM: resume from 0, parent 4-2:1.0 still 2
[60016.142000]  usbdev4.12_ep83: PM: resume from 0, parent 4-2:1.0 still 2
[60016.142000]  usbdev4.13_ep00: PM: resume from 0, parent 4-1 still 2
[60016.142000] hci_usb 4-1:1.0: PM: resume from 2, parent 4-1 still 2
[60016.142000]  hci0: PM: resume from 0, parent 4-1:1.0 still 2
[60016.142000]  usbdev4.13_ep81: PM: resume from 0, parent 4-1:1.0 still 2
[60016.142000]  usbdev4.13_ep82: PM: resume from 0, parent 4-1:1.0 still 2
[60016.142000]  usbdev4.13_ep02: PM: resume from 0, parent 4-1:1.0 still 2
[60016.142000] hci_usb 4-1:1.1: PM: resume from 2, parent 4-1 still 2
[60016.142000]  usbdev4.13_ep83: PM: resume from 0, parent 4-1:1.1 still 2
[60016.142000]  usbdev4.13_ep03: PM: resume from 0, parent 4-1:1.1 still 2
[60016.142000] usb 4-1:1.2: PM: resume from 2, parent 4-1 still 2
[60016.142000]  usbdev4.13_ep84: PM: resume from 0, parent 4-1:1.2 still 2
[60016.142000]  usbdev4.13_ep04: PM: resume from 0, parent 4-1:1.2 still 2
[60016.142000] usb 4-1:1.3: PM: resume from 2, parent 4-1 still 2
[60016.143000] Restarting tasks...<6>usb 4-1: USB disconnect, address 13
[60016.190000]  done
[60016.190000] Enabling non-boot CPUs ...
[60016.196000] SMP alternatives: switching to SMP code
[60016.197000] Booting processor 1/1 eip 3000
[60016.208000] Initializing CPU#1
[60016.268000] Calibrating delay using timer specific routine.. 3325.09 BogoMIPS (lpj=1662546)
[60016.268000] CPU: After generic identify, caps: bfe9fbff 00100000 00000000 00000000 0000c1a9 00000000 00000000
[60016.268000] monitor/mwait feature present.
[60016.268000] CPU: L1 I cache: 32K, L1 D cache: 32K
[60016.268000] CPU: L2 cache: 2048K
[60016.268000] CPU: Physical Processor ID: 0
[60016.268000] CPU: Processor Core ID: 1
[60016.268000] CPU: After all inits, caps: bfe9fbff 00100000 00000000 00000940 0000c1a9 00000000 00000000
[60016.268000] Intel machine check architecture supported.
[60016.268000] Intel machine check reporting enabled on CPU#1.
[60016.268000] CPU1: Intel Genuine Intel(R) CPU           L2400  @ 1.66GHz stepping 08
[60016.295000] usb 4-2: USB disconnect, address 12
[60016.332000] CPU1 is up
[60016.501000] usb 4-2: new full speed USB device using uhci_hcd and address 14
[60016.665000] usb 4-2: configuration #1 chosen from 1 choice
[60017.087000] usb 4-1: new full speed USB device using uhci_hcd and address 15
[60017.130000] ata1: waiting for device to spin up (7 secs)
[60017.247000] usb 4-1: configuration #1 chosen from 1 choice
[60024.699000] ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[60024.703000] ata1.00: configured for UDMA/100
[60024.704000] SCSI device sda: 156301488 512-byte hdwr sectors (80026 MB)
[60024.704000] sda: Write Protect is off
[60024.704000] sda: Mode Sense: 00 3a 00 00
[60024.704000] SCSI device sda: drive cache: write back
[60027.250000] BUG: unable to handle kernel paging request at virtual address 756e6567
[60027.250000]  printing eip:
[60027.250000] c016f2ee
[60027.250000] *pde = 00000000
[60027.250000] Oops: 0000 [#1]
[60027.250000] SMP 
[60027.250000] Modules linked in: ppp_deflate zlib_deflate zlib_inflate bsd_comp ppp_async ppp_generic slhc ip_gre nls_cp437 vfat fat usb_storage usbhid i915 snd_hda_intel snd_hda_codec snd_pcm_oss snd_mixer_oss snd_pcm snd_timer snd soundcore snd_page_alloc binfmt_misc cpufreq_ondemand container video thermal i2c_ec fan dock button battery ac tun speedstep_centrino freq_table processor ibm_acpi sbp2 nvram eth1394 hci_usb bluetooth pcmcia firmware_class irtty_sir sir_dev generic ohci1394 nsc_ircc ide_core irda psmouse ieee1394 crc_ccitt yenta_socket rsrc_nonstatic pcmcia_core ehci_hcd uhci_hcd serio_raw usbcore sdhci mmc_core evdev pcspkr
[60027.250000] CPU:    1
[60027.250000] EIP:    0060:[<c016f2ee>]    Not tainted VLI
[60027.250000] EFLAGS: 00010286   (2.6.19-rc1+tpsmapi-ieee80211-nohdaps-gf1d08f71-dirty #1)
[60027.250000] EIP is at iput+0xd/0x66
[60027.250000] eax: 756e6547   ebx: c041ed90   ecx: c016e2ab   edx: e999c114
[60027.250000] esi: e9996d18   edi: e9996df8   ebp: f78b3600   esp: e6839de4
[60027.250000] ds: 007b   es: 007b   ss: 0068
[60027.250000] Process mount (pid: 2292, ti=e6838000 task=d6b7c030 task.ti=e6838000)
[60027.250000] Stack: e9996df8 c016e41c e9996e20 e9996d18 c016e71e fffffff3 00000000 f78b3600 
[60027.250000]        c36d7000 c0161053 00000000 f78b363c 00000000 f78b3600 00000000 c017227d 
[60027.250000]        00000000 c36d7000 00000000 d5e17000 c36e5000 000003bb 00000020 0cf68720 
[60027.250000] Call Trace:
[60027.251000]  [<c016e41c>] prune_one_dentry+0x53/0x74
[60027.252000]  [<c016e71e>] shrink_dcache_sb+0x8f/0xb3
[60027.253000]  [<c0161053>] do_remount_sb+0x40/0x120
[60027.253000]  [<c017227d>] do_mount+0x1b0/0x66c
[60027.254000]  [<c01727b0>] sys_mount+0x77/0xb3
[60027.255000]  [<c0102dc3>] syscall_call+0x7/0xb
[60027.255000] DWARF2 unwinder stuck at syscall_call+0x7/0xb
[60027.255000] 
[60027.255000] Leftover inexact backtrace:
[60027.255000] 
[60027.255000]  =======================
[60027.255000] Code: ba 03 00 00 00 e9 97 07 fc ff 83 a0 2c 01 00 00 b7 e9 e0 ff ff ff e8 8a 36 17 00 31 c0 c3 53 89 c3 85 c0 74 5d 8b 80 98 00 00 00 <8b> 40 20 83 bb 2c 01 00 00 20 75 08 0f 0b 5d 04 a0 59 30 c0 85 
[60027.255000] EIP: [<c016f2ee>] iput+0xd/0x66 SS:ESP 0068:e6839de4
[60027.255000]  

--qtZFehHsKgwS5rPz--
