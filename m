Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289783AbSBJVd1>; Sun, 10 Feb 2002 16:33:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289793AbSBJVcu>; Sun, 10 Feb 2002 16:32:50 -0500
Received: from smtp1.vol.cz ([195.250.128.73]:54026 "EHLO smtp1.vol.cz")
	by vger.kernel.org with ESMTP id <S289767AbSBJVaq>;
	Sun, 10 Feb 2002 16:30:46 -0500
Date: Sat, 9 Feb 2002 21:19:56 +0100
From: Pavel Machek <pavel@suse.cz>
To: "S. Parker" <linux@sparker.net>
Cc: linux-kernel@vger.kernel.org, torvalds@transmeta.com,
        marcelo@conectiva.com.br
Subject: Re: Sysrq enhancement: process kill facility
Message-ID: <20020209201955.GC851@elf.ucw.cz>
In-Reply-To: <4.2.2.20020208092102.00aa5eb8@10.10.10.29>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4.2.2.20020208092102.00aa5eb8@10.10.10.29>
User-Agent: Mutt/1.3.25i
X-Warning: Reading this can be dangerous to your mental health.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> Here's something that myself and others at Cobalt Networks have found 
> useful.
> It extends sysrq to support a way to manually kill a process.  In debugging
> situations, we have found times where the system gets wedged, and we'ld like
> to avoid a reboot.  Show tasks provides the pid information.
> 
> You enter <alt>-<sysrq>-n ("nuke"), and then prompts for the pid.  It 
> supports
> backspace and control-U.  On serial ports, it retains the same semantics:
> a break activates this as a sysrq sequence, but if more than 5-seconds pass
> without any input, it drops out of processing input as a sysrq.
> 
> Feedback welcome, please cc: me directly.

Looks good to me; (maybe you could reuse from 'kIll' as killing of all
processes is hardly ever usefull).
									Pavel
-- 
(about SSSCA) "I don't say this lightly.  However, I really think that the U.S.
no longer is classifiable as a democracy, but rather as a plutocracy." --hpa
