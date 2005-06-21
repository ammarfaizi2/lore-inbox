Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262139AbVFUPld@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262139AbVFUPld (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Jun 2005 11:41:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262134AbVFUPkb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Jun 2005 11:40:31 -0400
Received: from 238-071.adsl.pool.ew.hu ([193.226.238.71]:60429 "EHLO
	dorka.pomaz.szeredi.hu") by vger.kernel.org with ESMTP
	id S261682AbVFUPgr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Jun 2005 11:36:47 -0400
To: avuton@gmail.com
CC: akpm@osdl.org, linux-kernel@vger.kernel.org
In-reply-to: <3aa654a405062108266a1d2df8@mail.gmail.com> (message from Avuton
	Olrich on Tue, 21 Jun 2005 08:26:57 -0700)
Subject: Re: -mm -> 2.6.13 merge status (fuse)
References: <20050620235458.5b437274.akpm@osdl.org>
	 <E1Dkfu2-0005Ju-00@dorka.pomaz.szeredi.hu> <3aa654a405062108266a1d2df8@mail.gmail.com>
Message-Id: <E1DkknX-0005r6-00@dorka.pomaz.szeredi.hu>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Tue, 21 Jun 2005 17:36:23 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > I won't shed many tears if you drop fuse-nfs-export.patch.  It would
> > at least give the userspace solution some boost.
> > 
> > However the patch is pretty small, and despite it's flaws, I know it's
> > used by a number of people.
> 
> Why not leave it up to the user as an option, for the time being at
> least.

Making it a config option could make sense, yes.

> Does this somehow break things?

You mean outside NFS export?  No, it's completely harmless. 

NFS export itself is slightly broken (random ESTALE errors), but it's
still useful.

Thanks,
Miklos
