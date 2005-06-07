Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261935AbVFGRLM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261935AbVFGRLM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Jun 2005 13:11:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261937AbVFGRLM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Jun 2005 13:11:12 -0400
Received: from dtp.xs4all.nl ([80.126.206.180]:27179 "HELO abra2.bitwizard.nl")
	by vger.kernel.org with SMTP id S261935AbVFGRLJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Jun 2005 13:11:09 -0400
Date: Tue, 7 Jun 2005 19:11:08 +0200
From: Erik Mouw <erik@harddisk-recovery.com>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Jeff Garzik <jgarzik@pobox.com>
Subject: Re: Linux v2.6.12-rc6
Message-ID: <20050607171108.GA28817@harddisk-recovery.nl>
References: <Pine.LNX.4.58.0506061104190.1876@ppc970.osdl.org> <20050607130535.GD16602@harddisk-recovery.com> <Pine.LNX.4.58.0506070820170.2286@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0506070820170.2286@ppc970.osdl.org>
Organization: Harddisk-recovery.com
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 07, 2005 at 08:28:45AM -0700, Linus Torvalds wrote:
> On Tue, 7 Jun 2005, Erik Mouw wrote:
> > > Linus Torvalds:
> > >   Linux 2.6.12-rc6
> > >   Automatic merge of 'misc-fixes' branch from
> >
> > ... from what?
>
> Yeah, I guess I need to redo my merge messages. Or alternatively, I should
> just remove merges from the shortlog.
>
> The merge message that goes along with that shortlog entry is
>
>       Author: Linus Torvalds <torvalds@ppc970.osdl.org>
>       Date:   Sat Jun 4 08:18:39 2005 -0700
>
>           Automatic merge of 'misc-fixes' branch from
>
> rsync://rsync.kernel.org/pub/scm/linux/kernel/git/jgarzik/netdev-2.6
>
> which is pretty readable in the long format, but causes the shortlog to
> pick up just the partial (largely uninteresing) first line.

Fair enough.

> Removing merges from the shortlog is actually likely the _right_ thing to
> do, since we already miss a lot of merges: any truly trivial merge (ie no
> parallellism) is invisible anyway, except that the committer changed.
> Besides, it's what the old BK changelogs did.
>
> So I guess I'll leave the merge message as is (unless somebody can suggest
> a more readable format), and just update my release scripts to not include
> merge messages.

Well, it's nice to know which repos you pulled from for a particular
release, that makes it easier to figure out what's wrong if/when
something breaks.

> > >   Automatic merge of rsync://www.parisc-linux.org/~jejb/git/scsi-for-linus-2.6
> > >   Automatic merge of rsync://rsync.kernel.org/.../davem/net-2.6
> >
> > And this again works.
>
> That's because they don't have branches - when I take the HEAD of the
> repostitory, the changelog entry ends up being just a one-liner again.

Isn't the easy fix to put the long changelog information on a single
line?


Erik
[blissfully ignorant about git internals]

-- 
+-- Erik Mouw -- www.harddisk-recovery.nl -- 0800 220 20 20 --
| Eigen lab: Delftechpark 26, 2628 XH, Delft, Nederland
| Files foetsie, bestanden kwijt, alle data weg?!
| Blijf kalm en neem contact op met Harddisk-recovery.nl!
