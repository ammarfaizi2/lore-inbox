Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312833AbSCVUZ1>; Fri, 22 Mar 2002 15:25:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312834AbSCVUZM>; Fri, 22 Mar 2002 15:25:12 -0500
Received: from [195.39.17.254] ([195.39.17.254]:57219 "EHLO Elf.ucw.cz")
	by vger.kernel.org with ESMTP id <S312833AbSCVUY5>;
	Fri, 22 Mar 2002 15:24:57 -0500
Date: Fri, 22 Mar 2002 15:47:11 +0000
From: Pavel Machek <pavel@suse.cz>
To: Arjan van de Ven <arjanv@redhat.com>
Cc: Linus Torvalds <torvalds@transmeta.com>,
        Jeff Garzik <jgarzik@mandrakesoft.com>,
        Anders Gustafsson <andersg@0x63.nu>, linux-kernel@vger.kernel.org,
        mochel@osdl.org
Subject: Re: [PATCH] devexit fixes in i82092.c
Message-ID: <20020322154710.F37@toy.ucw.cz>
In-Reply-To: <3C92AD1F.30909@mandrakesoft.com> <Pine.LNX.4.33.0203152339200.31551-100000@penguin.transmeta.com> <20020316044053.A11660@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > Ideally we should, yes. Although if we really turn off power, it doesn't 
> > much matter.
> 
> It kind of does for warm reboots. I'm getting more and more reports that
> on warm reboot, the bios then can't boot again because we left some
> hardware (usually the scsi or ide controller) in a state the bios didn't expect.

Actually, on omnibook xe3, linux will not come up after warm boot, because it
leaves soundcard in too bad state :-(.
									Pavel
-- 
Philips Velo 1: 1"x4"x8", 300gram, 60, 12MB, 40bogomips, linux, mutt,
details at http://atrey.karlin.mff.cuni.cz/~pavel/velo/index.html.

