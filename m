Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265591AbSKADcA>; Thu, 31 Oct 2002 22:32:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265593AbSKADcA>; Thu, 31 Oct 2002 22:32:00 -0500
Received: from w032.z064001165.sjc-ca.dsl.cnc.net ([64.1.165.32]:37447 "EHLO
	nakedeye.aparity.com") by vger.kernel.org with ESMTP
	id <S265591AbSKADb6>; Thu, 31 Oct 2002 22:31:58 -0500
Date: Thu, 31 Oct 2002 19:46:29 -0800 (PST)
From: "Matt D. Robinson" <yakker@aparity.com>
To: Jeff Garzik <jgarzik@pobox.com>
cc: Linus Torvalds <torvalds@transmeta.com>,
       Rusty Russell <rusty@rustcorp.com.au>, <linux-kernel@vger.kernel.org>,
       <lkcd-general@lists.sourceforge.net>,
       <lkcd-devel@lists.sourceforge.net>
Subject: Re: What's left over.
In-Reply-To: <3DC1E1AE.4070706@pobox.com>
Message-ID: <Pine.LNX.4.44.0210311923460.24182-100000@nakedeye.aparity.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 31 Oct 2002, Jeff Garzik wrote:
|>Re-read my other post(s) -- I have said repeatedly that LKCD's 
|>infrastructure is decent.  But it's completely pointless to merge a 
|>decent infrastructure unless the users are up to snuff.  It's much 
|>smarter to keep the infrastructure out of the kernel until the low-level 
|>dump drivers are hammered out and stable, because that gives you more 
|>freedom to change the API.

This is where we disagree.  Without the base infrastructure, this
becomes an even larger and larger patch which needs testing and
verification with a massive number of configurations for each new
kernel release.  Do you know how much testing we go through for each
new kernel release?  Do you know that we actually try this stuff
out with panic(), die(), interrupt and sysrq() dumps before we send
it off?  Do you know we try this for SMP and UP?

If Linus would at least take the infrastructure patches and leave
out the drivers/dump code, that might be a good start.  Just take
the base code.  Just take the patches for panic.c, dump_ipi(), or
the rest of the other base kernel components,  But no.  Instead,
Linus just says "LKCD is stupid".

I also think you have completely misrepresented the LKCD user base,
but I'm sure our opinion on who those LKCD users are is different
and it's pointless to argue one person's experiences over another's.

I hate Linus' ego, I hate this whole damn discussion, and I find
it very irritating that I have to go through this process after
many people have created, enhanced and used LKCD for three years,
and this is where we're at.

To spend the last month and a half finalizing things for Linus,
sending this to him on multiple occasions, asking for his comments
and inclusion, asking for his feedback (as well as others), and
not hearing _one damn word_ from Linus all that time, and for him
to wait until now to just say "LKCD is stupid" is insulting.

--Matt

