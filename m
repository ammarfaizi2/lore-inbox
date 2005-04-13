Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261370AbVDMPJA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261370AbVDMPJA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Apr 2005 11:09:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261368AbVDMPI7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Apr 2005 11:08:59 -0400
Received: from rev.193.226.232.28.euroweb.hu ([193.226.232.28]:21476 "EHLO
	dorka.pomaz.szeredi.hu") by vger.kernel.org with ESMTP
	id S261367AbVDMPI4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Apr 2005 11:08:56 -0400
To: bulb@ucw.cz
CC: jamie@shareable.org, 7eggert@gmx.de, linux-fsdevel@vger.kernel.org,
       linux-kernel@vger.kernel.org, hch@infradead.org, akpm@osdl.org,
       viro@parcelfarce.linux.theplanet.co.uk
In-reply-to: <20050413125609.GA9571@vagabond> (message from Jan Hudec on Wed,
	13 Apr 2005 14:56:09 +0200)
Subject: Re: [RFC] FUSE permission modell (Was: fuse review bits)
References: <3SbPN-3T4-19@gated-at.bofh.it> <E1DLHWZ-0001Bg-SU@be1.7eggert.dyndns.org> <20050412144529.GE10995@mail.shareable.org> <E1DLNAz-0001oI-00@dorka.pomaz.szeredi.hu> <20050412160409.GH10995@mail.shareable.org> <E1DLOI6-0001ws-00@dorka.pomaz.szeredi.hu> <20050412164401.GA14149@mail.shareable.org> <E1DLOfW-00020V-00@dorka.pomaz.szeredi.hu> <20050412171338.GA14633@mail.shareable.org> <E1DLQkL-0002DS-00@dorka.pomaz.szeredi.hu> <20050413125609.GA9571@vagabond>
Message-Id: <E1DLjTV-0004oO-00@dorka.pomaz.szeredi.hu>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Wed, 13 Apr 2005 17:08:17 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > Aren't there some assumptions in VFS that currently make this
> > impossible?
> 
> I believe it's OK with VFS, but applications would be confused to death.
> Well, there really is one issue -- dentries have exactly one parent, so
> what do you do when opening a file with hardlinks as a directory? (In
> fact IIRC that is what lead to all the funny talk about mountpoints,
> since they don't have this limitation)

OK, that makes sense.

It would be quite interesting to see how applications react.  Maybe
I'll hack something up :)

Thanks,
Miklos
