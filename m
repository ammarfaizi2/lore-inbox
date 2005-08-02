Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261503AbVHBL1E@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261503AbVHBL1E (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Aug 2005 07:27:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261504AbVHBL1A
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Aug 2005 07:27:00 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:3755 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S261503AbVHBLZm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Aug 2005 07:25:42 -0400
Date: Tue, 2 Aug 2005 13:25:30 +0200
From: Pavel Machek <pavel@ucw.cz>
To: James Bruce <bruce@andrew.cmu.edu>
Cc: David Weinehall <tao@acc.umu.se>, Lee Revell <rlrevell@joe-job.com>,
       Marc Ballarin <Ballarin.Marc@gmx.de>, linux-kernel@vger.kernel.org
Subject: Re: Power consumption HZ100, HZ250, HZ1000: new numbers
Message-ID: <20050802112529.GA7954@elf.ucw.cz>
References: <20050730195116.GB9188@elf.ucw.cz> <1122753864.14769.18.camel@mindpipe> <20050730201049.GE2093@elf.ucw.cz> <42ED32D3.9070208@andrew.cmu.edu> <20050731211020.GB27433@elf.ucw.cz> <42ED4CCF.6020803@andrew.cmu.edu> <20050731224752.GC27580@elf.ucw.cz> <1122852234.13000.27.camel@mindpipe> <20050801074447.GJ9841@khan.acc.umu.se> <42EE4B4A.80602@andrew.cmu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42EE4B4A.80602@andrew.cmu.edu>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> >In the end, Linus will decide this anyway.  I can understand that you
> >don't want to change your application.  Help developing the dynamic
> >tick patch, and maybe you won't have to =)
> 
> From what I can tell, tick skipping works fine right now, it just needs 
> some cleanup.  Thus I'd expect something like it will get integrated 
> into 2.6.14.  If it gets in, the default HZ should go back up to 1000. 
> In that case why decrease it for exactly one patchlevel?
> 
> As an app programmer, it'd be nice not to have to support 2.6.13 
> differently from 2.6.(x!=13).  For my app, busy waiting means a ~12% 
> load increase for 2.6.13 compared to (probably) all other 2.6 kernel 
> versions.  That's certainly violating the principle of least surprise. 
> Up to now, it was easy enough to tell people "upgrade from 2.4.x and 
> it'll work better".  Now it gets more complicated.

BTW I think many architectures have HZ=100 even in 2.6, so it is not
as siple as "go 2.6"...
								Pavel

-- 
teflon -- maybe it is a trademark, but it should not be.
