Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130462AbQKRS5w>; Sat, 18 Nov 2000 13:57:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130540AbQKRS5m>; Sat, 18 Nov 2000 13:57:42 -0500
Received: from Hell.WH8.TU-Dresden.De ([141.30.225.3]:14865 "EHLO
	Hell.WH8.TU-Dresden.De") by vger.kernel.org with ESMTP
	id <S130462AbQKRS5d>; Sat, 18 Nov 2000 13:57:33 -0500
Message-ID: <3A16CA08.AD4E6433@Hell.WH8.TU-Dresden.De>
Date: Sat, 18 Nov 2000 19:27:21 +0100
From: "Udo A. Steinberg" <sorisor@Hell.WH8.TU-Dresden.De>
Organization: Dept. Of Computer Science, Dresden University Of Technology
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.0-test11 i686)
X-Accept-Language: en, de-DE
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Freeze on FPU exception with Athlon
In-Reply-To: <Pine.LNX.4.10.10011181002190.1655-100000@cesium.transmeta.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:

> > Compiler specific ?
> 
> There's almost certainly more than that. I'd love to have a report on my
> asm-only version, but even so I suspect it also requires the 3dnow stuff,
> because I'm not able to trigger anything like this on any machines I have
> access to (none of them are AMD, though)
> 

Hmm...

Linus, I've tried your latest asm-version with my Thunderbird, egcs-1.1.2
and 3dnow support compiled in. Several runs show no problems - the program
runs and terminates gracefully.

-Udo.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
