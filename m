Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262023AbVEKTHo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262023AbVEKTHo (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 May 2005 15:07:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262012AbVEKTHo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 May 2005 15:07:44 -0400
Received: from e35.co.us.ibm.com ([32.97.110.133]:34015 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S261261AbVEKTHZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 May 2005 15:07:25 -0400
Date: Wed, 11 May 2005 14:05:45 -0500
From: serue@us.ibm.com
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: jamie@shareable.org, 7eggert@gmx.de, ericvh@gmail.com,
       linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
       smfrench@austin.rr.com, hch@infradead.org
Subject: Re: [RCF] [PATCH] unprivileged mount/umount
Message-ID: <20050511190545.GB14646@serge.austin.ibm.com>
References: <406SQ-5P9-5@gated-at.bofh.it> <40rNB-6p8-3@gated-at.bofh.it> <40t37-7ol-5@gated-at.bofh.it> <42VeB-8hG-3@gated-at.bofh.it> <42WNo-1eJ-17@gated-at.bofh.it> <E1DVuHG-0006YJ-Q7@be1.7eggert.dyndns.org> <20050511170700.GC2141@mail.shareable.org> <E1DVwGn-0002BB-00@dorka.pomaz.szeredi.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1DVwGn-0002BB-00@dorka.pomaz.szeredi.hu>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Miklos Szeredi (miklos@szeredi.hu):
> > > > How about a new clone option "CLONE_NOSUID"?
> > > 
> > > IMO, the clone call ist the wrong place to create namespaces. It should be
> > > deprecated by a mkdir/chdir-like interface.
> > 
> > And the mkdir/chdir interface already exists, see "cd /proc/NNN/root".
> 
> That's the chdir part.
> 
> The mkdir part is clone() or unshare().

Right, sys_unshare(), as per Janak's patch.  Does it lack anything which
you would need?

> How else do you propose to create new namespaces?

thanks,
-serge
