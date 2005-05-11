Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262020AbVEKSts@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262020AbVEKSts (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 May 2005 14:49:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262012AbVEKSts
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 May 2005 14:49:48 -0400
Received: from rev.193.226.232.93.euroweb.hu ([193.226.232.93]:49927 "EHLO
	dorka.pomaz.szeredi.hu") by vger.kernel.org with ESMTP
	id S262000AbVEKStq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 May 2005 14:49:46 -0400
To: jamie@shareable.org
CC: 7eggert@gmx.de, ericvh@gmail.com, linux-fsdevel@vger.kernel.org,
       linux-kernel@vger.kernel.org, smfrench@austin.rr.com, hch@infradead.org
In-reply-to: <20050511170700.GC2141@mail.shareable.org> (message from Jamie
	Lokier on Wed, 11 May 2005 18:07:00 +0100)
Subject: Re: [RCF] [PATCH] unprivileged mount/umount
References: <406SQ-5P9-5@gated-at.bofh.it> <40rNB-6p8-3@gated-at.bofh.it> <40t37-7ol-5@gated-at.bofh.it> <42VeB-8hG-3@gated-at.bofh.it> <42WNo-1eJ-17@gated-at.bofh.it> <E1DVuHG-0006YJ-Q7@be1.7eggert.dyndns.org> <20050511170700.GC2141@mail.shareable.org>
Message-Id: <E1DVwGn-0002BB-00@dorka.pomaz.szeredi.hu>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Wed, 11 May 2005 20:49:21 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > > How about a new clone option "CLONE_NOSUID"?
> > 
> > IMO, the clone call ist the wrong place to create namespaces. It should be
> > deprecated by a mkdir/chdir-like interface.
> 
> And the mkdir/chdir interface already exists, see "cd /proc/NNN/root".

That's the chdir part.

The mkdir part is clone() or unshare().

How else do you propose to create new namespaces?

Miklos
