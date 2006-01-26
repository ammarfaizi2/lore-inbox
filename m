Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932308AbWAZMc0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932308AbWAZMc0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Jan 2006 07:32:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932309AbWAZMc0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Jan 2006 07:32:26 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:15033 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S932308AbWAZMcZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Jan 2006 07:32:25 -0500
Date: Thu, 26 Jan 2006 13:32:14 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Joerg Schilling <schilling@fokus.fraunhofer.de>
Cc: matthias.andree@gmx.de, jengelh@linux01.gwdg.de, rlrevell@joe-job.com,
       linux-kernel@vger.kernel.org
Subject: Re: CD writing in future Linux (stirring up a hornets' nest) (was: Rationale for RLIMIT_MEMLOCK?)
Message-ID: <20060126123214.GB1609@elf.ucw.cz>
References: <20060123165415.GA32178@merlin.emma.line.org> <1138035602.2977.54.camel@laptopd505.fenrus.org> <20060123180106.GA4879@merlin.emma.line.org> <1138039993.2977.62.camel@laptopd505.fenrus.org> <20060123185549.GA15985@merlin.emma.line.org> <43D530CC.nailC4Y11KE7A@burner> <1138048255.21481.15.camel@mindpipe> <20060123212119.GI1820@merlin.emma.line.org> <Pine.LNX.4.61.0601241823390.28682@yvahk01.tjqt.qr> <43D78585.nailD7855YVBX@burner>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43D78585.nailD7855YVBX@burner>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > >write a CD anyways". I find this wrong, J??rg finds it correct and argues
> > >"if you can access /dev/hdc as unprivileged user, that's a security
> > >problem".
> >
> > If you can access a _harddisk_ as a normal user, you _do have_ a security 
> > problem. If you can access a cdrom as normal user, well, the opinions 
> > differ here. I think you _should not either_, because it might happen that 
> > you just left your presentation cd in a cdrom device in a public box. You 
> > would certainly not want to have everyone read that out.
> 
> Do you  want everybody to be able to read or format a floppy disk?

Why not... if I'm on box without network access, for example.

> > SUSE currently does it in A Nice Way: setfacl'ing the devices to include 
> > read access for currently logged-in users. (Well, if someone logs on tty1 
> > after you, you're screwed anyway - he could have just ejected the cd when 
> > he's physically at the box.)
> 
> It may make sense to do something like this for the user logged into the 
> console. In general it is a security problem.

Violent agreement here. For some uses, 99% of users are logged onto
the console.
								Pavel
-- 
Thanks, Sharp!
