Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261464AbVCCGzj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261464AbVCCGzj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Mar 2005 01:55:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261488AbVCCGxz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Mar 2005 01:53:55 -0500
Received: from rev.193.226.232.215.euroweb.hu ([193.226.232.215]:48049 "EHLO
	dorka.pomaz.szeredi.hu") by vger.kernel.org with ESMTP
	id S261464AbVCCGl4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Mar 2005 01:41:56 -0500
To: hch@infradead.org
CC: akpm@osdl.org, torvalds@osdl.org, linux-kernel@vger.kernel.org
In-reply-to: <20050302221901.GA26008@infradead.org> (message from Christoph
	Hellwig on Wed, 2 Mar 2005 22:19:01 +0000)
Subject: Re: [request for inclusion] Filesystem in Userspace
References: <E1D6YPJ-0000Jv-00@dorka.pomaz.szeredi.hu> <20050302221901.GA26008@infradead.org>
Message-Id: <E1D6k1O-0001ME-00@dorka.pomaz.szeredi.hu>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Thu, 03 Mar 2005 07:41:18 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > Do you have any objections to merging FUSE in mainline kernel?
> > 
> > It's been in -mm for the 2.6.11 cycle, and the same code was released
> > a month ago as FUSE-2.2.  So it should have received a fair amount of
> > testing, with no problems found so far.
> > 
> > The one originally merged into -mm already addressed all major issues
> > that people found (most importantly the OOM deadlock thing), and
> > though there were some minor changes in the interface since then, I
> > feel that the current kernel interface will stand up to the test of
> > time.
> 
> 
> Please give me or some other filesystem person some time to look over
> it, there were a few things that looked really fishy.

Please do.  Although I think the most complex part of FUSE is the
device handling, which is not really "filesystem" code.  The
filesystem part is mostly really straightforward.

Still the more people look at it, the better.

> And apologies for not having time to look at it earlier, but I'm a little
> bit too busy right now.

Take your time, I don't want to hurry merging into mainline, but
things went very quiet lately on the bug front.

Thanks,
Miklos
