Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265368AbTA1NXe>; Tue, 28 Jan 2003 08:23:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265414AbTA1NXe>; Tue, 28 Jan 2003 08:23:34 -0500
Received: from ns.suse.de ([213.95.15.193]:34570 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id <S265368AbTA1NXd>;
	Tue, 28 Jan 2003 08:23:33 -0500
Date: Tue, 28 Jan 2003 14:32:52 +0100
From: Stefan Reinauer <stepan@suse.de>
To: Robert Morris <rob@r-morris.co.uk>
Cc: Raphael Schmid <Raphael_Schmid@CUBUS.COM>,
       "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: Re: Bootscreen
Message-ID: <20030128133252.GC23296@suse.de>
References: <398E93A81CC5D311901600A0C9F2928946936D@cubuss2> <Pine.LNX.4.44.0301281113480.20283-100000@schubert.rdns.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0301281113480.20283-100000@schubert.rdns.com>
User-Agent: Mutt/1.4i
X-Message-Flag: Life is too short to use a crappy OS.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Robert Morris <rob@r-morris.co.uk> [030128 12:20]:
> There is a very simple reason why Linux shouldn't have a "bootscreen" - 
> its a lame idea. We have copied enough of the bad "features" of Windows et 
> al into Linux already, IMHO.

Then why not make something better instead of denying it completely.
"It's lame" is not a reason. Seeing the same "Oh, I got my name and
copyright visible in this and that driver" every time I boot a system
is about as lame, and the boot messages are far more a try of a hall of
fame than pure system status in a standardized way. Don't get me wrong,
I don't think it's completely wrong, or should be changed generally.
Rather, Linux has been the operating system of free choice, as long as
I can think of it. And this free choice might also mean that people want
some graphics surrounding their boot messages or replace them.

> FWIW, I usually remove the graphics from LILO/GRUB config as installed by 
> default these days.
Which is your perfect right, if you like it that way. But there are
people who think different. Don't call them lame. 

> Most of the machines I maintain are very seldom rebooted, but if someone 
> was to do a reboot, I would want them to be able to observe any errors or 
> other abnormal output from the boot-up process.
A graphical boot does not necessarily hide all kernel messages. Look
at my bootsplash patches how to do it in a technical sane way.
ftp.suse.com/pub/people/stepan/bootsplash/. If you have an embedded
device with a fixed system and non-variable hardware you just don't need
the information from the kernel messages.

> A "bootscreen" makes it 
> more likely that such an error message would be more likely to go 
> unnoticed - and, if they became commonplace, may eventually result in 
> developers making the on-boot output less verbose/informative/etc, on the 
> basis that it isn't likely to be seen in the first place!
Make it configurable, so that everybody can turn it on and off, and
don't turn it on by default. This is done with the fbcon stuff anyways,
which is mandatory for a splash screen. Where's the problem in just not
switching such a function on? 

> The stuff you see on your screen when your Linux installation boots up 
> weren't put there for no reason. Please lets leave them there!
There's always a reason for someone. This does not mean that it's my
reason, too. Microsoft have their reasons as well with their backdoor
politics...

  Stefan

-- 
The use of COBOL cripples the mind; its teaching should, therefore, be
regarded as a criminal offense.                      -- E. W. Dijkstra
