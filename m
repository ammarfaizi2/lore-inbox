Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262854AbSJAWVo>; Tue, 1 Oct 2002 18:21:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262877AbSJAWUK>; Tue, 1 Oct 2002 18:20:10 -0400
Received: from [195.39.17.254] ([195.39.17.254]:8196 "EHLO Elf.ucw.cz")
	by vger.kernel.org with ESMTP id <S262854AbSJAWSL>;
	Tue, 1 Oct 2002 18:18:11 -0400
Date: Mon, 30 Sep 2002 00:16:25 +0200
From: Pavel Machek <pavel@suse.cz>
To: Brian Litzinger <brian@top.worldcontrol.com>, linux-kernel@vger.kernel.org
Subject: Re: SWSUSP and occasional keyboard/X locks (not GPM)
Message-ID: <20020930001625.D19132@elf.ucw.cz>
References: <20020928012331.GA2625@top.worldcontrol.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020928012331.GA2625@top.worldcontrol.com>
User-Agent: Mutt/1.3.23i
X-Warning: Reading this can be dangerous to your mental health.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> I'm running 2.4.18 vanilla with swsusp patches.  I've disabled GPM
> and suspend/resume works well.
> 
> However, occasionally when my laptop resumes everything appears ok,
> but the keyboard and mouse (touchpad) don't respond.   If I ssh
> in via the ethernet I can kill X and keyboard control comes back.
> (this is the same behavior I saw with GPM was missing things up)
> (I've actually removed the gpm executable from my machine)
> 
> I use the 'susp' script to suspend the machine which knocks out most
> of the known problems with software suspend.
> 
> I'm running XFree86 4.2.1.
> 
> My laptop is a Sony VAIO FXA32 w/Duron 900MHz and 384MB RAM.
> 
> You can have a look at the susp script at
> 
>     http://www.litzinger.com/susp
> 
> Any ideas?

Yep, swsusp is not really meant to work in 2.4.X. Get latest
2.5.X... and add IDE patches so it does not eat your disk...

You might want to use setleds to toggle something on keyboard. Perhaps
that helps.

							Pavel

-- 
When do you have heart between your knees?
