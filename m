Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266175AbTAOKhN>; Wed, 15 Jan 2003 05:37:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266186AbTAOKhN>; Wed, 15 Jan 2003 05:37:13 -0500
Received: from ns.indranet.co.nz ([210.54.239.210]:468 "EHLO
	mail.acheron.indranet.co.nz") by vger.kernel.org with ESMTP
	id <S266175AbTAOKhM>; Wed, 15 Jan 2003 05:37:12 -0500
Date: Wed, 15 Jan 2003 23:43:58 +1300
From: Andrew McGregor <andrew@indranet.co.nz>
To: Mikael Pettersson <mikpe@csd.uu.se>, voytech@ucw.cz
cc: linux-kernel@vger.kernel.org
Subject: Re: Dell Latitude CPi keyboard problems since 2.5.42
Message-ID: <481480000.1042627438@localhost.localdomain>
In-Reply-To: <15909.13901.284523.220804@harpo.it.uu.se>
References: <15909.13901.284523.220804@harpo.it.uu.se>
X-Mailer: Mulberry/3.0.0b10 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Possibly related:

Dell Inspiron 8000s won't warm reboot either.  They just freeze with a 
blinking cursor at the point where the bootloader would ordinarily load. 
Have to power off or reset.

Consistent in various versions from 2.5.44 to .55.  Have not tested 
earlier, nor yet later.

Andrew

--On Wednesday, January 15, 2003 11:22:05 +0100 Mikael Pettersson 
<mikpe@csd.uu.se> wrote:

> Vojtech,
>
> On October 17, I wrote to LKML:
>> Dell Latitude CPi laptop. Boot 2.5.42 or .43, then reboot.
>> Shortly after the screen is blanked and the BIOS starts, it
>> prints a "keyboard error" message and requests an F1 or F2
>> response (continue or go into SETUP). Never happened with any
>> other kernel on that machine.
>
> (see http://marc.theaimsgroup.com/?t=103484432100001&r=1&w=2
> for the full thread)
>
> This problem is still present in 2.5.58. Any ideas what might
> be causing it? I've tried a few obvious tweaks (forcing
> atkbd_reset=1, making atkbd_cleanup() do nothing), but none
> has helped.
>
> Kernel 2.5.41 and older, and current 2.4/2.2 kernels, don't
> cause this problem, so obviously the input driver must be doing
> _something_ the HW or BIOS doesn't like.
>
> I have CONFIG_{SERIO_I8042,KEYBOARD_ATKBD,INPUT_MOUSEDEV_PSAUX,
> MOUSE_PS2,INPUT_PCSKR} enabled.
>
> /Mikael
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>
>


