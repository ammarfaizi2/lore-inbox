Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932173AbWDYKEu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932173AbWDYKEu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Apr 2006 06:04:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932174AbWDYKEu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Apr 2006 06:04:50 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:64150 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S932173AbWDYKEu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Apr 2006 06:04:50 -0400
Date: Tue, 25 Apr 2006 12:04:09 +0200
From: Pavel Machek <pavel@suse.cz>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Linux PM <linux-pm@osdl.org>, LKML <linux-kernel@vger.kernel.org>,
       Nigel Cunningham <nigel@suspend2.net>
Subject: Re: [RFC][PATCH] swsusp: support creating bigger images
Message-ID: <20060425100408.GF4789@elf.ucw.cz>
References: <200604242355.08111.rjw@sisk.pl> <20060424221632.GQ3386@elf.ucw.cz> <200604251026.53613.rjw@sisk.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200604251026.53613.rjw@sisk.pl>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > Okay, so it can be done, and patch does not look too bad. It still
> > scares me. Is 800MB image more responsive than 500MB after resume?
> 
> Yes, it is, slightly, but I think 800 meg images are impractical for
> performance reasons (like IMO everything above 500 meg with the current
> hardware).  However this means we can save 80% of RAM with the patch
> and that should be 400 meg instead of 250 on a 500 meg machine, or
> 200 meg instead of 125 on a 250 meg machine.

Could we get few people trying it on such small machines to see if it
is really that noticeable?

> > Is benefit worth it?
> 
> Well, that depends.  I think for boxes with 1 GB of RAM or more it's just
> unnecessary (as of today, but this may change if faster disks are available).
> On boxes with 512 MB of RAM or less it may change a lot as far as the
> responsiveness after resume is concerned.
> 
> Anyway do you think it may go into -mm (unless Andrew shoots it down,
> that is ;-))?

I'd really like to hear that it helps someone before going to
-mm. It looks clean enough but still it is 300 lines... 

									Pavel
-- 
Thanks for all the (sleeping) penguins.
