Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279912AbRKRRAu>; Sun, 18 Nov 2001 12:00:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279903AbRKRRAk>; Sun, 18 Nov 2001 12:00:40 -0500
Received: from marao.utad.pt ([193.136.40.3]:11527 "EHLO marao.utad.pt")
	by vger.kernel.org with ESMTP id <S279912AbRKRRAc>;
	Sun, 18 Nov 2001 12:00:32 -0500
Subject: Re: Re[2]: kernel 2.4.14 breaks NVIDIA-1.0-1541 console switching
From: Alvaro Lopes <alvieboy@alvie.com>
To: Matt Cahill <m-cahill@home.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <1962142807.20011118114226@home.com>
In-Reply-To: <200111171745.fAHHjnZ02112@mnlpc.dtro.e-technik.tu-darmstadt.de>
	<1006100978.891.4.camel@dwarf>  <1962142807.20011118114226@home.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.99.0 (Preview Release)
Date: 18 Nov 2001 16:55:40 +0000
Message-Id: <1006102541.891.6.camel@dwarf>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Dom, 2001-11-18 at 16:42, Matt Cahill wrote:
> 
>   I actually just upgraded to 2.4.13 and have been experiencing this
>   problem also. I get 'Waiting for X server to shutdown', forcing me
>   to reboot. I reloaded the Nvidia kernel again (no problems with
>   that), but the GLX driver is coughing and spitting when I try to
>   reinstall it. It can't seem to find or read
>   /usr/X11R6/lib/module/nvdriver.o (filename may be a little
>   different...sorry, I'm in Windows right now), but it's there. This
>   is also nvidia version 1541 (latest stable).
> 
> AL> Well I have the same kind of problem. But you don't have to shutdown!
> AL> Just switch again to your X vt, and X should work again.
> 
>   I'm not sure I follow this... how do I switch to an X vt, and how do
>   you mean 'X should work again'? Just curious if you meant this as a fix or
>   a work-around.

First of all this problems seem to be fixed in 2.4.15-pre5 with Nicholas
Aspert i8xx AGP patch. (one or another or both are responsable - didn't
test :) )

This is a work-around of course. Try CTRL+ALT+F7 (vt07 is the default XT
vt). 
BTW. what do you mean by "Waiting for X server to shutdown" ? Does this
appear when you reboot or when you switch consoles ?

Alvie

> 
>   Thanks for any info,
> 
>   Matt Cahill
> m-cahill@home.com
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/


