Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268286AbRH0UGw>; Mon, 27 Aug 2001 16:06:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268432AbRH0UGl>; Mon, 27 Aug 2001 16:06:41 -0400
Received: from ulima.unil.ch ([130.223.144.143]:33411 "EHLO ulima.unil.ch")
	by vger.kernel.org with ESMTP id <S268286AbRH0UG1>;
	Mon, 27 Aug 2001 16:06:27 -0400
Date: Mon, 27 Aug 2001 22:06:37 +0200
From: Gregoire Favre <greg@ulima.unil.ch>
To: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.9-ac2
Message-ID: <20010827220637.A9096@ulima.unil.ch>
In-Reply-To: <20010827181915.A16554@lightning.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20010827181915.A16554@lightning.swansea.linux.org.uk>
User-Agent: Mutt/1.3.19i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 27, 2001 at 06:19:15PM +0100, Alan Cox wrote:
> 
> 	ftp://ftp.kernel.org/pub/linux/kernel/people/alan/linux-2.4/
> 
> 		 Intermediate diffs are available from
> 			http://www.bzimage.org
> 
> *
> *	Experimental release.
> *
> *	This is just for resychronizing the mips merge with the mips 
> *	folks. It isnt worth running over -ac1.

So, emu10k1 won't also compile?
>From 2.4.9-ac1:

make[2]: Entering directory `/usr/src/linux/drivers/sound'
ld -m elf_i386 -r -o soundcore.o sound_core.o sound_firmware.o
ld -m elf_i386 -r -o sound.o dev_table.o soundcard.o sound_syms.o
audio.o audio_syms.o dmabuf.o midi_syms.o midi_synth.o midibuf.o
sequencer.o sequencer_syms.o sound_timer.o sys_timer.o
make -C emu10k1 modules
make[3]: Entering directory `/usr/src/linux/drivers/sound/emu10k1'
make[3]: *** No rule to make target `emu_wrapper.h', needed by
`hwaccess.h'.  Stop.
make[3]: Leaving directory `/usr/src/linux/drivers/sound/emu10k1'
make[2]: *** [_modsubdir_emu10k1] Error 2
make[2]: Leaving directory `/usr/src/linux/drivers/sound'
make[1]: *** [_modsubdir_sound] Error 2
make[1]: Leaving directory `/usr/src/linux/drivers'
make: *** [_mod_drivers] Error 2

Thanks,

	Greg
________________________________________________________________
http://ulima.unil.ch/greg ICQ:16624071 mailto:greg@ulima.unil.ch
