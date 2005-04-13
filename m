Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261339AbVDMQOO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261339AbVDMQOO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Apr 2005 12:14:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261391AbVDMQOO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Apr 2005 12:14:14 -0400
Received: from mail.shareable.org ([81.29.64.88]:16545 "EHLO
	mail.shareable.org") by vger.kernel.org with ESMTP id S261339AbVDMQOE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Apr 2005 12:14:04 -0400
Date: Wed, 13 Apr 2005 17:13:44 +0100
From: Jamie Lokier <jamie@shareable.org>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: bulb@ucw.cz, 7eggert@gmx.de, linux-fsdevel@vger.kernel.org,
       linux-kernel@vger.kernel.org, hch@infradead.org, akpm@osdl.org,
       viro@parcelfarce.linux.theplanet.co.uk
Subject: Re: [RFC] FUSE permission modell (Was: fuse review bits)
Message-ID: <20050413161344.GC12825@mail.shareable.org>
References: <20050412144529.GE10995@mail.shareable.org> <E1DLNAz-0001oI-00@dorka.pomaz.szeredi.hu> <20050412160409.GH10995@mail.shareable.org> <E1DLOI6-0001ws-00@dorka.pomaz.szeredi.hu> <20050412164401.GA14149@mail.shareable.org> <E1DLOfW-00020V-00@dorka.pomaz.szeredi.hu> <20050412171338.GA14633@mail.shareable.org> <E1DLQkL-0002DS-00@dorka.pomaz.szeredi.hu> <20050413125609.GA9571@vagabond> <E1DLjTV-0004oO-00@dorka.pomaz.szeredi.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1DLjTV-0004oO-00@dorka.pomaz.szeredi.hu>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Miklos Szeredi wrote:
> > > Aren't there some assumptions in VFS that currently make this
> > > impossible?
> > 
> > I believe it's OK with VFS, but applications would be confused to death.
> > Well, there really is one issue -- dentries have exactly one parent, so
> > what do you do when opening a file with hardlinks as a directory? (In
> > fact IIRC that is what lead to all the funny talk about mountpoints,
> > since they don't have this limitation)
> 
> OK, that makes sense.
> 
> It would be quite interesting to see how applications react.  Maybe
> I'll hack something up :)

Look up the rather large linux-kernel & linux-fsdevel thread "silent
semantic changes with reiser4" and it's followup threads, from last
year.

It's already been tried.  You will also find sensible ideas on what
semantics it should have to do it properly.

-- Jamie
