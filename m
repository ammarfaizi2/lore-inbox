Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266651AbUBQWCr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Feb 2004 17:02:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266639AbUBQWAT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Feb 2004 17:00:19 -0500
Received: from nat-pool-bos.redhat.com ([66.187.230.200]:14811 "EHLO
	chimarrao.boston.redhat.com") by vger.kernel.org with ESMTP
	id S266638AbUBQV73 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Feb 2004 16:59:29 -0500
Date: Tue, 17 Feb 2004 16:59:25 -0500 (EST)
From: Rik van Riel <riel@redhat.com>
X-X-Sender: riel@chimarrao.boston.redhat.com
To: Miklos Szeredi <mszeredi@inf.bme.hu>
cc: linux-kernel@vger.kernel.org, <linux-fsdevel@vger.kernel.org>
Subject: Re: [RFC] [PATCH] allowing user mounts 
In-Reply-To: <200402171000.i1HA00U29578@kempelen.iit.bme.hu>
Message-ID: <Pine.LNX.4.44.0402171657070.25294-100000@chimarrao.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 17 Feb 2004, Miklos Szeredi wrote:

> This patch (against 2.6.3-rc4) allows the use of the mount syscall by
> non-root users in a controlled, and secure (I hope) way.  I'd very
> much appreciate any comments,

Just as a curiosity, why not do this in userspace ?

You'll notice that /bin/mount already is a suid application,
so you could just add your functionality there, or write your
own suid mount application.

As an added bonus, you'd be able to have a more flexible
configuration framework then what would ever be accepted
into the kernel, without needing to go through the effort
of getting anything merged into the kernel.

-- 
"Debugging is twice as hard as writing the code in the first place.
Therefore, if you write the code as cleverly as possible, you are,
by definition, not smart enough to debug it." - Brian W. Kernighan

