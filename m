Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129134AbRBFPDB>; Tue, 6 Feb 2001 10:03:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129172AbRBFPCv>; Tue, 6 Feb 2001 10:02:51 -0500
Received: from ns.sysgo.de ([213.68.67.98]:53749 "EHLO rob.devdep.sysgo.de")
	by vger.kernel.org with ESMTP id <S129134AbRBFPCr>;
	Tue, 6 Feb 2001 10:02:47 -0500
From: Robert Kaiser <rob@sysgo.de>
Reply-To: rob@sysgo.de
To: Pavel Machek <pavel@suse.cz>
Subject: Re: Disk is cheap?
Date: Tue, 6 Feb 2001 15:49:30 +0100
X-Mailer: KMail [version 1.0.28]
Content-Type: text/plain; charset=US-ASCII
In-Reply-To: <01013114393200.01502@rob> <200101311612.RAA02360@rob.devdep.sysgo.de> <20010203135518.A1203@bug.ucw.cz>
In-Reply-To: <20010203135518.A1203@bug.ucw.cz>
Cc: Patrizio Bruno <patrizio@dada.it>, linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-Id: <01020616023400.03941@rob>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sam, 03 Feb 2001 you wrote:
> > Usually most of the startup time is spent by the BIOS doing
> > extensive self-test stuff and for firing up services (http,
> > inetd, sendmail, ...) that many embedded systems have little use
> > for.
> 
> Actually, most of that time is spent running bash/sleep 1. Startup
> scripts tend to be poorly designed.

Yes!

> > I have a 25MHz 386EX (~2.2 Bogomips) here that boots Linux out of ROM
> > in roughly 30 seconds. Most of _that_ time however is spent decompressing
> > the kernel.
> 
> You might want to set up XIP and run kernel directly off the ROM...
> 

Hmm, that board has only 512KB ROM. I can fit a minimal Linux kernel
and root-FS in that, but only if it's compressed. ROM, in my experience,
is more expensive than RAM, so it often makes sense to save ROM space
even at the expense of using a little more RAM.

But I'm curious: is there a simple procedure to set up a linux Kernel
to execute from ROM ?


----------------------------------------------------------------
Robert Kaiser                         email: rkaiser@sysgo.de
SYSGO RTS GmbH
Am Pfaffenstein 14                    phone: (49) 6136 9948-762
D-55270 Klein-Winternheim / Germany   fax:   (49) 6136 9948-10
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
