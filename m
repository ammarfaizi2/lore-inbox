Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262147AbUB2VeD (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Feb 2004 16:34:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262148AbUB2VeD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Feb 2004 16:34:03 -0500
Received: from post.tau.ac.il ([132.66.16.11]:30850 "EHLO post.tau.ac.il")
	by vger.kernel.org with ESMTP id S262147AbUB2Vd6 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Feb 2004 16:33:58 -0500
Date: Sun, 29 Feb 2004 23:33:02 +0200
From: Micha Feigin <michf@post.tau.ac.il>
To: Software suspend <swsusp-devel@lists.sourceforge.net>,
       linux-kernel@vger.kernel.org
Subject: Re: [Swsusp-devel] Re: Dropping CONFIG_PM_DISK?
Message-ID: <20040229213302.GA23719@luna.mooo.com>
Mail-Followup-To: Software suspend <swsusp-devel@lists.sourceforge.net>,
	linux-kernel@vger.kernel.org
References: <1ulUA-33w-3@gated-at.bofh.it> <20040229161721.GA16688@hell.org.pl> <20040229162317.GC283@elf.ucw.cz> <yw1x4qt93i6y.fsf@kth.se> <opr348q7yi4evsfm@smtp.pacific.net.th>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <opr348q7yi4evsfm@smtp.pacific.net.th>
User-Agent: Mutt/1.5.5.1+cvs20040105i
X-AntiVirus: checked by Vexira MailArmor (version: 2.0.1.16; VAE: 6.24.0.5; VDF: 6.24.0.28; host: localhost)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 01, 2004 at 02:10:09AM +0800, Michael Frank wrote:
> On Sun, 29 Feb 2004 18:32:21 +0100, M?ns Rullg?rd <mru@kth.se> wrote:
> 
> >Pavel Machek <pavel@ucw.cz> writes:
> >
> >>Hi!
> >>
> >>>> Would there be any major screaming if I tried to drop CONFIG_PM_DISK?
> >>>> It seems noone is maintaining it, equivalent functionality is provided
> >>>> by swsusp, and it is confusing users...
> >>>
> >>>It may be ugly, it may be unmaintained, but I get the impression that it
> >>>works for some people for whom swsusp doesn't. So unless swsusp works for
> >>>everyone or Nigel's swsusp2 is merged, I'd suggest leaving that in.
> >>
> >>Do you have example when pmdisk works and swsusp does not? I'm not
> >>aware of any in recent history...
> >
> >For me, none of them (pmdisk, swsusp and swsusp2) work.  I did manage
> >to get pmdisk to resume once, and swsusp2 makes it half-way through
> >the resume.
> 
> Hate to hear this - 2.0 is said to work _flawlessly_ on 2.4.24 and
> on 2.6.2 within the bounds of more complex PM/driver issues.
> 
> 2.4.25 and 2.6.3 patches are undergoing testing.
> 
> If you like to try again, please have a look at http://swsusp.sf.net.
> 
> There is also comprehensive FAQ and Howto on the site.
> 
> You also will find a lot of user support wrt specific HW.
> 
> Myself is running 2.0 on 2.4.2[345] without any stability issues
> whatsoever this year.
> 
> In short, I am confident we can make it work for you!
> 

Same for me. No problems with 2.4.[345] and also works nicely on
2.6.[123] as long as dri is not running (PM problems).

Only one problem that is not caused by swsusp but is a bit of a head
ache. X will ocationaly crash when changing VT to the console. I
originally thought it was a problem with my dri resume patch for
mach64, but the resume kicks in only when entering X and not when
leaving so its got to be something else.

> Regards Michael
> 
> 
> -------------------------------------------------------
> SF.Net is sponsored by: Speed Start Your Linux Apps Now.
> Build and deploy apps & Web services for Linux with
> a free DVD software kit from IBM. Click Now!
> http://ads.osdn.com/?ad_id56&alloc_id438&op=click
> _______________________________________________
> swsusp-devel mailing list
> swsusp-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/swsusp-devel
> 
