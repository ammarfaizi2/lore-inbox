Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266643AbSKLRft>; Tue, 12 Nov 2002 12:35:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266645AbSKLRft>; Tue, 12 Nov 2002 12:35:49 -0500
Received: from [195.39.17.254] ([195.39.17.254]:9988 "EHLO Elf.ucw.cz")
	by vger.kernel.org with ESMTP id <S266643AbSKLRfr>;
	Tue, 12 Nov 2002 12:35:47 -0500
Date: Tue, 12 Nov 2002 18:42:08 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: "Heusden van, FJJ   (Folkert)" <F.J.J.Heusden@rn.rabobank.nl>,
       Roy Sigurd Karlsbakk <roy@karlsbakk.net>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: random PID patch
Message-ID: <20021112174207.GB187@elf.ucw.cz>
References: <11D18E6D1073547-1319@_rabobank.nl_> <1037020203.2919.26.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1037020203.2919.26.camel@irongate.swansea.linux.org.uk>
User-Agent: Mutt/1.4i
X-Warning: Reading this can be dangerous to your mental health.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > Sometimes, (well; frequently) programs that create temporary
> > files let the filename depend on their PID. A hacker could use
> > that knowledge. So if you know that the application that
> 
> Still can if its random. The attacker can be the one who exec's the
> vulnerable app. The attacker can use dnotify
> 
> > things it's not supposed to. Like forcing suid apps to create
> > a file in the startup-scripts dir. or something.
> 
> Just use namespaces and give every login their own /tmp

Use namespaces? I thought export TMPDIR= was the solution ;-).

							Pavel
-- 
When do you have heart between your knees?
