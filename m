Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262499AbRENVUw>; Mon, 14 May 2001 17:20:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262501AbRENVUm>; Mon, 14 May 2001 17:20:42 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:60681 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S262499AbRENVUc>; Mon, 14 May 2001 17:20:32 -0400
Subject: Re: LANANA: To Pending Device Number Registrants
To: torvalds@transmeta.com (Linus Torvalds)
Date: Mon, 14 May 2001 22:16:43 +0100 (BST)
Cc: jgarzik@mandrakesoft.com (Jeff Garzik),
        alan@lxorguk.ukuu.org.uk (Alan Cox),
        hpa@transmeta.com (H. Peter Anvin),
        linux-kernel@vger.kernel.org (Linux Kernel Mailing List),
        viro@math.psu.edu
In-Reply-To: <Pine.LNX.4.31.0105141328020.22874-100000@penguin.transmeta.com> from "Linus Torvalds" at May 14, 2001 01:29:51 PM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14zPhr-0001RP-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Big device numbers are _not_ a solution. I will accept a 32-bit one, but
> no more, and I will _not_ accept a "manage by hand" approach any more. The
> time has long since come to say "No". Which I've done. If you can't make
> it manage the thing automatically with a script, you won't get a hardcoded
> major device number just because you're lazy.

And on that issue I'm so convinced you are wrong I'm prepared to maintain
sensible Unix device behaviour in the -ac pretty much indefinitely.

> End of discussion.

And that is precisely why ....


Abstract device file systems are beautiful concepts but they don't solve
the device name space problem and they introduce hideous incompatibilities
with existing software. Plan 9 is beautiful. It has a userbase approximately
the size of Linux 0.12 - because it is not compatible.

Alan

