Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270827AbTHGUaN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Aug 2003 16:30:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270847AbTHGUaN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Aug 2003 16:30:13 -0400
Received: from smtp-out2.iol.cz ([194.228.2.87]:43910 "EHLO smtp-out2.iol.cz")
	by vger.kernel.org with ESMTP id S270827AbTHGUaJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Aug 2003 16:30:09 -0400
Date: Thu, 7 Aug 2003 22:29:51 +0200
From: Pavel Machek <pavel@suse.cz>
To: James Simmons <jsimmons@infradead.org>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       linux-kernel mailing list <linux-kernel@vger.kernel.org>,
       Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>,
       Pavel Machek <pavel@ucw.cz>
Subject: Re: [Linux-fbdev-devel] [PATCH] Framebuffer: 2nd try: client notification mecanism & PM
Message-ID: <20030807202951.GB413@elf.ucw.cz>
References: <20030807100309.GB166@elf.ucw.cz> <Pine.LNX.4.44.0308071822270.13973-100000@phoenix.infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0308071822270.13973-100000@phoenix.infradead.org>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > I believe solution to this is simple: always switch to kernel-owned
> > console during suspend. (swsusp does it, there's patch for S3 to do
> > the same). That way, Xfree (or qtopia or whoever) should clean up
> > after themselves and leave the console to the kernel. (See
> > kernel/power/console.c)
> 
> Not very helpful on embedded systems that use the framebuffer without the 
> VT console. 

Okay, that might be a problem. But such system will need some special
notification... Is VT so much overhead?
								Pavel
-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
