Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132220AbRDJVZC>; Tue, 10 Apr 2001 17:25:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132224AbRDJVYm>; Tue, 10 Apr 2001 17:24:42 -0400
Received: from [204.163.170.2] ([204.163.170.2]:20460 "EHLO umail.unify.com")
	by vger.kernel.org with ESMTP id <S132220AbRDJVYg>;
	Tue, 10 Apr 2001 17:24:36 -0400
Message-ID: <419E5D46960FD211A2D5006008CAC79902E5C1A7@pcmailsrv1.sac.unify.com>
From: "Manuel A. McLure" <mmt@unify.com>
To: "'Jeff Garzik'" <jgarzik@mandrakesoft.com>
Cc: linux-kernel@vger.kernel.org
Subject: RE: Still IRQ routing problems with VIA
Date: Tue, 10 Apr 2001 14:24:27 -0700
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2650.21)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > I do have an IRQ for my VGA since the instructions for my 
> card (a Voodoo 5
> > 5500) specifically say an IRQ is needed.
> 
> I wonder though... In my mind this is a driver not hardware issue.  If
> the XFree86 and/or Linux console driver do not use the IRQ, 
> you need not
> have BIOS assign one.  If you are feeling dangerous, try 
> turning the VGA
> IRQ assignment off in BIOS and see if things melt/explode/kick ass.

I'd do that if this wasn't also my Windows 98 gaming machine - I'm supposing
that the Windows drivers do use the IRQ even if XFree86/Linux doesn't. I
dunno if Windows is smart enough to assign an IRQ even if the BIOS doesn't.
Anyway, things are working now (specially since the last tulip patches) and
I like it that way :-)

--
Manuel A. McLure - Unify Corp. Technical Support <mmt@unify.com>
Space Ghost: "Hey, what happened to the-?" Moltar: "It's out." SG: "What
about-?" M: "It's fixed." SG: "Eh, good. Good."
