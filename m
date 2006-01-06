Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752445AbWAFQvn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752445AbWAFQvn (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Jan 2006 11:51:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752471AbWAFQvn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Jan 2006 11:51:43 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:2455 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1752445AbWAFQvn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Jan 2006 11:51:43 -0500
Date: Fri, 6 Jan 2006 17:51:24 +0100
From: Pavel Machek <pavel@suse.cz>
To: "Randy.Dunlap" <rdunlap@xenotime.net>
Cc: Andrew Morton <akpm@zip.com.au>,
       kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [patch] suspend: update documentation
Message-ID: <20060106165124.GC12190@elf.ucw.cz>
References: <20060106110922.GC9219@atrey.karlin.mff.cuni.cz> <Pine.LNX.4.58.0601060843190.11324@shark.he.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Pine.LNX.4.58.0601060843190.11324@shark.he.net>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Pá 06-01-06 08:46:19, Randy.Dunlap wrote:
> On Fri, 6 Jan 2006, Pavel Machek wrote:
> 
> > This updates documentation for suspend-to-disk and RAM. In particular
> > modular disk drivers trap is documented.
> >
> > Signed-off-by: Pavel Machek <pavel@suse.cz>
> >
> > --- a/Documentation/power/swsusp.txt
> > +++ b/Documentation/power/swsusp.txt
> > @@ -27,13 +27,11 @@ echo shutdown > /sys/power/disk; echo di
> > +. If you have SATA disks, you'll need recent kernels with SATA suspend
> > +support. For suspend and resume to work, make sure your disk drivers
> > +are built into kernel -- not modules. [There's way to make
> > +suspend/resume with modular disk drivers, see FAQ, but you should
> > +better not do that.]
> 
> (drop "better", or say "but you probably shouldn't do that.")

Second variant applied.

> What recent kernels have SATA suspend/resume support?
> Not from kernel.org AFAIK.

Andrew merged it to -mm tree after getting notebook with SATA. I'm not
sure if it is in kernel.org just now or not, it probably did not make
it into 2.6.15.
								Pavel
-- 
Thanks, Sharp!
