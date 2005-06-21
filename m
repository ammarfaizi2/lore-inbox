Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262118AbVFUPQm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262118AbVFUPQm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Jun 2005 11:16:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261682AbVFUPOY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Jun 2005 11:14:24 -0400
Received: from 238-071.adsl.pool.ew.hu ([193.226.238.71]:58638 "EHLO
	dorka.pomaz.szeredi.hu") by vger.kernel.org with ESMTP
	id S262112AbVFUPN7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Jun 2005 11:13:59 -0400
To: pavel@ucw.cz
CC: akpm@osdl.org, linux-kernel@vger.kernel.org
In-reply-to: <20050621142820.GC2015@openzaurus.ucw.cz> (message from Pavel
	Machek on Tue, 21 Jun 2005 16:28:21 +0200)
Subject: Re: -mm -> 2.6.13 merge status (fuse)
References: <20050620235458.5b437274.akpm@osdl.org> <E1Dkfu2-0005Ju-00@dorka.pomaz.szeredi.hu> <20050621142820.GC2015@openzaurus.ucw.cz>
Message-Id: <E1DkkRE-0005mt-00@dorka.pomaz.szeredi.hu>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Tue, 21 Jun 2005 17:13:20 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > >     This is useful, but there are, AFAIK, two issues:
> > > 
> > >     - We're still deadlocked over some permission-checking hacks in there
> > 
> > Oh, god.  Let me try to explain this again:
> > 
> >   - This is a security issue with unprivileged mounts
> 
> Pretty please, just merge it without unpriviledged mounts. I see
> they are usefull, but they are too strange for now.

An emotional argument again.  What's "strange" about it?

You have a choice of:

 1) believe me that the current solution is fine

 2) get down and try to understand the damn thing, and then come up
    with technical arguments for/against it

I know that 2) takes time and energy, and not a lot of people are
interested enough to go through it, but why on earth do you think it
will _ever_ be easier than now.

Thanks,
Miklos

