Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265576AbSKACu7>; Thu, 31 Oct 2002 21:50:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265584AbSKACu6>; Thu, 31 Oct 2002 21:50:58 -0500
Received: from dp.samba.org ([66.70.73.150]:56229 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S265576AbSKACuz>;
	Thu, 31 Oct 2002 21:50:55 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: Andi Kleen <ak@suse.de>
Cc: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: Re: What's left over. 
In-reply-to: Your message of "31 Oct 2002 18:25:21 BST."
             <p73hef2sepq.fsf@oldwotan.suse.de> 
Date: Fri, 01 Nov 2002 12:08:16 +1100
Message-Id: <20021101025723.1C1472C0BF@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <p73hef2sepq.fsf@oldwotan.suse.de> you write:
> I did an hack to scale the NFS block size in stat to make sure it fits
> into 31bit, but statfs64 would be the correct solution for it really.

AFAICT the patches are not in shape at the moment, so I don't think it
fits "actively being pushed": unless someone chimes in, I'm removing
it.

> Also I would like to propose the nanosecond stat patches. It doesn't add
> new system calls, but just uses spare fields in the existing stat64 
> structure and closes a hole in make.

OK, I've added this one: sorry for missing it.  You might want to
split this into "core" and then updated the filesystems via their
maintainers during the freeze though: it's one *big* patch as it
stands.

Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
