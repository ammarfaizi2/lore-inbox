Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281009AbRLBQa6>; Sun, 2 Dec 2001 11:30:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280814AbRLBQau>; Sun, 2 Dec 2001 11:30:50 -0500
Received: from [195.63.194.11] ([195.63.194.11]:11020 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S280971AbRLBQan>; Sun, 2 Dec 2001 11:30:43 -0500
Message-ID: <3C0A547B.6BF0B13F@evision-ventures.com>
Date: Sun, 02 Dec 2001 17:19:07 +0100
From: Martin Dalecki <dalecki@evision-ventures.com>
Reply-To: dalecki@evision.ag
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.7-10 i686)
X-Accept-Language: en, de
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: Andrew Morton <akpm@zip.com.au>, Davide Libenzi <davidel@xmailserver.org>,
        Larry McVoy <lm@bitmover.com>,
        Daniel Phillips <phillips@bonn-fries.net>,
        Henning Schmiedehausen <hps@intermeta.de>,
        Jeff Garzik <jgarzik@mandrakesoft.com>, linux-kernel@vger.kernel.org
Subject: Re: Linux/Pro [was Re: Coding style - a non-issue]
In-Reply-To: <E16A71v-0006h9-00@the-village.bc.nu>
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> Another thing for 2.5 is going to be to weed out the unused and unmaintained
> drivers, and either someone fixes them or they go down the comsic toilet and
> we pull the flush handle before 2.6 comes out.
> 
> Thankfully the scsi layer breakage is going to help no end in the area of
> clockwork 8 bit scsi controllers, which is major culprit number 1. number 2
> is probably the audio which is hopefully going to go away with ALSA based
> code.

Please consider the following wipe out candidates as well:

1. ftape <- it should really really go away
2. proprietary CD-ROM
3. xd.c (ridiculous isn't it?)
4. old ide driver...
5. old directory reading syscalls.
