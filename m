Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264058AbTDWPJF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Apr 2003 11:09:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264073AbTDWPJF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Apr 2003 11:09:05 -0400
Received: from smtp-out1.iol.cz ([194.228.2.86]:64921 "EHLO smtp-out1.iol.cz")
	by vger.kernel.org with ESMTP id S264058AbTDWPJE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Apr 2003 11:09:04 -0400
Date: Wed, 23 Apr 2003 17:19:20 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: Linus Torvalds <torvalds@transmeta.com>, Andries.Brouwer@cwi.nl,
       Andrew Morton <akpm@digeo.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kdevt-diff
Message-ID: <20030423151919.GA3035@elf.ucw.cz>
References: <Pine.LNX.4.44.0304141116020.19302-100000@home.transmeta.com> <Pine.LNX.4.44.0304151445150.5042-100000@serv>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0304151445150.5042-100000@serv>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > Linus, if you still want to go for a single block device major, this patch 
> > > is bad idea (at least in this form).
> > 
> > I disagree.
> 
> Ok, here is a compromise proposal. I don't care very much about the MKDEV 
> macro and almost nobody else should care about it either.
> My main concern with a larger dev_t is that people start to go wild and 
> waste the number range with crap. So what I'd like to see is some usage 
> policy, e.g. nobody should assume a certain dev_t size, so that it's still 
> possible to scale it down. If the user has only a small number of devices, 
> they should be addressable even with a 16 bit dev_t.

What's the point? Its not like 8 bytes are that much... Your "number
range" is essentially free, and its okay to waste it...
									Pavel
-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
