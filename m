Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265898AbSLDHZg>; Wed, 4 Dec 2002 02:25:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265947AbSLDHZg>; Wed, 4 Dec 2002 02:25:36 -0500
Received: from rwcrmhc51.attbi.com ([204.127.198.38]:63186 "EHLO
	rwcrmhc51.attbi.com") by vger.kernel.org with ESMTP
	id <S265898AbSLDHZc>; Wed, 4 Dec 2002 02:25:32 -0500
Message-ID: <3DEDAFA6.5050908@attbi.com>
Date: Tue, 03 Dec 2002 23:32:54 -0800
From: Miles Lane <miles.lane@attbi.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3a) Gecko/20021129
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: 2.5.50 -- arch/i386/kernel/built-in.o(.data+0x11a4): In function
 `do_suspend_lowlevel': undefined reference to `save_processor_state
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

       ld -m elf_i386 -e stext -T arch/i386/vmlinux.lds.s 
arch/i386/kernel/head.o arch/i386/kernel/init_task.o  init/built-in.o 
--start-group  usr/built-in.o  arch/i386/kernel/built-in.o  
arch/i386/mm/built-in.o  arch/i386/mach-generic/built-in.o  
kernel/built-in.o  mm/built-in.o  fs/built-in.o  ipc/built-in.o  
security/built-in.o  crypto/built-in.o  lib/lib.a  arch/i386/lib/lib.a  
drivers/built-in.o  sound/built-in.o  arch/i386/pci/built-in.o  
net/built-in.o --end-group  -o .tmp_vmlinux1
arch/i386/kernel/built-in.o: In function `do_suspend_lowlevel':
arch/i386/kernel/built-in.o(.data+0x11a4): undefined reference to 
`save_processor_state'
arch/i386/kernel/built-in.o(.data+0x11aa): undefined reference to 
`saved_context_esp'
arch/i386/kernel/built-in.o(.data+0x11af): undefined reference to 
`saved_context_eax'
arch/i386/kernel/built-in.o(.data+0x11b5): undefined reference to 
`saved_context_ebx'
arch/i386/kernel/built-in.o(.data+0x11bb): undefined reference to 
`saved_context_ecx'
arch/i386/kernel/built-in.o(.data+0x11c1): undefined reference to 
`saved_context_edx'
arch/i386/kernel/built-in.o(.data+0x11c7): undefined reference to 
`saved_context_ebp'
arch/i386/kernel/built-in.o(.data+0x11cd): undefined reference to 
`saved_context_esi'
arch/i386/kernel/built-in.o(.data+0x11d3): undefined reference to 
`saved_context_edi'
arch/i386/kernel/built-in.o(.data+0x11da): undefined reference to 
`saved_context_eflags'
arch/i386/kernel/built-in.o(.data+0x121a): undefined reference to 
`saved_context_esp'
arch/i386/kernel/built-in.o(.data+0x1220): undefined reference to 
`saved_context_ebp'
arch/i386/kernel/built-in.o(.data+0x1225): undefined reference to 
`saved_context_eax'
arch/i386/kernel/built-in.o(.data+0x122b): undefined reference to 
`saved_context_ebx'
arch/i386/kernel/built-in.o(.data+0x1231): undefined reference to 
`saved_context_ecx'
arch/i386/kernel/built-in.o(.data+0x1237): undefined reference to 
`saved_context_edx'
arch/i386/kernel/built-in.o(.data+0x123d): undefined reference to 
`saved_context_esi'
arch/i386/kernel/built-in.o(.data+0x1243): undefined reference to 
`saved_context_edi'
arch/i386/kernel/built-in.o(.data+0x1248): undefined reference to 
`restore_processor_state'
arch/i386/kernel/built-in.o(.data+0x124e): undefined reference to 
`saved_context_eflags'
sound/built-in.o: In function `snd_complete_urb':
sound/built-in.o(.text+0x56f25): undefined reference to `usb_submit_urb'
sound/built-in.o: In function `snd_complete_sync_urb':
sound/built-in.o(.text+0x57002): undefined reference to `usb_submit_urb'
sound/built-in.o: In function `deactivate_urbs':
sound/built-in.o(.text+0x570fd): undefined reference to `usb_unlink_urb'
sound/built-in.o(.text+0x57109): undefined reference to `usb_unlink_urb'
sound/built-in.o: In function `start_urbs':
sound/built-in.o(.text+0x571b2): undefined reference to `usb_submit_urb'
sound/built-in.o(.text+0x571e4): undefined reference to `usb_submit_urb'
sound/built-in.o: In function `release_urb_ctx':
sound/built-in.o(.text+0x57455): undefined reference to `usb_free_urb'
sound/built-in.o: In function `init_substream_urbs':
sound/built-in.o(.text+0x5769b): undefined reference to `usb_alloc_urb'
sound/built-in.o(.text+0x57733): undefined reference to `usb_alloc_urb'
sound/built-in.o: In function `set_format':
sound/built-in.o(.text+0x579d9): undefined reference to `usb_set_interface'
sound/built-in.o(.text+0x57a0e): undefined reference to `usb_set_interface'
sound/built-in.o(.text+0x57b69): undefined reference to `usb_control_msg'
sound/built-in.o(.text+0x57bc2): undefined reference to `usb_control_msg'
sound/built-in.o(.text+0x57cf5): undefined reference to `usb_control_msg'
sound/built-in.o: In function `snd_usb_pcm_close':
sound/built-in.o(.text+0x58145): undefined reference to `usb_set_interface'
sound/built-in.o: In function `snd_usb_create_streams':
sound/built-in.o(.text+0x59585): undefined reference to 
`usb_interface_claimed'
sound/built-in.o(.text+0x5961b): undefined reference to `usb_set_interface'
sound/built-in.o(.text+0x59633): undefined reference to 
`usb_driver_claim_interface'
sound/built-in.o: In function `snd_usb_roland_ua100_hack_intf':
sound/built-in.o(.text+0x5978a): undefined reference to `usb_set_interface'
sound/built-in.o: In function `snd_usb_roland_ua100_hack':
sound/built-in.o(.text+0x59844): undefined reference to 
`usb_interface_claimed'
sound/built-in.o(.text+0x59874): undefined reference to 
`usb_driver_claim_interface'
sound/built-in.o(.text+0x59885): undefined reference to 
`usb_interface_claimed'
sound/built-in.o(.text+0x598c1): undefined reference to 
`usb_driver_claim_interface'
sound/built-in.o: In function `snd_usb_audio_create':
sound/built-in.o(.text+0x59b25): undefined reference to `usb_string'
sound/built-in.o(.text+0x59ba4): undefined reference to `usb_string'
sound/built-in.o(.text+0x59c3a): undefined reference to `usb_string'
sound/built-in.o: In function `alloc_desc_buffer':
sound/built-in.o(.text+0x59caa): undefined reference to `usb_get_descriptor'
sound/built-in.o(.text+0x59d58): undefined reference to `usb_get_descriptor'
sound/built-in.o: In function `snd_usb_audio_probe':
sound/built-in.o(.text+0x59e61): undefined reference to 
`usb_set_configuration'
sound/built-in.o: In function `snd_usb_copy_string_desc':
sound/built-in.o(.text+0x5a3ed): undefined reference to `usb_string'
sound/built-in.o: In function `get_ctl_value':
sound/built-in.o(.text+0x5a57e): undefined reference to `usb_control_msg'
sound/built-in.o: In function `set_ctl_value':
sound/built-in.o(.text+0x5a6b6): undefined reference to `usb_control_msg'
sound/built-in.o: In function `snd_usbmidi_submit_urb':
sound/built-in.o(.text+0x5c457): undefined reference to `usb_submit_urb'
sound/built-in.o: In function `snd_usbmidi_in_endpoint_delete':
sound/built-in.o(.text+0x5cb5d): undefined reference to `usb_free_urb'
sound/built-in.o(.text+0x5cb75): undefined reference to `usb_unlink_urb'
sound/built-in.o: In function `snd_usbmidi_get_int_epd':
sound/built-in.o(.text+0x5cc15): undefined reference to `usb_set_interface'
sound/built-in.o: In function `snd_usbmidi_in_endpoint_create':
sound/built-in.o(.text+0x5ccbf): undefined reference to `usb_alloc_urb'
sound/built-in.o: In function `snd_usbmidi_out_endpoint_delete':
sound/built-in.o(.text+0x5ce34): undefined reference to `usb_free_urb'
sound/built-in.o(.text+0x5ce4c): undefined reference to `usb_unlink_urb'
sound/built-in.o: In function `snd_usbmidi_out_endpoint_create':
sound/built-in.o(.text+0x5ceba): undefined reference to `usb_alloc_urb'
sound/built-in.o: In function `snd_usb_audio_init':
sound/built-in.o(.init.text+0x16eb): undefined reference to `usb_register'
make: *** [.tmp_vmlinux1] Error 1


