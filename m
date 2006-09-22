Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932545AbWIVOhj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932545AbWIVOhj (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Sep 2006 10:37:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932546AbWIVOhj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Sep 2006 10:37:39 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:48870 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S932545AbWIVOhi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Sep 2006 10:37:38 -0400
Date: Fri, 22 Sep 2006 16:37:31 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Jason Lunz <lunz@falooley.org>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Andrew Morton <akpm@osdl.org>,
       LKML <linux-kernel@vger.kernel.org>, Dave Jones <davej@redhat.com>
Subject: Re: [PATCH -mm 5/6] mm: Print first block offset for swap areas
Message-ID: <20060922143731.GQ3478@elf.ucw.cz>
References: <20060921235340.DBD89822B@knob.reflex> <20060921235817.GA27170@knob.reflex> <200609221257.12303.rjw@sisk.pl> <20060922141346.GA28949@opus.vpn-dev.reflex> <20060922141817.GN3478@elf.ucw.cz> <20060922143539.GC28949@opus.vpn-dev.reflex>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060922143539.GC28949@opus.vpn-dev.reflex>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 2006-09-22 10:35:39, Jason Lunz wrote:
> > Well, most people "solve" this by having their boot partition on ext2,
> > no?
> 
> my grub appears to handle ext2/3, reiser3, xfs, jfs, fat, and minix.
> 
> > Anyway, yes, you can do libext2 magic... in uswsusp..
> 
> a hybrid approach might work, with grub-like support for common filesystems and
> the ability to specify the resume_offset on the kernel command line as a fallback.

Let's do "realreadonly" instead. It is right thing to do.
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
