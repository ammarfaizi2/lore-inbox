Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265422AbTFWWhs (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Jun 2003 18:37:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265436AbTFWWhs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Jun 2003 18:37:48 -0400
Received: from lgsx13.lg.ehu.es ([158.227.2.28]:41968 "EHLO lgsx13.lg.ehu.es")
	by vger.kernel.org with ESMTP id S265422AbTFWWhp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Jun 2003 18:37:45 -0400
Date: Tue, 24 Jun 2003 01:04:48 +0200
From: Luis Miguel Garcia <ktech@wanadoo.es>
To: linux-kernel@vger.kernel.org
Subject: BUG ALSA Yamaha driver
Message-Id: <20030624010448.78270508.ktech@wanadoo.es>
X-Mailer: Sylpheed version 0.9.0claws (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello:

I'm getting this error when I compile Yamaha ALSA Module IN KERNEL. If I compile it as a module, all goes OK and sound works well. Any more info about it?
 

  LD      vmlinux
sound/built-in.o(.text+0x262e4): In function `snd_rawmidi_dev_register':
: referencia a `snd_seq_device_new' sin definir
sound/built-in.o(.text+0x27f99): In function `snd_opl3_hwdep_new':
: referencia a `snd_seq_device_new' sin definir
sound/built-in.o(.text+0x28c3b): In function `snd_opl3_synth_event_input':
: referencia a `snd_seq_instr_event' sin definir
sound/built-in.o(.text+0x28c54): In function `snd_opl3_synth_event_input':
: referencia a `snd_midi_process_event' sin definir
sound/built-in.o(.text+0x28c9c): In function `snd_opl3_synth_create_port':
: referencia a `snd_midi_channel_alloc_set' sin definir
sound/built-in.o(.text+0x28d77): In function `snd_opl3_synth_create_port':
: referencia a `snd_seq_event_port_attach' sin definir
sound/built-in.o(.text+0x28d9a): In function `snd_opl3_synth_create_port':
: referencia a `snd_midi_channel_free_set' sin definir
sound/built-in.o(.text+0x28e21): In function `snd_opl3_seq_new_device':
: referencia a `snd_seq_create_kernel_client' sin definir
sound/built-in.o(.text+0x28e77): In function `snd_opl3_seq_new_device':
: referencia a `snd_seq_kernel_client_ctl' sin definir
sound/built-in.o(.text+0x28e84): In function `snd_opl3_seq_new_device':
: referencia a `snd_seq_instr_list_new' sin definir
sound/built-in.o(.text+0x28e93): In function `snd_opl3_seq_new_device':
: referencia a `snd_seq_delete_kernel_client' sin definir
sound/built-in.o(.text+0x28ee5): In function `snd_opl3_seq_new_device':
: referencia a `snd_seq_fm_init' sin definir
sound/built-in.o(.text+0x28f45): In function `snd_opl3_seq_delete_device':
: referencia a `snd_seq_delete_kernel_client' sin definir
sound/built-in.o(.text+0x28f68): In function `snd_opl3_seq_delete_device':
: referencia a `snd_seq_instr_list_free' sin definir
sound/built-in.o(.text+0x28c6c): In function `snd_opl3_synth_free_port':
: referencia a `snd_midi_channel_free_set' sin definir
sound/built-in.o(.text+0x293e1): In function `snd_opl3_note_on':
: referencia a `snd_seq_instr_find' sin definir
sound/built-in.o(.text+0x297ff): In function `snd_opl3_note_on':
: referencia a `snd_seq_instr_free_use' sin definir
sound/built-in.o(.text+0x29a8f): In function `snd_opl3_note_on':
: referencia a `snd_seq_instr_free_use' sin definir
sound/built-in.o(.exit.text+0x38b): In function `alsa_opl3_seq_exit':
: referencia a `snd_seq_device_unregister_driver' sin definir
sound/built-in.o(.init.text+0x81b): In function `alsa_opl3_seq_init':
: referencia a `snd_seq_device_register_driver' sin definir
make: *** [vmlinux] Error 1
