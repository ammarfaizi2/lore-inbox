Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261563AbUK1TDI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261563AbUK1TDI (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Nov 2004 14:03:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261569AbUK1TDI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Nov 2004 14:03:08 -0500
Received: from gprs214-243.eurotel.cz ([160.218.214.243]:19330 "EHLO
	amd.ucw.cz") by vger.kernel.org with ESMTP id S261563AbUK1TCG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Nov 2004 14:02:06 -0500
Date: Sun, 28 Nov 2004 20:01:50 +0100
From: Pavel Machek <pavel@suse.cz>
To: Helge Hafting <helgehaf@aitel.hist.no>
Cc: Helge Hafting <helge.hafting@hist.no>, Amit Gud <amitgud1@gmail.com>,
       linux-kernel@vger.kernel.org, reiserfs-list@namesys.com
Subject: Re: file as a directory
Message-ID: <20041128190150.GF1214@elf.ucw.cz>
References: <2c59f00304112205546349e88e@mail.gmail.com> <41A1FFFC.70507@hist.no> <20041125230937.GA2909@elf.ucw.cz> <20041128185334.GA5329@hh.idb.hist.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041128185334.GA5329@hh.idb.hist.no>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > You won't get .tar or .tar.gz support in the VFS, for a few simple reasons:
> > > 1. .tar and .tar.gz are complicated formats, and are therefore better
> > >   left to userland.  You can get some of the same effect by using a shared
> > >   library that redefines fopen() and fread() though.  It'll work fine for
> > >   the vast majority of apps that happens to use the C library.
> > 
> > It is not same effect -- with shared library you get no caching. And
> > that hurts a lot.
> > 
> The compressed file is still cached, and the library can cache
> file contents in a shared mapping.  It does not have to
> be a per-process thing.

Okay, that way you can get it per-user but not system-global...

								Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
