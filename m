Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262104AbVFHWDx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262104AbVFHWDx (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Jun 2005 18:03:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262121AbVFHWDx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Jun 2005 18:03:53 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:36995 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S262104AbVFHWDp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Jun 2005 18:03:45 -0400
Date: Thu, 9 Jun 2005 00:03:07 +0200
From: Pavel Machek <pavel@ucw.cz>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: linux-pm@lists.osdl.org, "Yu, Luming" <luming.yu@intel.com>,
       Andrew Morton <akpm@zip.com.au>,
       ACPI devel <acpi-devel@lists.sourceforge.net>,
       Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: [linux-pm] Re: swsusp: Not enough free pages
Message-ID: <20050608220307.GA2614@elf.ucw.cz>
References: <3ACA40606221794F80A5670F0AF15F84041AC1A8@pdsmsx403> <200506081702.53349.rjw@sisk.pl> <20050608162728.GA3969@openzaurus.ucw.cz> <200506082342.14420.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200506082342.14420.rjw@sisk.pl>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > This is the worst result from the second box:
> > > 
> > > Freeing memory...  done (54641 pages freed)
> > > Freeing memory...  done (0 pages freed)
> > > Freeing memory...  done (5120 pages freed)
> > > Freeing memory...  done (1952 pages freed)
> > > Freeing memory...  done (2304 pages freed)
> > > 
> > > Still, there are 5x more pages freed in the first pass (80% of RAM was
> > > empty anyway before suspend), and usually it is 10-20x more or so.
> > 
> > I have seen 0 freed on i386 machine with preempt -rc6-mm1, today...
> > Something is definitely wrong there.
> 
> Well, I have compiled the kernel with preempt and retested (on -rc6) but it
> doesn't want to get worse. :-)
> 
> The problem seems to be arch-dependent or at least configuration-dependent ... 
> 
> Hm, how much RAM is there in your box?

This was on 2GB box...
							Pavel
