Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932337AbWBFW71@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932337AbWBFW71 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Feb 2006 17:59:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932414AbWBFW71
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Feb 2006 17:59:27 -0500
Received: from mail.gmx.de ([213.165.64.21]:57068 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S932337AbWBFW71 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Feb 2006 17:59:27 -0500
Date: Mon, 6 Feb 2006 23:59:25 +0100 (MET)
From: "Michael Kerrisk" <mtk-manpages@gmx.net>
To: Jesse Barnes <jbarnes@virtuousgeek.org>
Cc: linux-kernel@vger.kernel.org, michael.kerrisk@gmx.net
MIME-Version: 1.0
References: <200602061451.37028.jbarnes@virtuousgeek.org>
Subject: Re: man-pages-2.22 is released
X-Priority: 3 (Normal)
X-Authenticated: #24879014
Message-ID: <28306.1139266765@www031.gmx.net>
X-Mailer: WWW-Mail 1.6 (Global Message Exchange)
X-Flags: 0001
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> --- Ursprüngliche Nachricht ---
> Von: Jesse Barnes <jbarnes@virtuousgeek.org>
> An: "Michael Kerrisk" <mtk-manpages@gmx.net>
> Kopie: linux-kernel@vger.kernel.org, michael.kerrisk@gmx.net
> Betreff: Re: man-pages-2.22 is released
> Datum: Mon, 6 Feb 2006 14:51:36 -0800
> 
> On Monday, February 6, 2006 11:59 am, Michael Kerrisk wrote:
> > This is a request to kernel developers: if you make a change
> > to a kernel-userland interface, or observe a discrepancy
> > between the manual pages and reality, would you please send
> > me (at mtk-manpages@gmx.net ) one of the following
> > (in decreasing order of preference):
> 
> Wouldn't it be easier for you to keep them up to date if sections 2, 4, 
> and parts of 5 were included in the kernel source tree?  Documentation 
> updates could be enforced as part of the patch process--all you'd have 
> to do is NAK patches that modified userland interfaces if they didn't 
> contain documentation updates (and I'm sure others would help you with 
> that task).

Life is not so simple, as I think we discussed when you made 
a similar comment after my man-pages-2.08 release.  Maybe the
system can be improved still.  Currently Andrew Morton is being
rather good about CCing me on patches that are likely to need
man-pages changes.  (Thanks Andrew!)

> Likewise with the glibc stuff.  Doesn't it belong with the glibc project? 
> Wouldn't that make more sense, both from a packaging and maintenance 
> perspective?

Not really -- glibc has a differnt philosophy about documentation
(less focus on historical information and less comparison
with other Unix systems, as far as I can see), and uses info(1), 
not man(1).

> Either way, thanks a lot for keeping the pages in good shape, it's much 
> appreciated.

You're welcome.  Several people help.  More help is 
always welcome.

Cheers,

Michael

-- 
Michael Kerrisk
maintainer of Linux man pages Sections 2, 3, 4, 5, and 7 

Want to help with man page maintenance?  
Grab the latest tarball at
ftp://ftp.win.tue.nl/pub/linux-local/manpages/, 
read the HOWTOHELP file and grep the source 
files for 'FIXME'.
