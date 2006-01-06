Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752562AbWAFUxT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752562AbWAFUxT (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Jan 2006 15:53:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752564AbWAFUxT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Jan 2006 15:53:19 -0500
Received: from xenotime.net ([66.160.160.81]:13965 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1752562AbWAFUxS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Jan 2006 15:53:18 -0500
Date: Fri, 6 Jan 2006 12:53:17 -0800 (PST)
From: "Randy.Dunlap" <rdunlap@xenotime.net>
X-X-Sender: rddunlap@shark.he.net
To: "Randy.Dunlap" <rdunlap@xenotime.net>
cc: Pavel Machek <pavel@ucw.cz>, Andrew Morton <akpm@zip.com.au>,
       kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [patch] suspend: update documentation
In-Reply-To: <Pine.LNX.4.58.0601060843190.11324@shark.he.net>
Message-ID: <Pine.LNX.4.58.0601061252590.1545@shark.he.net>
References: <20060106110922.GC9219@atrey.karlin.mff.cuni.cz>
 <Pine.LNX.4.58.0601060843190.11324@shark.he.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 6 Jan 2006, Randy.Dunlap wrote:

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
>
> What recent kernels have SATA suspend/resume support?
> Not from kernel.org AFAIK.

Ah, now I see that it's merged.  Great.

Thanks,
-- 
~Randy
