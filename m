Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265107AbSJaCZN>; Wed, 30 Oct 2002 21:25:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265109AbSJaCZM>; Wed, 30 Oct 2002 21:25:12 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:32777 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S265107AbSJaCZI>; Wed, 30 Oct 2002 21:25:08 -0500
Date: Wed, 30 Oct 2002 18:31:36 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Rusty Russell <rusty@rustcorp.com.au>
cc: linux-kernel@vger.kernel.org
Subject: Re: What's left over.
In-Reply-To: <20021031020836.E576E2C09F@lists.samba.org>
Message-ID: <Pine.LNX.4.44.0210301823120.1396-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 31 Oct 2002, Rusty Russell wrote:
> 
> 	Here is the list of features which have are being actively
> pushed, not NAK'ed, and are not in 2.5.45.  There are 13 of them, as
> appropriate for Halloween.

I'm unlikely to be able to merge everything by tomorrow, so I will 
consider tomorrow a submission deadline to me, rather than a merge 
deadline. That said, I merged everything I'm sure I want to merge today, 
and the rest I simply haven't had time to look at very much.

> In-kernel Module Loader and Unified parameter support

This apparently breaks things like DRI, which I'm fairly unhappy about,
since I think 3D is important.

> Fbdev Rewrite

This one is just huge, and I have little personal judgement on it.

> Linux Trace Toolkit (LTT)

I don't know what this buys us.

> statfs64

I haven't even seen it.

> ext2/ext3 ACLs and Extended Attributes

I don't know why people still want ACL's. There were noises about them for 
samba, but I'v enot heard anything since. Are vendors using this?

> ucLinux Patch (MMU-less support)

I've seen this, it looks pretty ok.

> Crash Dumping (LKCD)

This is definitely a vendor-driven thing. I don't believe it has any 
relevance unless vendors actively support it.

> POSIX Timer API

I think I'll do at least the API, but there were some questions about the 
config options here, I think.

> Hotplug CPU Removal Support

No objections, but very little visibility into it either.

> Hires Timers

This one is likely another "vendor push" thing.

> EVMS

Not for the feature freeze, there are some noises that imply that SuSE may 
push it in their kernels. 

> initramfs

I want this.

> Kernel Probes

Probably.

		Linus

