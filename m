Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314885AbSEHScR>; Wed, 8 May 2002 14:32:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314889AbSEHScQ>; Wed, 8 May 2002 14:32:16 -0400
Received: from mole.bio.cam.ac.uk ([131.111.36.9]:60683 "EHLO
	mole.bio.cam.ac.uk") by vger.kernel.org with ESMTP
	id <S314885AbSEHScO>; Wed, 8 May 2002 14:32:14 -0400
Message-Id: <5.1.0.14.2.20020508192557.0409b1f0@pop.cus.cam.ac.uk>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Wed, 08 May 2002 19:29:55 +0100
To: Martin Dalecki <dalecki@evision-ventures.com>
From: Anton Altaparmakov <aia21@cantab.net>
Subject: Re: [PATCH] IDE 58
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Bjorn Wesen <bjorn.wesen@axis.com>, Paul Mackerras <paulus@samba.org>,
        Linus Torvalds <torvalds@transmeta.com>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <3CD8FCFF.2080008@evision-ventures.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 11:25 08/05/02, Martin Dalecki wrote:
>Terminology in 2.5:
>We have a host chip set or shortly a host chip. This is implementing the
>ATA interface on the side of the motherboard.
>The host chip is providing two channels. A primary and a secondary
>one. To a channel we can attach two devices, however we use the term
>drive instead in code becouse the termi device is quite overloaded with
>meaning already. The devices are enumerated as units. That's it.
>Far more natural then hwif hwgrp and so on. IDE is the Integrated Device
>Electronic - the microcontroller stuff I don't care that much about.

</me ignorant>Um, what about the IDE PCI cards which have 4 channels on 
them? Like these two:

Adaptec 2400 4Ch IDE Raid Controller
RocketRaid 404 4Ch ATA133 Raid Host Adaptor

Best regards,

         Anton

ps Sorry about the outburst yesterday, I was tired and just flipped...


-- 
   "I've not lost my mind. It's backed up on tape somewhere." - Unknown
-- 
Anton Altaparmakov <aia21 at cantab.net> (replace at with @)
Linux NTFS Maintainer / IRC: #ntfs on irc.openprojects.net
WWW: http://linux-ntfs.sf.net/ & http://www-stu.christs.cam.ac.uk/~aia21/

