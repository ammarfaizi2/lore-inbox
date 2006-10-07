Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750816AbWJGKhZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750816AbWJGKhZ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Oct 2006 06:37:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750818AbWJGKhZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Oct 2006 06:37:25 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:47837 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1750816AbWJGKhY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Oct 2006 06:37:24 -0400
Date: Sat, 7 Oct 2006 12:37:14 +0200
From: Pavel Machek <pavel@ucw.cz>
To: koos vriezen <koos.vriezen@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.6.18 break scratchbox
Message-ID: <20061007103714.GD30034@elf.ucw.cz>
References: <d4e708d60610030759h23a037aega70acb44bff1b524@mail.gmail.com> <20061004213521.GA8667@elf.ucw.cz> <d4e708d60610052341v8e8718cpfca5b60a28bfc93b@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d4e708d60610052341v8e8718cpfca5b60a28bfc93b@mail.gmail.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 2006-10-06 08:41:56, koos vriezen wrote:
> 2006/10/4, Pavel Machek <pavel@ucw.cz>:
> >Hi!
> >
> >> Hit by http://bugzilla.scratchbox.org/bugzilla/show_bug.cgi?id=279 I
> >> wondered why such
> >> a change that could break existing setups entered 2.6.18.
> >> Now I can peek through '/proc/<pid of process outside chroot env w/ my
> >> UID>/root' into the
> >> box's root (and that's why scratchbox is broken now).
> >
> >File bug at bugzilla.kernel.org :-).
> >
> >I'm afraid we did not know about this ABI change, and noone using
> >scratchbox tested 2.6.18-rcX...
> 
> Well I did google for this before this report and eg.
> http://nchip.livejournal.com/ already mentioned it (but probably
> didn't report it at lkml) and there where some other links.
> But since I couldn't find any info on this new feature, that one can
> now read and write file through the /proc/xx/root link, I ask it here.
> And hopefully, if it's a regression, would be fixed in the stable tree
> ASAP. (Somehow I almost can't believe this change wouldn't show
> immediately in a regression test setup, and there must be a reason for
> opening this door w/o using an axe).

You probably want to do that bugzilla.kernel.org... and yes, this is
kind of bug I can imageine goes in without anyone noticing.
								Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
