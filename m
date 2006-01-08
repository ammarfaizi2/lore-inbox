Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752644AbWAHPxE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752644AbWAHPxE (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Jan 2006 10:53:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752646AbWAHPxE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Jan 2006 10:53:04 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:7075 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1752644AbWAHPxC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Jan 2006 10:53:02 -0500
Date: Sun, 8 Jan 2006 16:52:45 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Jan Spitalnik <lkml@spitalnik.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Disable swsusp on CONFIG_HIGHMEM64
Message-ID: <20060108155245.GA1683@elf.ucw.cz>
References: <200601061945.09466.lkml@spitalnik.net> <200601071604.03846.lkml@spitalnik.net> <20060106043019.GA2545@ucw.cz> <200601072042.07337.lkml@spitalnik.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200601072042.07337.lkml@spitalnik.net>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > > > s2ram probably works. Try getting it working without highmem64,
> > > > then turn it on.
> > >
> > > It works with HIGHMEM but not HIGHMEM64G. You can find the oops from
> > > HIGHMEM64G below. It crashes very reliably on little stress after resume.
> >
> > s2ram should not depend on ammount of memory. Try debugging
> > it, but do not disable feature just because it does not work
> > for you. I'd start with minimum drivers...
> 
> Well, I've tried it with the bare minimum that was needed to run the system, 
> but it did the same. I'm sorry but i lack the knowledge to properly debug it 
> on source level.  Do you see something that perhaps i don't see in the oops? 
> Maybe some clues as what might be going wrong?

HIGHMEM64G breaks boot on my thinkpad (pretty recent git). I guess I'm
not solving this one.
								Pavel
-- 
Thanks, Sharp!
