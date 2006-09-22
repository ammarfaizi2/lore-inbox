Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932536AbWIVOdU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932536AbWIVOdU (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Sep 2006 10:33:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932537AbWIVOdT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Sep 2006 10:33:19 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:40900 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S932536AbWIVOdS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Sep 2006 10:33:18 -0400
Date: Fri, 22 Sep 2006 16:33:13 +0200
From: Pavel Machek <pavel@ucw.cz>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Jason Lunz <lunz@falooley.org>, Andrew Morton <akpm@osdl.org>,
       LKML <linux-kernel@vger.kernel.org>, Dave Jones <davej@redhat.com>
Subject: Re: [PATCH -mm 5/6] mm: Print first block offset for swap areas
Message-ID: <20060922143313.GP3478@elf.ucw.cz>
References: <20060921235340.DBD89822B@knob.reflex> <200609221257.12303.rjw@sisk.pl> <20060922141346.GA28949@opus.vpn-dev.reflex> <200609221632.55169.rjw@sisk.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200609221632.55169.rjw@sisk.pl>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > This is filesystem-dependent.  AFAICT not all filesystems are supported
> > > by GRUB.
> > 
> > of course, but it shows the technique is viable. Grub is 
> > widespread, and if it's good enough for so many x86 users to boot with
> > then the same approach ought to be adequate for resume, no?
> 
> Well, I'd like to avoid making _any_ assumptions regarding the partition
> on which the "resume" swap file is located.
> 
> Also I think we can implement a simpler approach (ie. one that requires less
> code changes in both the kernel and userland) first and then look for a
> "nicer" one.

Agreed.

(And someone else can create those "realreadonly" patches in the
meantime.)
								Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
