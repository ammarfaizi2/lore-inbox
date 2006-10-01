Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932190AbWJASvS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932190AbWJASvS (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 Oct 2006 14:51:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932193AbWJASvS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 Oct 2006 14:51:18 -0400
Received: from xenotime.net ([66.160.160.81]:62942 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S932190AbWJASvS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 Oct 2006 14:51:18 -0400
Date: Sun, 1 Oct 2006 11:52:41 -0700
From: Randy Dunlap <rdunlap@xenotime.net>
To: Andrew Morton <akpm@osdl.org>
Cc: lkml <linux-kernel@vger.kernel.org>, torvalds@osdl.org, rossb@google.com,
       akpm@google.com, sam@ravnborg.org
Subject: Re: [patch 024/144] allow /proc/config.gz to be built as a module
Message-Id: <20061001115241.fb9dc96d.rdunlap@xenotime.net>
In-Reply-To: <20061001113600.3c318eda.akpm@osdl.org>
References: <200610010627.k916RPIs010370@shell0.pdx.osdl.net>
	<20061001093954.8d2aa064.rdunlap@xenotime.net>
	<20061001113600.3c318eda.akpm@osdl.org>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.9 (GTK+ 2.8.10; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 1 Oct 2006 11:36:00 -0700 Andrew Morton wrote:

> On Sun, 1 Oct 2006 09:39:54 -0700
> Randy Dunlap <rdunlap@xenotime.net> wrote:
> 
> > On Sat, 30 Sep 2006 23:27:25 -0700 akpm@osdl.org wrote:
> > 
> > > From: Ross Biro <rossb@google.com>
> > > 
> > > The driver for /proc/config.gz consumes rather a lot of memory and it is in
> > > fact possible to build it as a module.
> > > 
> > > In some ways this is a bit risky, because the .config which is used for
> > > compiling kernel/configs.c isn't necessarily the same as the .config which was
> > > used to build vmlinux.
> > > 
> > > But OTOH the potential memory savings are decent, and it'd be fairly dumb to
> > > build your configs.o with a different .config.
> > 
> > so after getting several disagreements on this, you are going ahead
> > with it.
> 
> Actually I had this mentally tagged as "needs more arguing before merging"
> but then forgot and went and sent it anyway.

Well, we agree on that part at least.

> So now it's in the "needs more arguing before we revert it" category.

Wrong order IMO.

---
~Randy
