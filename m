Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261533AbUJZXLX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261533AbUJZXLX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Oct 2004 19:11:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261534AbUJZXLX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Oct 2004 19:11:23 -0400
Received: from [217.7.64.195] ([217.7.64.195]:16796 "EHLO moci.net4u.de")
	by vger.kernel.org with ESMTP id S261533AbUJZXLA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Oct 2004 19:11:00 -0400
From: Ernst Herzberg <earny@net4u.de>
To: linux-kernel@vger.kernel.org
Subject: OOPS: 2.6.9 (not reproducable)
Date: Wed, 27 Oct 2004 01:10:57 +0200
User-Agent: KMail/1.7
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200410270110.57638.earny@net4u.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Thinkpad R50p:

Oct 26 23:26:25 halso Linux version 2.6.9 (root@halso) (gcc version 3.3.4 20040623 (Gentoo Linux 3.3.4-r1, ssp-3.3.2-2, pie-8.7.6)) #6 Mon Oct 25 23:49:02 CEST 2004
Oct 26 23:26:25 halso BIOS-provided physical RAM map:
Oct 26 23:26:25 halso BIOS-e820: 0000000000000000 - 000000000009f000 (usable)
Oct 26 23:26:25 halso BIOS-e820: 000000000009f000 - 00000000000a0000 (reserved)
Oct 26 23:26:25 halso BIOS-e820: 00000000000d2000 - 00000000000d4000 (reserved)
Oct 26 23:26:25 halso BIOS-e820: 00000000000dc000 - 0000000000100000 (reserved)
Oct 26 23:26:25 halso BIOS-e820: 0000000000100000 - 000000003ff60000 (usable)
Oct 26 23:26:25 halso BIOS-e820: 000000003ff60000 - 000000003ff77000 (ACPI data)
Oct 26 23:26:25 halso BIOS-e820: 000000003ff77000 - 000000003ff79000 (ACPI NVS)
Oct 26 23:26:25 halso BIOS-e820: 000000003ff80000 - 0000000040000000 (reserved)
Oct 26 23:26:25 halso BIOS-e820: 00000000ff800000 - 0000000100000000 (reserved)
Oct 26 23:26:25 halso 127MB HIGHMEM available.
Oct 26 23:26:25 halso 896MB LOWMEM available.
[....]
Oct 26 23:26:25 halso uhci_hcd 0000:00:1d.2: irq 11, io base 00001840
Oct 26 23:26:25 halso uhci_hcd 0000:00:1d.2: new USB bus registered, assigned bus number 3
Oct 26 23:26:25 halso hub 3-0:1.0: USB hub found
Oct 26 23:26:25 halso hub 3-0:1.0: 2 ports detected
Oct 26 23:26:25 halso ath0 (WE) : Buffer for request SIOCGIWPRIV too small (16<59)
Oct 26 23:26:25 halso ath0 (WE) : Buffer for request SIOCGIWPRIV too small (32<59)
Oct 26 23:26:25 halso usb 2-1: new low speed USB device using address 2
Oct 26 23:26:25 halso usbcore: registered new driver hiddev
Oct 26 23:26:25 halso usb 3-1: new full speed USB device using address 2
Oct 26 23:26:25 halso input: USB HID v1.00 Mouse [ACROX Combo Mouse] on usb-0000:00:1d.1-1
Oct 26 23:26:25 halso usbcore: registered new driver usbhid
Oct 26 23:26:25 halso drivers/usb/input/hid-core.c: v2.0:USB HID core driver
Oct 26 23:26:25 halso ACPI: PCI interrupt 0000:00:1d.7[D] -> GSI 11 (level, low) -> IRQ 11
Oct 26 23:26:25 halso ehci_hcd 0000:00:1d.7: Intel Corp. 82801DB/DBM (ICH4/ICH4-M) USB 2.0 EHCI Controller
Oct 26 23:26:25 halso PCI: Setting latency timer of device 0000:00:1d.7 to 64
Oct 26 23:26:25 halso ehci_hcd 0000:00:1d.7: irq 11, pci mem f9bf4000
Oct 26 23:26:25 halso ehci_hcd 0000:00:1d.7: new USB bus registered, assigned bus number 4
Oct 26 23:26:25 halso PCI: cache line size of 32 is not supported by device 0000:00:1d.7
Oct 26 23:26:25 halso ehci_hcd 0000:00:1d.7: USB 2.0 enabled, EHCI 1.00, driver 2004-May-10
Oct 26 23:26:25 halso usb 2-1: USB disconnect, address 2
Oct 26 23:26:25 halso hub 4-0:1.0: USB hub found
Oct 26 23:26:25 halso hub 4-0:1.0: 6 ports detected
Oct 26 23:26:25 halso Bluetooth: HCI USB driver ver 2.7
Oct 26 23:26:25 halso hci_usb_probe: Can't set isoc interface settings
Oct 26 23:26:25 halso Unable to handle kernel NULL pointer dereference at virtual address 00000120
Oct 26 23:26:25 halso printing eip:
Oct 26 23:26:25 halso f9c5688f
Oct 26 23:26:25 halso *pde = 00000000
Oct 26 23:26:25 halso Oops: 0000 [#1]
Oct 26 23:26:25 halso PREEMPT
Oct 26 23:26:25 halso Modules linked in: hci_usb ehci_hcd usbhid uhci_hcd evdev ath_pci ath_rate_onoe wlan ath_hal ds yenta_socket pcmcia_core snd_intel8x0 snd_ac97_codec snd_mpu401_uart snd_rawmi
di snd_seq_oss snd_seq_midi_event snd_seq snd_seq_device snd_pcm_oss snd_pcm snd_timer snd_page_alloc snd_mixer_oss snd soundcore usbcore irtty_sir sir_dev irda crc_ccitt st sr_mod scsi_mod
Oct 26 23:26:25 halso CPU:    0
Oct 26 23:26:25 halso EIP:    0060:[<f9c5688f>]    Tainted: P   VLI
Oct 26 23:26:25 halso EFLAGS: 00010296   (2.6.9)
Oct 26 23:26:25 halso EIP is at hci_usb_close+0xf/0x60 [hci_usb]
Oct 26 23:26:25 halso eax: c1917240   ebx: 00000000   ecx: f70269f8   edx: c1917250
Oct 26 23:26:25 halso esi: 00000000   edi: 00000002   ebp: f9c58a00   esp: f709fe3c
Oct 26 23:26:25 halso ds: 007b   es: 007b   ss: 0068
Oct 26 23:26:25 halso Process modprobe (pid: 9335, threadinfo=f709e000 task=f7b06aa0)
Oct 26 23:26:25 halso Stack: f743d800 f705c880 00000000 f9c57adf 00000000 c1917240 f9c58b20 c1917240
Oct 26 23:26:25 halso f9c58b20 f98c2116 c1917240 c1917240 f700aab4 c1917250 f9c58b40 c0265d36
Oct 26 23:26:25 halso c1917250 c1917278 c1917250 f705c880 f98c23c0 c1917250 00000005 f9c579e7
Oct 26 23:26:25 halso Call Trace:
Oct 26 23:26:25 halso [<f9c57adf>] hci_usb_disconnect+0x2f/0xa0 [hci_usb]
Oct 26 23:26:25 halso [<f98c2116>] usb_unbind_interface+0x76/0x80 [usbcore]
Oct 26 23:26:25 halso [<c0265d36>] device_release_driver+0x66/0x70
Oct 26 23:26:25 halso [<f98c23c0>] usb_driver_release_interface+0x50/0x60 [usbcore]
Oct 26 23:26:25 halso [<f9c579e7>] hci_usb_probe+0x387/0x450 [hci_usb]
Oct 26 23:26:25 halso [<c018b0b0>] init_dir+0x0/0x20
Oct 26 23:26:25 halso [<f98c208b>] usb_probe_interface+0x6b/0x80 [usbcore]
Oct 26 23:26:25 halso [<c0265b5f>] bus_match+0x3f/0x70
Oct 26 23:26:25 halso [<c0265c8c>] driver_attach+0x5c/0xa0
Oct 26 23:26:25 halso [<c02661b1>] bus_add_driver+0x91/0xb0
Oct 26 23:26:25 halso [<c026675f>] driver_register+0x2f/0x40
Oct 26 23:26:25 halso [<c011a281>] vprintk+0x111/0x170
Oct 26 23:26:25 halso [<f98c215e>] usb_register+0x3e/0xa0 [usbcore]
Oct 26 23:26:25 halso [<c011a167>] printk+0x17/0x20
Oct 26 23:26:25 halso [<f9885028>] hci_usb_init+0x28/0x4f [hci_usb]
Oct 26 23:26:25 halso [<c0131992>] sys_init_module+0x182/0x230
Oct 26 23:26:25 halso [<c010434b>] syscall_call+0x7/0xb
Oct 26 23:26:25 halso Code: 83 7c 24 0c 03 0f 8e 11 ff ff ff 83 c4 10 5b 5e 5f 5d c3 89 f6 8d bc 27 00 00 00 00 83 ec 0c 89 5c 24 04 8b 5c 24 10 89 74 24 08 <8b> b3 20 01 00 00 0f ba 73 14 02 19 c
0 85 c0 74 29 9c 58 fa ba
Oct 26 23:26:25 halso <6>usb 3-1: USB disconnect, address 2
Oct 26 23:26:25 halso ohci_hcd: 2004 Feb 02 USB 1.1 'Open' Host Controller (OHCI) Driver (PCI)
Oct 26 23:26:25 halso hcid[10179]: Bluetooth HCI daemon
Oct 26 23:26:25 halso Bluetooth: L2CAP ver 2.4
Oct 26 23:26:25 halso Bluetooth: L2CAP socket layer initialized
Oct 26 23:26:25 halso sdpd[10181]: Bluetooth SDP daemon
Oct 26 23:26:25 halso Bluetooth: HIDP (Human Interface Emulation) ver 1.0
Oct 26 23:26:25 halso hidd[10187]: Bluetooth HID daemon
Oct 26 23:26:25 halso Bluetooth: RFCOMM ver 1.3
Oct 26 23:26:25 halso Bluetooth: RFCOMM socket layer initialized
Oct 26 23:26:25 halso Bluetooth: RFCOMM TTY layer initialized
Oct 26 23:26:25 halso dund[10193]: Bluetooth DUN daemon
Oct 26 23:26:25 halso Bluetooth: BNEP (Ethernet Emulation) ver 1.2
Oct 26 23:26:25 halso Bluetooth: BNEP filters: protocol multicast
Oct 26 23:26:25 halso pand[10197]: Bluetooth PAN daemon
Oct 26 23:26:26 halso sirdev_get_instance - ttyS1
Oct 26 23:26:26 halso irtty_open - ttyS1: irda line discipline opened
[....]

(full log available)

The machine start up without problems, but the mouse on USB does not work. After reboot everthing went to normal.

</earny>
