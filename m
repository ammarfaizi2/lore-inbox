Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312442AbSDNT23>; Sun, 14 Apr 2002 15:28:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312443AbSDNT22>; Sun, 14 Apr 2002 15:28:28 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:26888 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S312442AbSDNT22>; Sun, 14 Apr 2002 15:28:28 -0400
Date: Sun, 14 Apr 2002 21:28:29 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Jerry Sievert <jerry@osdl.org>
Cc: kernel list <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4.19pre5-ac3 swsusp panic
Message-ID: <20020414192829.GD2341@atrey.karlin.mff.cuni.cz>
In-Reply-To: <200204060109.g36199g10373@devserv.devel.redhat.com> <1018114652.7477.2.camel@psuedomode> <1018116297.7477.21.camel@psuedomode> <20020407095844.GA216@elf.ucw.cz> <1018546314.32748.9.camel@caffeine.pdx.osdl.net> <20020412074948.GA26389@atrey.karlin.mff.cuni.cz> <1018626124.2078.16.camel@caffeine.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> i finally found it, thank you ;-)
> 
> suspend worked great, restore had some issues, though ... X didn't come
> back correctly, and after going to console 7 (X), the machine ended up
> freezing up ... no OOPS tho, which was odd ... i didn't try to diagnose
> the problem, just powered off and decided to go back to my
> non-suspending kernel ...

Always suspend when normal console (not X) is active. That should work
better.
							Pavel
-- 
Casualities in World Trade Center: ~3k dead inside the building,
cryptography in U.S.A. and free speech in Czech Republic.
