Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261379AbTHVWgq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Aug 2003 18:36:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262577AbTHVWgq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Aug 2003 18:36:46 -0400
Received: from smtp-out2.iol.cz ([194.228.2.87]:51637 "EHLO smtp-out2.iol.cz")
	by vger.kernel.org with ESMTP id S261379AbTHVWgo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Aug 2003 18:36:44 -0400
Date: Sat, 23 Aug 2003 00:36:38 +0200
From: Pavel Machek <pavel@suse.cz>
To: Patrick Mochel <mochel@osdl.org>
Cc: torvalds@osdl.org, kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [PM] Patrick: which part of "maintainer" and "peer review" needs explaining to you?
Message-ID: <20030822223638.GF2306@elf.ucw.cz>
References: <20030822210800.GA4403@elf.ucw.cz> <Pine.LNX.4.33.0308221411060.2310-100000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.33.0308221411060.2310-100000@localhost.localdomain>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > You changed return type of do_magic() to int, but did not bother to
> > update assembly code, as far as I can see. Did you test those changes?
> 
> I noticed that, and it's already fixed. 

Be sure to fix x86-64, too (mov $0, %rax should do the trick), and try
to Cc: me this time.
								Pavel
-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
