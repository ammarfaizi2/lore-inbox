Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270816AbTHGU33 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Aug 2003 16:29:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270827AbTHGU33
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Aug 2003 16:29:29 -0400
Received: from smtp-out1.iol.cz ([194.228.2.86]:52665 "EHLO smtp-out1.iol.cz")
	by vger.kernel.org with ESMTP id S270816AbTHGU32 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Aug 2003 16:29:28 -0400
Date: Thu, 7 Aug 2003 22:29:08 +0200
From: Pavel Machek <pavel@suse.cz>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Pavel Machek <pavel@suse.cz>, James Simmons <jsimmons@infradead.org>,
       linux-kernel mailing list <linux-kernel@vger.kernel.org>,
       Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>,
       Pavel Machek <pavel@ucw.cz>
Subject: Re: [Linux-fbdev-devel] [PATCH] Framebuffer: 2nd try: client notification mecanism & PM
Message-ID: <20030807202908.GA413@elf.ucw.cz>
References: <Pine.LNX.4.44.0308070000540.17315-100000@phoenix.infradead.org> <1060249101.1077.67.camel@gaston> <20030807100309.GB166@elf.ucw.cz> <1060267031.722.3.camel@gaston>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1060267031.722.3.camel@gaston>
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
> I tried using it on pmac, but it causes hell with XFree. I'm not sure
> what's up yet, I suspect it may be XFree still doing things after
> calling the RELDISP ioctl but I'm not completely sure yet.

Sounds like XFree bug to me ;-).
								Pavel
-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
