Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266640AbSLJGUN>; Tue, 10 Dec 2002 01:20:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266643AbSLJGUN>; Tue, 10 Dec 2002 01:20:13 -0500
Received: from sccrmhc01.attbi.com ([204.127.202.61]:38540 "EHLO
	sccrmhc01.attbi.com") by vger.kernel.org with ESMTP
	id <S266640AbSLJGUJ>; Tue, 10 Dec 2002 01:20:09 -0500
Subject: sound/built-in.o: In function `snd_complete_urb': undefined
	reference to `usb_submit_urb'
From: Miles Lane <miles.lane@attbi.com>
To: LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Organization: 
Message-Id: <1039501666.7838.4.camel@bellybutton.attbi.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.0 
Date: 09 Dec 2002 22:27:47 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

#
# Advanced Linux Sound Architecture
#
CONFIG_SND=y
CONFIG_SND_SEQUENCER=y
# CONFIG_SND_SEQ_DUMMY is not set
CONFIG_SND_OSSEMUL=y
CONFIG_SND_MIXER_OSS=y
CONFIG_SND_PCM_OSS=y
CONFIG_SND_SEQUENCER_OSS=y
# CONFIG_SND_RTCTIMER is not set
CONFIG_SND_VERBOSE_PRINTK=y
CONFIG_SND_DEBUG=y
# CONFIG_SND_DEBUG_MEMORY is not set
CONFIG_SND_DEBUG_DETECT=y
CONFIG_SND_EMU10K1=y

CONFIG_SND_USB_AUDIO=y

#
# USB support
#
CONFIG_USB=m
CONFIG_USB_DEBUG=y

CONFIG_USB_EHCI_HCD=m
CONFIG_USB_OHCI_HCD=m
CONFIG_USB_UHCI_HCD=m

#
# USB Device Class drivers
#
CONFIG_USB_AUDIO=m
CONFIG_USB_BLUETOOTH_TTY=m
CONFIG_USB_MIDI=m
CONFIG_USB_ACM=m


ld -m elf_i386 -e stext -T arch/i386/vmlinux.lds.s
arch/i386/kernel/head.o arch/i386/kernel/init_task.o  init/built-in.o
--start-group  usr/built-in.o  arch/i386/kernel/built-in.o 
arch/i386/mm/built-in.o  arch/i386/mach-generic/built-in.o 
kernel/built-in.o  mm/built-in.o  fs/built-in.o  ipc/built-in.o 
security/built-in.o  crypto/built-in.o  lib/lib.a  arch/i386/lib/lib.a 
drivers/built-in.o  sound/built-in.o  arch/i386/pci/built-in.o 
net/built-in.o --end-group  -o .tmp_vmlinux1
sound/built-in.o: In function `snd_complete_urb':
sound/built-in.o(.text+0x55604): undefined reference to `usb_submit_urb'
sound/built-in.o: In function `snd_complete_sync_urb':
sound/built-in.o(.text+0x556d6): undefined reference to `usb_submit_urb'
sound/built-in.o: In function `deactivate_urbs':
sound/built-in.o(.text+0x557de): undefined reference to `usb_unlink_urb'
sound/built-in.o(.text+0x557ea): undefined reference to `usb_unlink_urb'
sound/built-in.o: In function `start_urbs':
sound/built-in.o(.text+0x55895): undefined reference to `usb_submit_urb'
sound/built-in.o(.text+0x558c7): undefined reference to `usb_submit_urb'
sound/built-in.o: In function `release_urb_ctx':
sound/built-in.o(.text+0x55b33): undefined reference to `usb_free_urb'
sound/built-in.o: In function `init_substream_urbs':
sound/built-in.o(.text+0x55d59): undefined reference to `usb_alloc_urb'
sound/built-in.o(.text+0x55df2): undefined reference to `usb_alloc_urb'
sound/built-in.o: In function `set_format':
sound/built-in.o(.text+0x5608e): undefined reference to
`usb_set_interface'
sound/built-in.o(.text+0x560c6): undefined reference to
`usb_set_interface'
sound/built-in.o(.text+0x56217): undefined reference to
`usb_control_msg'
sound/built-in.o(.text+0x56270): undefined reference to
`usb_control_msg'
sound/built-in.o(.text+0x5639f): undefined reference to
`usb_control_msg'
sound/built-in.o: In function `snd_usb_pcm_close':
sound/built-in.o(.text+0x567f5): undefined reference to
`usb_set_interface'
sound/built-in.o: In function `snd_usb_create_streams':
sound/built-in.o(.text+0x57bdc): undefined reference to
`usb_interface_claimed'
sound/built-in.o(.text+0x57c6c): undefined reference to
`usb_set_interface'
sound/built-in.o(.text+0x57c84): undefined reference to
`usb_driver_claim_interface'
sound/built-in.o: In function `snd_usb_roland_ua100_hack_intf':
sound/built-in.o(.text+0x57ddd): undefined reference to
`usb_set_interface'
sound/built-in.o: In function `snd_usb_roland_ua100_hack':
sound/built-in.o(.text+0x57e8e): undefined reference to
`usb_interface_claimed'
sound/built-in.o(.text+0x57ebe): undefined reference to
`usb_driver_claim_interface'
sound/built-in.o(.text+0x57ecf): undefined reference to
`usb_interface_claimed'
sound/built-in.o(.text+0x57f0b): undefined reference to
`usb_driver_claim_interface'
sound/built-in.o: In function `snd_usb_audio_create':
sound/built-in.o(.text+0x5816b): undefined reference to `usb_string'
sound/built-in.o(.text+0x581e5): undefined reference to `usb_string'
sound/built-in.o(.text+0x58274): undefined reference to `usb_string'
sound/built-in.o: In function `alloc_desc_buffer':
sound/built-in.o(.text+0x582cc): undefined reference to
`usb_get_descriptor'
sound/built-in.o(.text+0x58368): undefined reference to
`usb_get_descriptor'
sound/built-in.o: In function `snd_usb_audio_probe':
sound/built-in.o(.text+0x58474): undefined reference to
`usb_set_configuration'
sound/built-in.o: In function `snd_usb_copy_string_desc':
sound/built-in.o(.text+0x589eb): undefined reference to `usb_string'
sound/built-in.o: In function `get_ctl_value':
sound/built-in.o(.text+0x58b7a): undefined reference to
`usb_control_msg'
sound/built-in.o: In function `set_ctl_value':
sound/built-in.o(.text+0x58ca2): undefined reference to
`usb_control_msg'
sound/built-in.o: In function `snd_usbmidi_submit_urb':
sound/built-in.o(.text+0x5a997): undefined reference to `usb_submit_urb'
sound/built-in.o: In function `snd_usbmidi_in_endpoint_delete':
sound/built-in.o(.text+0x5b0ce): undefined reference to `usb_free_urb'
sound/built-in.o(.text+0x5b0e2): undefined reference to `usb_unlink_urb'
sound/built-in.o: In function `snd_usbmidi_get_int_epd':
sound/built-in.o(.text+0x5b183): undefined reference to
`usb_set_interface'
sound/built-in.o: In function `snd_usbmidi_in_endpoint_create':
sound/built-in.o(.text+0x5b21e): undefined reference to `usb_alloc_urb'
sound/built-in.o: In function `snd_usbmidi_out_endpoint_delete':
sound/built-in.o(.text+0x5b3a5): undefined reference to `usb_free_urb'
sound/built-in.o(.text+0x5b3b9): undefined reference to `usb_unlink_urb'
sound/built-in.o: In function `snd_usbmidi_out_endpoint_create':
sound/built-in.o(.text+0x5b42a): undefined reference to `usb_alloc_urb'
sound/built-in.o: In function `snd_usb_audio_init':
sound/built-in.o(.init.text+0x172e): undefined reference to
`usb_register'
make: *** [.tmp_vmlinux1] Error 1


