Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319044AbSIDEQD>; Wed, 4 Sep 2002 00:16:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319045AbSIDEQC>; Wed, 4 Sep 2002 00:16:02 -0400
Received: from dp.samba.org ([66.70.73.150]:989 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S319044AbSIDEQC>;
	Wed, 4 Sep 2002 00:16:02 -0400
From: Rusty Russell <rusty@rustcorp.com.au>
To: "David S. Miller" <davem@redhat.com>
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org, akpm@zip.com.au
Subject: Re: [PATCH] Important per-cpu fix. 
In-reply-to: Your message of "Tue, 03 Sep 2002 19:54:55 MST."
             <20020903.195455.117344683.davem@redhat.com> 
Date: Wed, 04 Sep 2002 14:04:22 +1000
Message-Id: <20020904042036.816A62C1B6@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <20020903.195455.117344683.davem@redhat.com> you write:
>    From: Rusty Russell <rusty@rustcorp.com.au>
>    Date: Wed, 04 Sep 2002 12:35:41 +1000
> 
>    This might explain the wierd per-cpu problem reports from Andrew and
>    Dave, and also that nagging feeling that I'm an idiot...
> 
> Verifying...  no without the explicit initializers the per-cpu stuff
> still ends up in the BSS with egcs-2.9X, even with your fix applied.

OK.  I really hate working around wierd toolchain bugs (I use 2.95.4
here and it's fine), and adding an initializer to the macro is ugly.

If you're not going to upgrade your compiler, will you accept a gcc
patch to fix this?  If so, where can I get the source to your exact
version?

Thanks,
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
