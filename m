Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313036AbSC0PgL>; Wed, 27 Mar 2002 10:36:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313037AbSC0PgB>; Wed, 27 Mar 2002 10:36:01 -0500
Received: from ardbeg.madscilab.com ([213.136.48.97]:57013 "EHLO
	hermes.madsci.se") by vger.kernel.org with ESMTP id <S313036AbSC0Pfw>;
	Wed, 27 Mar 2002 10:35:52 -0500
Date: Wed, 27 Mar 2002 16:35:37 +0100 (CET)
From: Adam Johansson <macadam@madsci.se>
X-X-Sender: <macadam@macadam.madscilab.com>
To: Bernd Schubert <bernd-schubert@web.de>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: time jumps
In-Reply-To: <200203271528.g2RFSZM10812@fubini.pci.uni-heidelberg.de>
Message-ID: <Pine.LNX.4.33.0203271633080.16292-100000@macadam.madscilab.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 27 Mar 2002, Bernd Schubert wrote:

> Hi,
>
> we have a computer here, that behaves very strange, from one second to
> another the clock changes to about 1h in the future. In the next "real"
> second the time is normal again.
> Well, I first thought that is might be a X problem, but after running a loop
> over "date", it really seems that the system clock is affected.  Then I
> thought it might be a conflict with the hardware clock, but after resetting
> it to the system time, the problem was still there.
>
> The only clock that doesn't seem to be affected is the realtime clock (at
> least not when doing a loop of cat over the proc-file).
>
> The problem is, that this time jumps cause the Xserver to enable its
> screensaver (and several other small problems).
>
> System  is: Athlon 650 on VIA board with linux-2.4.17 (unpatched)
>

The same thing happened to me on an Athlon 600 on a KM133 chipset.
I ran a vanilla 2.4.18 and after upgrading to 2.4.19 the problem never
occured again.

Hope it helps for you to!

Cheers!
/Adam @ MadSci.se

> So has anyone an idea what to do, I'm thinking about a BIOS update (but don't
> really believe that it will help). Or is it possible to patch the kernel that
> it uses the realtime clock (could anyone of you send me this patch, if it is
> possible, please??).
>
>
> Of course, I can give further information, if needed.
>
> Thanks in advance, Bernd
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

-=-=-=-=-=-=-=-=-=-=-=-=-
Adam Johansson
Developer @ MadSci AB
Phone: +46 (0)18 606462
ICQ: 58187935
http://www.madsci.se
-=-=-=-=-=-=-=-=-=-=-=-=-

