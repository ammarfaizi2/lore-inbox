Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289901AbSBXQ45>; Sun, 24 Feb 2002 11:56:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289954AbSBXQ4r>; Sun, 24 Feb 2002 11:56:47 -0500
Received: from faui02.informatik.uni-erlangen.de ([131.188.30.102]:30930 "EHLO
	faui02.informatik.uni-erlangen.de") by vger.kernel.org with ESMTP
	id <S289901AbSBXQ4b>; Sun, 24 Feb 2002 11:56:31 -0500
Date: Sun, 24 Feb 2002 17:56:27 +0100 (MET)
From: Thomas Glanzmann <sithglan@stud.uni-erlangen.de>
X-X-Sender: sithglan@faui02.informatik.uni-erlangen.de
To: Otto Wyss <otto.wyss@bluewin.ch>
cc: linux-kernel@vger.kernel.org
Subject: Re: Kernel panic: Loop 1 (aic7xxx driver)
In-Reply-To: <3C79198D.B4161A96@bluewin.ch>
Message-ID: <Pine.GSO.4.44.0202241755030.23901-100000@faui02.informatik.uni-erlangen.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The easiest way is to use a serial console. Maybe you should have a look at
http://kgdb.sourceforge.net/, too.

Greetings,
		 Thomas

On Sun, 24 Feb 2002, Otto Wyss wrote:

> Since kernel version 2.4.9 I haven't compiled a kernel until recently. With
> 2.4.17 I always got the "Kernel panic: Loop 1" from the aic7xxx driver. When I
> removed this driver the kernel started correctly. My research on the net showed
> that "Gregoire Favre (Kernel panic: Loop 1 (aic7xxx under 2.4.13-ac[246]))" has
> the same problem as I and his report is almost exactly as mine. I won't write
> mine here since I don't know how to save it into a file, anything is lost after
> the hard reset (does anybody know how to save/retrieve kernel messages after a panic?).
>
> Well but I can give a hint where to look for since the problem disappears when I
> compile the aic7xxx driver into the kernel. If (with make menuconfig) the option
> "SCSI support" and the low level driver "Adaptec aic7xxx support" is set to "M"
> the problem occurs. It occurs only if the option _"SCSI support"_ is set to "M".
> I guess only very few people use this option.
>
> O. Wyss
>
> --
> Author of "Debian partial mirror synch script"
> ("http://dpartialmirror.sourceforge.net/")
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

