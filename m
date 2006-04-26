Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932350AbWDZCe7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932350AbWDZCe7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Apr 2006 22:34:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932351AbWDZCe7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Apr 2006 22:34:59 -0400
Received: from mail1.webmaster.com ([216.152.64.168]:11785 "EHLO
	mail1.webmaster.com") by vger.kernel.org with ESMTP id S932350AbWDZCe6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Apr 2006 22:34:58 -0400
From: "David Schwartz" <davids@webmaster.com>
To: "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>
Subject: RE: C++ pushback
Date: Tue, 25 Apr 2006 19:33:59 -0700
Message-ID: <MDEHLPKNGKAHNMBLJOLKAEJOLIAB.davids@webmaster.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.6604 (9.0.2911.0)
In-Reply-To: <mj+md-20060425.194740.24822.atrey@ucw.cz>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2869
Importance: Normal
X-Authenticated-Sender: joelkatz@webmaster.com
X-Spam-Processed: mail1.webmaster.com, Tue, 25 Apr 2006 19:30:02 -0700
	(not processed: message from trusted or authenticated source)
X-MDRemoteIP: 206.171.168.138
X-Return-Path: davids@webmaster.com
X-MDaemon-Deliver-To: linux-kernel@vger.kernel.org
Reply-To: davids@webmaster.com
X-MDAV-Processed: mail1.webmaster.com, Tue, 25 Apr 2006 19:30:05 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > Hahaha. So now, it's not good enough that they not ask you
> > to do anything,
> > they have to actively *prevent* you from choosing to waste time on their
> > changes?

> If you wish to interpret it that way, I won't prevent you :-)

> Anyway -- what I meant is that even if somebody writes a patch changing
> names to avoid collisions with C++, _merging_ such a patch could be
> easily a waste of other people's time, especially when there is no
> other advantage in merging such a patch (like if the reason is that
> somebody wishes to port his closed-source driver to Linux [*]).

> [*]: Not that I'm claiming that this is the case now, but it already
> happened.

	You are being ambiguous here, possibly deliberately possibly through honest
confusion and possibly because you know what you're saying and can't imagine
how anyone else could not understand you. For example, does "merging" mean
the process of making the kernel continue to compile cleanly with the patch
applied? Or does "merging" mean the effort in maintaining your current level
of understanding and proficiency with the kernel once the patch is in the
mainline?

	If the former, you are totally correct. Nobody should work on merging a
patch they don't believe in. If the latter, then see my criticism.

	You originally said:

>>> As far as they intend to stay away from the main kernel tree, I don't
>>> critize anybody. But for example renaming otherwise logically
>>> named structure
>>> members (`class' etc.) just for C++ compatibility _IS_ wasting time of
>>> other people, who need to remember new names, review the patch and so
on.

	If you don't believe the patch will benefit anyone, the review shouldn't
take you more than a second or two. You should definitely say "I don't
believe in this patch, I don't like C++ in the kernel, my review is that it
should not go in" and that's it. Nobody is forcing you to work to adopt
changes you don't believe in, and you should *not* do so as your part in
keeping kernel code quality high.

	As for remembering new names, that's a load of complete crap and I find it
hard to believe that you're raising the argument for honest reasons.

	DS


