Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268432AbRH0ULK>; Mon, 27 Aug 2001 16:11:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268714AbRH0UKv>; Mon, 27 Aug 2001 16:10:51 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:26889 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S268837AbRH0UKo>; Mon, 27 Aug 2001 16:10:44 -0400
Subject: Re: Linux 2.4.9-ac2
To: greg@ulima.unil.ch (Gregoire Favre)
Date: Mon, 27 Aug 2001 21:13:45 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20010827220637.A9096@ulima.unil.ch> from "Gregoire Favre" at Aug 27, 2001 10:06:37 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15bSlW-0004ci-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> make[2]: Entering directory `/usr/src/linux/drivers/sound'
> ld -m elf_i386 -r -o soundcore.o sound_core.o sound_firmware.o
> ld -m elf_i386 -r -o sound.o dev_table.o soundcard.o sound_syms.o
> audio.o audio_syms.o dmabuf.o midi_syms.o midi_synth.o midibuf.o
> sequencer.o sequencer_syms.o sound_timer.o sys_timer.o
> make -C emu10k1 modules
> make[3]: Entering directory `/usr/src/linux/drivers/sound/emu10k1'
> make[3]: *** No rule to make target `emu_wrapper.h', needed by
> `hwaccess.h'.  Stop.

Worked for me.. Curious - did you do a make dep ?
