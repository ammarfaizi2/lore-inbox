Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262457AbVBDHui@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262457AbVBDHui (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Feb 2005 02:50:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263373AbVBDHqg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Feb 2005 02:46:36 -0500
Received: from gprs215-248.eurotel.cz ([160.218.215.248]:21395 "EHLO
	amd.ucw.cz") by vger.kernel.org with ESMTP id S263098AbVBDHpL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Feb 2005 02:45:11 -0500
Date: Fri, 4 Feb 2005 08:44:54 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Jon Smirl <jonsmirl@gmail.com>
Cc: ncunningham@linuxmail.org,
       Carl-Daniel Hailfinger <c-d.hailfinger.devel.2005@gmx.net>,
       ACPI List <acpi-devel@lists.sourceforge.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] Reliable video POSTing on resume (was: Re: [ACPI] Samsung P35, S3, black screen (radeon))
Message-ID: <20050204074454.GB1086@elf.ucw.cz>
References: <20050122134205.GA9354@wsc-gmbh.de> <4201825B.2090703@gmx.net> <e796392205020221387d4d8562@mail.gmail.com> <420217DB.709@gmx.net> <4202A972.1070003@gmx.net> <20050203225410.GB1110@elf.ucw.cz> <1107474198.5727.9.camel@desktop.cunninghams> <4202DF7B.2000506@gmx.net> <1107485504.5727.35.camel@desktop.cunninghams> <9e4733910502032318460f2c0c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9e4733910502032318460f2c0c@mail.gmail.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > User has triggered resume
> > > run wakeup.S
> 
> wakeup.S runs in real mode. Why can't it just call the VBIOS at
> C000:0003 to reset the hardware before setting the mode?

We already try to do that, but it hangs on 70% of machines. See
Documentation/power/video.txt.
								Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
