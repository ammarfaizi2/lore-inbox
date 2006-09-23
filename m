Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750894AbWIWXAA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750894AbWIWXAA (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Sep 2006 19:00:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750901AbWIWXAA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Sep 2006 19:00:00 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:48587 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1750893AbWIWW77 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Sep 2006 18:59:59 -0400
Date: Sun, 24 Sep 2006 00:59:47 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Nigel Cunningham <ncunningham@linuxmail.org>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Andrew Morton <akpm@osdl.org>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH -mm 0/6] swsusp: Add support for swap files
Message-ID: <20060923225947.GF21187@elf.ucw.cz>
References: <200609202120.58082.rjw@sisk.pl> <200609221328.58504.rjw@sisk.pl> <1158963526.5106.42.camel@nigel.suspend2.net> <200609240018.47017.rjw@sisk.pl> <1159051787.7324.11.camel@nigel.suspend2.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1159051787.7324.11.camel@nigel.suspend2.net>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > > We could use a regular (non-swap) file like this but that would require us to
> > > > use some dangerous code (ie. one that writes directly to blocks belonging to
> > > > certain file bypassing the filesystem).  IMHO this isn't worth it, provided
> > > > the kernel's swap-handling code can do this for us and is known to work. ;-)
> > > 
> > > It's not that dangerous once you debug it.
> > 
> > Certainly.  Still, let me repeat: if there is some code that does pretty much
> > the same and has _already_ been debugged, I prefer using it to writing some
> > new code, debugging it etc.
> 
> Look at Suspend2 then. I know you won't want it in exactly that form,
> but it's there and have been tested and debugged.

Well, but any testing/debugging would have to be invalidated for a
merge, sorry. suspend2 has diverged too much.

"normal files" are not big priority for us, and you could probably do
them in userland just now.... Anyway, diff -u for kernel or preferably
for uswsusp parts would be welcome.

Telling us how much suspend2 rocks with each and every mail... is not
that welcome. 
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
