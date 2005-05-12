Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261288AbVELBDk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261288AbVELBDk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 May 2005 21:03:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261286AbVELBDk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 May 2005 21:03:40 -0400
Received: from mail.shareable.org ([81.29.64.88]:11473 "EHLO
	mail.shareable.org") by vger.kernel.org with ESMTP id S261249AbVELBDg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 May 2005 21:03:36 -0400
Date: Thu, 12 May 2005 02:02:15 +0100
From: Jamie Lokier <jamie@shareable.org>
To: Eric Van Hensbergen <ericvh@gmail.com>
Cc: Ram <linuxram@us.ibm.com>, Miklos Szeredi <miklos@szeredi.hu>,
       7eggert@gmx.de, linux-fsdevel@vger.kernel.org,
       linux-kernel@vger.kernel.org, smfrench@austin.rr.com, hch@infradead.org
Subject: Re: [RCF] [PATCH] unprivileged mount/umount
Message-ID: <20050512010215.GB8457@mail.shareable.org>
References: <40t37-7ol-5@gated-at.bofh.it> <42VeB-8hG-3@gated-at.bofh.it> <42WNo-1eJ-17@gated-at.bofh.it> <E1DVuHG-0006YJ-Q7@be1.7eggert.dyndns.org> <20050511170700.GC2141@mail.shareable.org> <E1DVwGn-0002BB-00@dorka.pomaz.szeredi.hu> <1115840139.6248.181.camel@localhost> <20050511212810.GD5093@mail.shareable.org> <1115851333.6248.225.camel@localhost> <a4e6962a0505111558337dd903@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a4e6962a0505111558337dd903@mail.gmail.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Eric Van Hensbergen wrote:
> > Well it makes it totally confusing. A user would start seeing different
> > set of mounts suddenly as he changes directories beloning to different
> > namespaces. I am not sure, if changing namespace implicitly is a good
> > idea. Not saying its a bad idea, but seems to change my notion of
> > namespaces completely.
> > 
> > I think a process should have access to one
> > namespace at any given point in time, and should have the ability
> > to explicitly switch to a different namespace of its choice, provided
> > it has enough access permission to that namespace.
> > 
> 
> I agree with Ram.  This whole recent flurry of activity seems to be
> going down a path which will end in tears.

Please read carefully: I've described what _current_ kernels do.

It's a poorly understood area of the kernel, and I'm attempting to
clarify it.  This talk of new system calls for entering a namespace
makes no sense when you can _already_ do some things that people
haven't realised the kernel does.

-- Jamie
