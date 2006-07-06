Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965105AbWGFBMm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965105AbWGFBMm (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Jul 2006 21:12:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965109AbWGFBMm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Jul 2006 21:12:42 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:404 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S965105AbWGFBMl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Jul 2006 21:12:41 -0400
Date: Thu, 6 Jul 2006 03:12:22 +0200
From: Pavel Machek <pavel@suse.cz>
To: Henrique de Moraes Holschuh <hmh@debian.org>
Cc: Vojtech Pavlik <vojtech@suse.cz>, lm-sensors@lm-sensors.org,
       linux-kernel@vger.kernel.org, hdaps-devel@lists.sourceforge.net,
       Stelian Pop <stelian@popies.net>,
       Michael Hanselmann <linux-kernel@hansmi.ch>
Subject: Re: Generic interface for accelerometers (AMS, HDAPS, ...)
Message-ID: <20060706011222.GA5303@elf.ucw.cz>
References: <20060703124823.GA18821@khazad-dum.debian.net> <20060704075950.GA13073@elf.ucw.cz> <20060704162346.GE9447@khazad-dum.debian.net> <20060704235717.GD11872@elf.ucw.cz> <20060705073455.GA6027@suse.cz> <20060705135816.GA8452@khazad-dum.debian.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060705135816.GA8452@khazad-dum.debian.net>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > > I don't know about AMS, but talking to HDAPS when
> > > > you don't need to does waste enough system resources and power to actually
> > > > justify implementing this.
> > 
> > I'd doubt any of the accelerometer implementations would consume much
> > power or CPU.

Actually polling at 100Hz probably _is_ going to be measurable on
modern CPUs -- because it means that CPU has to exit C4. It will not
be too bad, hopefully.

								Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
