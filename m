Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312466AbSCUT5n>; Thu, 21 Mar 2002 14:57:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312467AbSCUT5e>; Thu, 21 Mar 2002 14:57:34 -0500
Received: from [195.39.17.254] ([195.39.17.254]:32131 "EHLO Elf.ucw.cz")
	by vger.kernel.org with ESMTP id <S312466AbSCUT5T>;
	Thu, 21 Mar 2002 14:57:19 -0500
Date: Thu, 21 Mar 2002 15:12:03 +0000
From: Pavel Machek <pavel@suse.cz>
To: Dave Jones <davej@suse.de>, Linus Torvalds <torvalds@transmeta.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Jeff Garzik <jgarzik@mandrakesoft.com>,
        Anders Gustafsson <andersg@0x63.nu>, arjanv@redhat.com,
        linux-kernel@vger.kernel.org, mochel@osdl.org
Subject: Re: [PATCH] devexit fixes in i82092.c
Message-ID: <20020321151203.I37@toy.ucw.cz>
In-Reply-To: <E16mMer-0007Q4-00@the-village.bc.nu> <Pine.LNX.4.33.0203161421240.8278-100000@home.transmeta.com> <20020317001533.E15296@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

>  This makes sense for a shutdown, and suspend-to-disk, but not for
>  a reboot imo (senseless spinning down/up of drives).
>  So some means is probably going to be needed for drivers to
>  distinguish between a reboot & shutdown/suspend.

I'd guess 'suspend' callback would handle this, and suspend already has
"state we want to enter" as a parameter.
								Pavel
-- 
Philips Velo 1: 1"x4"x8", 300gram, 60, 12MB, 40bogomips, linux, mutt,
details at http://atrey.karlin.mff.cuni.cz/~pavel/velo/index.html.

