Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129040AbQKFLXO>; Mon, 6 Nov 2000 06:23:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129144AbQKFLXE>; Mon, 6 Nov 2000 06:23:04 -0500
Received: from panic.ohr.gatech.edu ([130.207.47.194]:54539 "EHLO
	havoc.gtf.org") by vger.kernel.org with ESMTP id <S129040AbQKFLW4>;
	Mon, 6 Nov 2000 06:22:56 -0500
Message-ID: <3A0693E9.B4677F4E@mandrakesoft.com>
Date: Mon, 06 Nov 2000 06:20:09 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.0-test10 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: David Woodhouse <dwmw2@infradead.org>
CC: Dan Hollis <goemon@anime.net>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Oliver Xymoron <oxymoron@waste.org>, Keith Owens <kaos@ocs.com.au>,
        linux-kernel@vger.kernel.org
Subject: Re: Persistent module storage [was Linux 2.4 Status / TODO page]
In-Reply-To: <Pine.LNX.4.21.0011060302290.17667-100000@anime.net> <24273.973508761@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Remember the /dev/mixer and /dev/dsp are separate.

* Driver initializes mixer to 100% muted
* Userspace app sets desired values to /dev/mixer
* Userspace app opens /dev/dsp to play sound

I don't see where any sound can "escape" in this scenario, and it
doesn't require any module data persistence...

	Jeff


-- 
Jeff Garzik             | Dinner is ready when
Building 1024           | the smoke alarm goes off.
MandrakeSoft            |	-/usr/games/fortune
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
