Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264693AbUFSVBU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264693AbUFSVBU (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Jun 2004 17:01:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264686AbUFSVBU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Jun 2004 17:01:20 -0400
Received: from gate.in-addr.de ([212.8.193.158]:8942 "EHLO mx.in-addr.de")
	by vger.kernel.org with ESMTP id S264693AbUFSVBA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Jun 2004 17:01:00 -0400
Date: Sat, 19 Jun 2004 22:59:20 +0200
From: Lars Marowsky-Bree <lmb@suse.de>
To: Jens Axboe <axboe@suse.de>, Andrew Morton <akpm@osdl.org>
Cc: Rik van Riel <riel@redhat.com>, dev@opensound.com,
       linux-kernel@vger.kernel.org
Subject: Re: Stop the Linux kernel madness
Message-ID: <20040619205920.GP28927@marowsky-bree.de>
References: <20040618082708.GD12881@suse.de> <Pine.LNX.4.44.0406181037180.8065-100000@chimarrao.boston.redhat.com> <20040618135136.45581da7.akpm@osdl.org> <20040618211757.GD7404@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20040618211757.GD7404@suse.de>
X-Ctuhulu: HASTUR
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2004-06-18T23:17:57,
   Jens Axboe <axboe@suse.de> said:

> > Problem is, what happens if vendor X ships a feature and that feature is
> > deemed unacceptable for the kernel.org kernel?
> Very good question, as these features/patches are often the ones that
> are ugliest and the hardest to maintain. Or the ones that make you
> slightly source incompatible with mainline, which is always ugly.

I'm afraid that to a certain and hopefully very limitted extend that's
why the distributors need to pay kernel maintainers themselves... *sigh*
I fear the answer is called "business reason", and this time it affects
the kernel, the next time someone does it with gcc, glibc or whatever.

All engineering can do is to kick back as hard as possible and support
eachother by publically kicking back when someone else is forced to do
it - so they can run to their management and complain "see what kind of
bad publicity that gave us!" and hopefully make them at least raise the
bar (& price) of doing it next time ;-)

> > But we then need to do it all again in 2.8.x.  It's hard to see how to fix
> > this apart from either merging everything into the main tree or dropping
> > things from vendor trees.  Or waiting for someone to come up with an
> > acceptable form of whatever it is the patch does.
> Wish I had an answer for that. Things can and do get dropped from vendor
> trees, doesn't cover all cases naturally.

The "waiting for someone.*does." approach before merging into mainline
is the only sane answer IMHO; merging a patch in a vendor kernel should
ultimately lead to that, or at least I'm very convinced that's our goal.

It's not _always_ reached of course, in which case either a feature is
obsoleted, a migration to a different implementation of said feature
needed for customers, or one gets (grudgingly) to carry the patch until
the next major lifecycle change. And 2.4 was hopefully the very height
of those cases and we are settling down again.


Sincerely,
    Lars Marowsky-Brée <lmb@suse.de>

-- 
High Availability & Clustering	      \ ever tried. ever failed. no matter.
SUSE Labs			      | try again. fail again. fail better.
Research & Development, SUSE LINUX AG \ 	-- Samuel Beckett

