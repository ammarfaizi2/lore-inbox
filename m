Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262261AbVBKPxz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262261AbVBKPxz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Feb 2005 10:53:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262262AbVBKPxz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Feb 2005 10:53:55 -0500
Received: from ipcop.bitmover.com ([192.132.92.15]:13727 "EHLO
	mail.bitmover.com") by vger.kernel.org with ESMTP id S262261AbVBKPxw
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Feb 2005 10:53:52 -0500
Date: Fri, 11 Feb 2005 07:53:51 -0800
To: Alexandre Oliva <aoliva@redhat.com>
Cc: "Theodore Ts'o" <tytso@mit.edu>, Stelian Pop <stelian@popies.net>,
       Francois Romieu <romieu@fr.zoreil.com>, linux-kernel@vger.kernel.org
Subject: Re: [RFC] Linux Kernel Subversion Howto
Message-ID: <20050211155351.GB16507@bitmover.com>
Mail-Followup-To: lm@bitmover.com,
	Alexandre Oliva <aoliva@redhat.com>, Theodore Ts'o <tytso@mit.edu>,
	Stelian Pop <stelian@popies.net>,
	Francois Romieu <romieu@fr.zoreil.com>, linux-kernel@vger.kernel.org
References: <20050204233153.GA28731@electric-eye.fr.zoreil.com> <20050205193848.GH5028@deep-space-9.dsnet> <20050205233841.GA20875@bitmover.com> <20050208154343.GH3537@crusoe.alcove-fr> <20050208155845.GB14505@bitmover.com> <ord5vatdph.fsf@livre.redhat.lsd.ic.unicamp.br> <20050209155113.GA10659@bitmover.com> <or7jlgpxio.fsf@livre.redhat.lsd.ic.unicamp.br> <20050210222403.GA5920@thunk.org> <or650z6syt.fsf@livre.redhat.lsd.ic.unicamp.br>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <or650z6syt.fsf@livre.redhat.lsd.ic.unicamp.br>
User-Agent: Mutt/1.5.6+20040907i
From: lm@bitmover.com (Larry McVoy)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 11, 2005 at 01:01:46PM -0200, Alexandre Oliva wrote:
> I don't believe his claim, and I can prove it with a dumb example.
> 
> Consider three patches, A, J and U, such that A and U are identical,
> and J is a patch that reverses them.
> 
> You can determine the final state of the tree given these 3 patches,
> but you can't determine the history.  It could be that A was installed
> first, then J reverted it, then U put it back in.  Or it could be that
> U went in first, J reverted it, and A was put back in.  How could one
> know?  Presumably by looking at the check in messages, presumably.

They all have dates, that's one hint, and they all should apply with no
patch rejects, that's another hint.  You're right that this still
doesn't make it possible to create exactly the same tree as the BK tree
but it makes it possible to create a useful tree.

You are also right that figuring out the merges is a pain.  So what?
We never said that we'd figure out how to do all this well and then
teach you how to do it well.  
-- 
---
Larry McVoy                lm at bitmover.com           http://www.bitkeeper.com
