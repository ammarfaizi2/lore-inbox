Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265957AbRFZJJv>; Tue, 26 Jun 2001 05:09:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265958AbRFZJJc>; Tue, 26 Jun 2001 05:09:32 -0400
Received: from Expansa.sns.it ([192.167.206.189]:27405 "EHLO Expansa.sns.it")
	by vger.kernel.org with ESMTP id <S265957AbRFZJJZ>;
	Tue, 26 Jun 2001 05:09:25 -0400
Date: Tue, 26 Jun 2001 11:09:22 +0200 (CEST)
From: Luigi Genoni <kernel@Expansa.sns.it>
To: Thomas Foerster <puckwork@madz.net>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: AMD thunderbird oops
In-Reply-To: <20010626082928Z265948-17720+7692@vger.kernel.org>
Message-ID: <Pine.LNX.4.33.0106261102060.9537-100000@Expansa.sns.it>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I went trought 8 Athlon, (latest 1300 Mhz 200Mhz FSB).

Usually those stability problems are related to power supply (it should
be at less 300 Watt).
If the power supply does not give enought Ampere, and the energy
is fluttuant, the Athlon cpu really suffers.

I usually do a little overvolt of the vcore to 3.4, and this makes things
more stable. For what i know, the Athlon optimizzation does stress
the memory I/O at best, and does use the Athlon FSB with all its power.

Using the pentiumII/III stuff, you loose this memory performance boost.

If a little overvolt of the VCORE does not solve the things,
(someone also does a little overvolt of the CPU core to 1.78)
then check if your power supply if working well, and the signal strenght
setting inside of your bios (should be 2).

This is just my experience with Athlon processors.

Luigi


On Tue, 26 Jun 2001, Thomas Foerster wrote:

> Hi,
>
> > as i've said before - i have the same problem too
>
> Me too
>
> > the memory is OK! - have run memtest86 for hours ... - no errors ... -
> > heatsink - CPU@45°C - Case @ 25°C
>
> > after changing the kernel compile to PentiumII (nearly) everything worked
> > fine ....
>
> I HAD a Asus K7M with a 650 MHz Athlon, 256 MB RAM (Infineon, Ram is OK).
> Using 2.4.2 AND 2.4.4 didn't work.
> Whenever i started KDE2, the crashes startet, even oopses in ext2-code appeared.
>
> The strange thing is : If i startet KDE2 as root, the crashes didn't happen!
>
> I don't know why, my distribution is RedHat 7.1
>
> Now i have a Epox 8kta3+ with an 1,333 MHz Athlon, FSB266, 256 MB RAM (Infineon)
> and the crashes still appear.
>
> Changing the Kernel from Athlon to Pentium-II/III makes the system stable again.
>
> Thomas
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

