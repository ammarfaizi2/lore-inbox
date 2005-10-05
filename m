Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030405AbVJEWpE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030405AbVJEWpE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Oct 2005 18:45:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030406AbVJEWpE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Oct 2005 18:45:04 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:35721 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1030405AbVJEWpC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Oct 2005 18:45:02 -0400
Date: Thu, 6 Oct 2005 00:44:18 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Lorenzo Colitti <lorenzo@colitti.com>
Cc: Nigel Cunningham <ncunningham@cyclades.com>,
       "Rafael J. Wysocki" <rjw@sisk.pl>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [swsusp] separate snapshot functionality to separate file
Message-ID: <20051005224418.GA22781@elf.ucw.cz>
References: <20051002231332.GA2769@elf.ucw.cz> <200510032339.08217.rjw@sisk.pl> <20051003231715.GA17458@elf.ucw.cz> <200510041711.13408.rjw@sisk.pl> <20051004205334.GC18481@elf.ucw.cz> <1128465272.6611.75.camel@localhost> <20051005084141.GB22034@elf.ucw.cz> <434443D9.3010501@colitti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <434443D9.3010501@colitti.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> >>Pavel, at the PM summit, we agreed to work toward getting Suspend2
> >>merged. I've been working since then on cleaning up the code, splitting
> >>the patches up nicely and so on. In the meantime, you seem to have gone
> >>off on a completely different tangent, going right against what we
> >>agreed then.
> >Sorry about that. At pm summit, I did not know if uswsusp was
> >feasible. Now I'm pretty sure it is (code works and is stable).
> 
> Ok, excuse me for butting in.
> 
> I would just like to give the point of view of a user.
> 
> I have been using suspend2 probably at least once a day for about a year 
> now, and I love it. I have had zero cases of data corruption, and it's 
> fast, effective, and reliable. I can't say the same about the in-kernel 
> swsusp. When I tried it (once), a few months ago:
> 
> - It was dog slow because it doesn't use compression
> - Even though it's dog slow, it doesn't save all RAM
>   - Therefore the machine is dog slow after resume
> - It doesn't have a decent UI
> - There is no way to abort suspend once it's started. (Whatever others
>   may say, this /is/ useful, especially when you've forgotten something
>   and you're in a hurry and don't have two more minutes to waste waiting
>   for a suspend/resume cycle.)

With uswsusp (aka swsusp3), you can do all this in userland. Stop
whining, start hacking... Code is at kernel.org/git/.../linux-sw3.

								Pavel
-- 
if you have sharp zaurus hardware you don't need... you know my address
