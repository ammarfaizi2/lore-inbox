Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129353AbQKFN4N>; Mon, 6 Nov 2000 08:56:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129339AbQKFN4E>; Mon, 6 Nov 2000 08:56:04 -0500
Received: from ns2.Deuroconsult.ro ([193.226.167.164]:8452 "EHLO
	marte.Deuroconsult.ro") by vger.kernel.org with ESMTP
	id <S129215AbQKFNzx>; Mon, 6 Nov 2000 08:55:53 -0500
Date: Mon, 6 Nov 2000 15:55:41 +0200 (EET)
From: Catalin BOIE <util@deuroconsult.ro>
To: linux-kernel@vger.kernel.org
cc: linux-admin@vger.kernel.org
Subject: Kernel hook for open
Message-ID: <Pine.LNX.4.20.0011061547590.1080-100000@marte.Deuroconsult.ro>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, guys!

I wish to know if there is something like a kernel hook for open function.
I want to monitor a file (someting like watchdog on Solaris) and to read
from my own process (module?) and from the file.

I tried with LD_SO_PRELOAD but it haven't any effect on the so libraries.
For example:
If I use function getpwent (that is in a so library) and my home
made .so library that overwrite "open" function and is in
/etc/ld.so.preload file it doesn't work.
Of course, if I use open ("/etc/hosts") the so library execute my
function. 

If it doesn't exist will be nice to have something like this.

Thanks in advance!

---
Catalin(ux) BOIE
catab@deuroconsult.ro
A new Linux distribution: http://l13plus.deuroconsult.ro
http://www2.deuroconsult.ro/~catab

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
