Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272181AbRHWBws>; Wed, 22 Aug 2001 21:52:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272182AbRHWBwi>; Wed, 22 Aug 2001 21:52:38 -0400
Received: from c526559-a.rchdsn1.tx.home.com ([24.11.31.247]:61312 "EHLO
	ledzep.dyndns.org") by vger.kernel.org with ESMTP
	id <S272181AbRHWBwc>; Wed, 22 Aug 2001 21:52:32 -0400
Message-ID: <3B8461E3.14DAC8A7@home.com>
Date: Wed, 22 Aug 2001 20:52:35 -0500
From: Jordan Breeding <ledzep37@home.com>
Organization: University of Texas at Dallas - Student
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.8-ac7 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Shawn McGovern <shawnm@splorkin.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Shutdown and power off on a multi-processor machine
In-Reply-To: <5.1.0.14.2.20010822182917.0352fdd8@pop3.splorkin.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I too am having trouble powering off and rebooting an SMP machine.  It
is a Tyan Tiger 230.  I have tried to report this a few times with
little to no response.  The last kernel that worked for me in this
respect was 2.4.6-ac2.  I have tried linus' and alan's kernels both with
no success.  I have tried configuring all kernel with APM soft-power
off, real-mode power off (I enable power-off even though the rest of APM
is broken on SMP), ACPI (multiple setups), and nothing at all.  None of
these kernel/configuration combos allow me to shutdown or reboot my
machine.  I would like to be able to and I know the board still works
because Windows 2000/XP (even though I hate using them) both manage to
shutdown/reboot the machine properly.  I have everything I can think of
copiled in statically instead of as modules and also have PNPBIOS enable
in the kernel and the BIOS.  Any help would be appreciated.

Jordan

Shawn McGovern wrote:
> 
> I have a need for a headless machine to power off at the end of shutdown,
> but cannot get it to work for smp kernels. I tried 2.2.14, and 2.4.9,
> built with smp and apm. If there is a way to make this work, I would
> really appreciate any advice. If it cannot be done I would sure like to
> know that too, so I can stop banging my head on this particular wall.
> Please send responses to me directly as I am not on this list. TIA.
> 
> Cheers,
> Shawn
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
