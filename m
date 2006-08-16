Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751161AbWHPMny@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751161AbWHPMny (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Aug 2006 08:43:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751155AbWHPMnx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Aug 2006 08:43:53 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:18588 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1751157AbWHPMnw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Aug 2006 08:43:52 -0400
Date: Wed, 16 Aug 2006 14:43:34 +0200
From: Pavel Machek <pavel@suse.cz>
To: Al Boldi <a1426z@gawab.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: swsusp hangs on headless resume-from-ram
Message-ID: <20060816124334.GH9497@elf.ucw.cz>
References: <200607262206.48801.a1426z@gawab.com> <20060801210222.GC7601@ucw.cz> <200608021646.11311.a1426z@gawab.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200608021646.11311.a1426z@gawab.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 2006-08-02 16:46:11, Al Boldi wrote:
> Pavel Machek wrote:
> > On Wed 26-07-06 22:06:48, Al Boldi wrote:
> > > swsusp is really great, most of the time.  But sometimes it hangs after
> > > coming out of STR.  I suspect it's got something to do with display
> > > access, as this problem seems hw related.  So I removed the display
> > > card, and it positively does not resume from ram on 2.6.16+.
> > >
> > > Any easy fix for this?
> >
> > Nothing easy.
> >
> > Can you confirm that it still hangs with init=/bin/bash, then echo 3 >
> > /proc/acpi/sleep, no acpi_sleep options?
> 
> Still hangs.
> 
> Thanks for looking into this!

bugzilla.kernel.org time? Cc me...

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
