Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750795AbWDXN1F@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750795AbWDXN1F (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Apr 2006 09:27:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750803AbWDXN1E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Apr 2006 09:27:04 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:34192 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1750795AbWDXN1C (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Apr 2006 09:27:02 -0400
Date: Mon, 24 Apr 2006 15:04:07 +0200
From: Pavel Machek <pavel@suse.cz>
To: "Theodore Ts'o" <tytso@mit.edu>, Neil Brown <neilb@suse.de>,
       Stephen Smalley <sds@tycho.nsa.gov>, Chris Wright <chrisw@sous-sol.org>,
       James Morris <jmorris@namei.org>,
       Arjan van de Ven <arjan@infradead.org>, Andi Kleen <ak@suse.de>,
       linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org
Subject: Re: [RFC][PATCH 0/11] security: AppArmor - Overview
Message-ID: <20060424130406.GA1884@elf.ucw.cz>
References: <20060419174905.29149.67649.sendpatchset@ermintrude.int.wirex.com> <1145470463.3085.86.camel@laptopd505.fenrus.org> <p73mzeh2o38.fsf@bragg.suse.de> <1145522524.3023.12.camel@laptopd505.fenrus.org> <20060420192717.GA3828@sorel.sous-sol.org> <1145621926.21749.29.camel@moss-spartans.epoch.ncsc.mil> <20060421173008.GB3061@sorel.sous-sol.org> <1145642853.21749.232.camel@moss-spartans.epoch.ncsc.mil> <17484.20906.122444.964025@cse.unsw.edu.au> <20060424070324.GA14720@thunk.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060424070324.GA14720@thunk.org>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> In the security world, there is a huge tradition of the best being the
> enemy of the good --- and the best being so painful to use that people
> don't want to use it, or the moment it gets in the way (either because
> of performance reasons or their application does something that
> requires painful configuration of the SELinux policy files), they
> deconfigure it.  At which point the "best" becomes useless.
> 
> You may or may not agree with the philosophical architecture question,
> but that doesn't necessarily make it "broken by design".  Choice is
> good; if AppArmor forces SELinux to become less painful to use and
> configure, then that in the long run will be a good thing.

SELinux kernel support can _almost_ do what AA does; with notable
exception of labels for new files. That can probably be fixed with
patch of reasonable size (or maybe even with LD_PRELOAD library, glibc
modification, or stuff like that). (There was post showing that in
this long flamewar).

That way you can have SELinux that works on AA config files.

(I still dislike path-based security, but labeling patch can probably
be useful for other stuff, too.)
								Pavel
-- 
Thanks for all the (sleeping) penguins.
