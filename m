Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261232AbVELDJp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261232AbVELDJp (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 May 2005 23:09:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261265AbVELDJp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 May 2005 23:09:45 -0400
Received: from e4.ny.us.ibm.com ([32.97.182.144]:23224 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261232AbVELDJd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 May 2005 23:09:33 -0400
Date: Wed, 11 May 2005 22:08:53 -0500
From: serue@us.ibm.com
To: Jamie Lokier <jamie@shareable.org>
Cc: Miklos Szeredi <miklos@szeredi.hu>, 7eggert@gmx.de, ericvh@gmail.com,
       linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
       smfrench@austin.rr.com, hch@infradead.org
Subject: Re: [RCF] [PATCH] unprivileged mount/umount
Message-ID: <20050512030853.GB6401@sergelap.austin.ibm.com>
References: <40rNB-6p8-3@gated-at.bofh.it> <40t37-7ol-5@gated-at.bofh.it> <42VeB-8hG-3@gated-at.bofh.it> <42WNo-1eJ-17@gated-at.bofh.it> <E1DVuHG-0006YJ-Q7@be1.7eggert.dyndns.org> <20050511170700.GC2141@mail.shareable.org> <Pine.LNX.4.58.0505112121190.11888@be1.lrz> <20050511212343.GC5093@mail.shareable.org> <E1DVyqd-0002U1-00@dorka.pomaz.szeredi.hu> <20050511213624.GF5093@mail.shareable.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050511213624.GF5093@mail.shareable.org>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Jamie Lokier (jamie@shareable.org):
> Miklos Szeredi wrote:
> > >      # Make a named namespace.
> > >      NSNAME='fred'
> > >      mkdir /var/namespaces/$NSNAME
> > >      run_in_new_namespace mount -t bind / /var/namespaces/$NSNAME
> > 
> > That's not going to work, since the mount will only affect the new
> > namespace.
> 
> Ah, good point.  I'm still thinking in terms of shared subtrees, where
> it might work.

Oh!  Well, I hope it's safe to assume we'll have those "soon"!

-serge
