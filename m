Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272092AbRHWHaT>; Thu, 23 Aug 2001 03:30:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272209AbRHWHaJ>; Thu, 23 Aug 2001 03:30:09 -0400
Received: from balu.sch.bme.hu ([152.66.208.40]:13286 "EHLO balu.sch.bme.hu")
	by vger.kernel.org with ESMTP id <S272092AbRHWH3t>;
	Thu, 23 Aug 2001 03:29:49 -0400
Date: Thu, 23 Aug 2001 09:29:40 +0200 (MEST)
From: Pozsar Balazs <pozsy@sch.bme.hu>
To: Jordan Breeding <ledzep37@home.com>
cc: Shawn McGovern <shawnm@splorkin.com>, <linux-kernel@vger.kernel.org>
Subject: Re: Shutdown and power off on a multi-processor machine
In-Reply-To: <3B8461E3.14DAC8A7@home.com>
Message-ID: <Pine.GSO.4.30.0108230927440.20823-100000@balu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I had the same problems, and the only way i could have a poweroff at
shutdown was to pass the apm=power-off option to the kernel at boot time.
(e.g. in lilo.conf, have a append="apm=power-off" line.)

Hope that helps,
Balazs Pozsar.

On Wed, 22 Aug 2001, Jordan Breeding wrote:

> I too am having trouble powering off and rebooting an SMP machine.  It
> is a Tyan Tiger 230.  I have tried to report this a few times with
> little to no response.  The last kernel that worked for me in this
> respect was 2.4.6-ac2.  I have tried linus' and alan's kernels both with
> no success.  I have tried configuring all kernel with APM soft-power
> off, real-mode power off (I enable power-off even though the rest of APM
> is broken on SMP), ACPI (multiple setups), and nothing at all.  None of
> these kernel/configuration combos allow me to shutdown or reboot my
> machine.  I would like to be able to and I know the board still works
> because Windows 2000/XP (even though I hate using them) both manage to
> shutdown/reboot the machine properly.  I have everything I can think of
> copiled in statically instead of as modules and also have PNPBIOS enable
> in the kernel and the BIOS.  Any help would be appreciated.
>
> Jordan
>
> Shawn McGovern wrote:
> >
> > I have a need for a headless machine to power off at the end of shutdown,
> > but cannot get it to work for smp kernels. I tried 2.2.14, and 2.4.9,
> > built with smp and apm. If there is a way to make this work, I would
> > really appreciate any advice. If it cannot be done I would sure like to
> > know that too, so I can stop banging my head on this particular wall.
> > Please send responses to me directly as I am not on this list. TIA.
> >
> > Cheers,
> > Shawn
> >
> > -
> > To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > Please read the FAQ at  http://www.tux.org/lkml/
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

pozsy
-- 


