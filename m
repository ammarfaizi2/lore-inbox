Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261454AbREOU2s>; Tue, 15 May 2001 16:28:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261452AbREOU2a>; Tue, 15 May 2001 16:28:30 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:25363 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S261451AbREOU1Q>; Tue, 15 May 2001 16:27:16 -0400
Subject: Re: LANANA: To Pending Device Number Registrants
To: torvalds@transmeta.com (Linus Torvalds)
Date: Tue, 15 May 2001 21:23:20 +0100 (BST)
Cc: jsimmons@transvirtual.com (James Simmons),
        jgarzik@mandrakesoft.com (Jeff Garzik),
        alan@lxorguk.ukuu.org.uk (Alan Cox),
        neilb@cse.unsw.edu.au (Neil Brown), hpa@transmeta.com (H. Peter Anvin),
        linux-kernel@vger.kernel.org (Linux Kernel Mailing List),
        viro@math.psu.edu
In-Reply-To: <Pine.LNX.4.21.0105151031320.2112-100000@penguin.transmeta.com> from "Linus Torvalds" at May 15, 2001 10:43:18 AM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14zlLk-0002yl-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> And my opinion is that the "hot-plugged" approach works for devices even
> if they are soldered down - the "plugging" event just always happens
> before the OS is booted, and people just don't unplug it. So we might as

This is true on one condition. That you can ask the device what it is,
what it does and to an extent where it is and how you get to it.

Right now thyats much of what majors is about -but I still believe this is 
2.5 stuff

> show up in /dev, and everywhere else it is needed. And the logical
> extension of such a setup is to consider built-in devices to be plugged in
> at bootup.

Agreed

> [ The biggest silliness is this "let's try to make the disks appear in the
>   same order that the BIOS probes them". Now THAT is really stupid, and it
>   goes on a lot more than I'd ever like to see. ]

RIght - Lilo needs to know but nobody else should except when they need to ask
eg to find which disk failed
