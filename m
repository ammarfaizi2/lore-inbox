Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263271AbUCXKTO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Mar 2004 05:19:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263272AbUCXKTO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Mar 2004 05:19:14 -0500
Received: from gprs214-213.eurotel.cz ([160.218.214.213]:26497 "EHLO
	amd.ucw.cz") by vger.kernel.org with ESMTP id S263271AbUCXKTI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Mar 2004 05:19:08 -0500
Date: Wed, 24 Mar 2004 11:17:04 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Michael Frank <mhf@linuxmail.org>
Cc: Nigel Cunningham <ncunningham@users.sourceforge.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Swsusp mailing list <swsusp-devel@lists.sourceforge.net>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [Swsusp-devel] Re: swsusp problems [was Re: Your opinion on the merge?]
Message-ID: <20040324101704.GA512@elf.ucw.cz>
References: <1079659165.15559.34.camel@calvin.wpcb.org.au> <20040323095318.GB20026@hmmn.org> <20040323214734.GD364@elf.ucw.cz> <200403231743.01642.dtor_core@ameritech.net> <20040323233228.GK364@elf.ucw.cz> <1080081653.22670.15.camel@calvin.wpcb.org.au> <20040323234449.GM364@elf.ucw.cz> <opr5ci61g54evsfm@smtp.pacific.net.th>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <opr5ci61g54evsfm@smtp.pacific.net.th>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> >>So why aren't you arguing against bootsplash too? That definitely
> >>obscures such an error :> Of course we could argue that such an error
> >>shouldn't happen and/or will be obvious via other means (assuming it
> >>indicates hardware failure).
> >
> >Of course I *am* against bootsplash. Unfortunately I've probably lost
> >that war already. But at least it is not in -linus tree (and that's
> >what I use anyway) => I gave up with bootsplash-equivalents, as long
> >as they don't come to linus.
> >
> >[And I believe Linus would shoot down bootsplash-like code, anyway.]
> 
> Solution: Auto switch to non-swsusp VT on error showing the error message.

Hmm, at that point you loose context, like now you know what error
happened, but do not know at which phase of suspend. That's pretty bad
too.
								Pavel
-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
