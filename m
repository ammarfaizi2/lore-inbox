Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262645AbVBEJgh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262645AbVBEJgh (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Feb 2005 04:36:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264555AbVBEJgg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Feb 2005 04:36:36 -0500
Received: from gprs214-76.eurotel.cz ([160.218.214.76]:24466 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S262645AbVBEJgH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Feb 2005 04:36:07 -0500
Date: Sat, 5 Feb 2005 10:35:50 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Jon Smirl <jonsmirl@gmail.com>
Cc: ncunningham@linuxmail.org,
       Carl-Daniel Hailfinger <c-d.hailfinger.devel.2005@gmx.net>,
       ACPI List <acpi-devel@lists.sourceforge.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] Reliable video POSTing on resume (was: Re: [ACPI] Samsung P35, S3, black screen (radeon))
Message-ID: <20050205093550.GC1158@elf.ucw.cz>
References: <e796392205020221387d4d8562@mail.gmail.com> <420217DB.709@gmx.net> <4202A972.1070003@gmx.net> <20050203225410.GB1110@elf.ucw.cz> <1107474198.5727.9.camel@desktop.cunninghams> <4202DF7B.2000506@gmx.net> <1107485504.5727.35.camel@desktop.cunninghams> <9e4733910502032318460f2c0c@mail.gmail.com> <20050204074454.GB1086@elf.ucw.cz> <9e473391050204093837bc50d3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9e473391050204093837bc50d3@mail.gmail.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > We already try to do that, but it hangs on 70% of machines. See
> > Documentation/power/video.txt.
> 
> We know that all of these ROMs are run at power on so they have to
> work. This implies that there must be something wrong with the
> environment the ROM are being run in. Video ROMs make calls into the
> INT vectors of the system BIOS. If these haven't been set up yet
> running the VBIOS is sure to hang.  Has someone with ROM source and
> the appropriate debugging tools tried to debug one of these hangs?
> Alternatively code could be added to wakeup.S to try and set these up
> or dump the ones that are there and see if they are sane.

Rumors say that notebooks no longer have video bios at C000h:0; rumors
say that video BIOS on notebooks is simply integrated into main system
BIOS. I personaly do not know if rumors are true, but PCs are ugly
machines....
								Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
