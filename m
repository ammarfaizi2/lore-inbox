Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287568AbRLaRUl>; Mon, 31 Dec 2001 12:20:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287571AbRLaRUb>; Mon, 31 Dec 2001 12:20:31 -0500
Received: from dial249.pm3abing3.abingdonpm.naxs.com ([216.98.75.249]:47511
	"EHLO ani.animx.eu.org") by vger.kernel.org with ESMTP
	id <S287568AbRLaRUT>; Mon, 31 Dec 2001 12:20:19 -0500
Date: Mon, 31 Dec 2001 12:28:53 -0500
From: Wakko Warner <wakko@animx.eu.org>
To: linux-kernel@vger.kernel.org
Subject: FWD: Re: 2.4.16 with es1370 pci
Message-ID: <20011231122852.C29342@animx.eu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.95.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Wrong address I sent this too.

----- Forwarded message from Wakko Warner <wakko> -----

Date: Mon, 31 Dec 2001 12:24:40 -0500
From: Wakko Warner <wakko>
To: Pierre Rousselet <pierre.rousselet@wanadoo.fr>,
	alan@lxorguk.ukuu.org.uk
Cc: linux-kernel@vger.rutgers.edu
Subject: Re: 2.4.16 with es1370 pci
Message-ID: <20011231122440.B29342@animx.eu.org>
In-Reply-To: <20011231065544.A28966@animx.eu.org> <3C3065CE.1070608@wanadoo.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.95.3i
In-Reply-To: <3C3065CE.1070608@wanadoo.fr>; from Pierre Rousselet on Mon, Dec 31, 2001 at 02:19:10PM +0100
Status: RO
Content-Length: 1634
Lines: 50

Pierre Rousselet wrote:
> Wakko Warner wrote:
> 
>  >  Here's part of an strace:
>  >
>  > open("/dev/dsp", O_WRONLY)              = 4
>  > ioctl(4, SNDCTL_DSP_GETBLKSIZE, 0x806ae1c) = 0
>  > ioctl(4, SNDCTL_DSP_RESET, 0)           = 0
>  > ioctl(4, SOUND_PCM_READ_BITS, 0xbffff880) = 0
>  > ioctl(4, SNDCTL_DSP_STEREO, 0xbffff87c) = 0
>  > ioctl(4, SOUND_PCM_READ_RATE, 0xbffff878) = 0
> 
> Which sound player are you stracing? vplay?

This was mpg123 v0.59q.  However, no player works (xmms, sound under wine,
bplay...)

>  > The only thing I can see is the fact it's on IRQ 15 with the usb 
> controller.
> 
> It is correct. Is local APIC enabled ? What is plugged in the usb port ?

I assume so since this is a dual CPU machine.  Alan mentioned something
about unloading the usb modules, I don't even use them and haven't since
this machine was booted.

>  > I honestly don't know why I'm doing this, as no message I ever post 
> gets answered.
> 
> Your sound card is dead, change it. Or give us more info about your 
> sound sofware.

Soundcard is fine, reboot takes care of it (no reset, no power off, just
reboot)  I didn't notice this with 2.2.19 or 2.2.13 (I had 2.2.13 up for 423
days w/o problems on this machine with this card.)

System:
tyan s1832dl board
2 pII 450 cpus
4 128mb pc100 sticks (EEPROM /w SPD)
Matrox g400max dual (was a g200 before when I used 2.2.20)
3com 3c905a
Adaptec aha-2940U/UW dual channel
Soundblaster PCI 64 (ES1370 which is having the problem)
Zoom 28.8k ISA modem (IRQ 9 IO 0x02E8)
Soundblaster 16 ISA (IRQ 7 IO 0x0220)


-- 
 Lab tests show that use of micro$oft causes cancer in lab animals

----- End forwarded message -----
-- 
 Lab tests show that use of micro$oft causes cancer in lab animals
