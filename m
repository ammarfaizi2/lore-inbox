Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129033AbRBHCmQ>; Wed, 7 Feb 2001 21:42:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129317AbRBHCmG>; Wed, 7 Feb 2001 21:42:06 -0500
Received: from Hell.WH8.TU-Dresden.De ([141.30.225.3]:41746 "EHLO
	Hell.WH8.TU-Dresden.De") by vger.kernel.org with ESMTP
	id <S129033AbRBHCl6>; Wed, 7 Feb 2001 21:41:58 -0500
Message-ID: <3A82158B.1D20F720@Hell.WH8.TU-Dresden.De>
Date: Thu, 08 Feb 2001 04:42:03 +0100
From: "Udo A. Steinberg" <sorisor@Hell.WH8.TU-Dresden.De>
Organization: Dept. Of Computer Science, Dresden University Of Technology
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.1-ac5 i686)
X-Accept-Language: en, de-DE
MIME-Version: 1.0
To: Linux Kernel <linux-kernel@vger.kernel.org>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: PS/2 Mouse/Keyboard conflict and lockup
In-Reply-To: <3A8205D4.7C7E358E@Hell.WH8.TU-Dresden.De>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Udo A. Steinberg" wrote:
> 
> I'm not sure whether this is related to the ominous ps/2 mouse bug
> you have been chasing, but this problem is 100% reproducible and
> very annoying.
> 
> After upgrading my Asus A7V Bios from 1003 to 1005D, gpm no longer
> receives any mouse events and the mouse doesn't work in text
> consoles. Once I kill gpm and restart gpm -t ps2 the keyboard
> locks up.

Alright, I found the culprit - ACPI. Once I had compiled the kernel
without it, all the problems mysteriously vanished. I knew there was
a reason it was marked 'Experimental' :)

Sorry for the noise.

-Udo.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
