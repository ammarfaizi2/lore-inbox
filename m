Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319114AbSH2GtY>; Thu, 29 Aug 2002 02:49:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319116AbSH2GtY>; Thu, 29 Aug 2002 02:49:24 -0400
Received: from dp.samba.org ([66.70.73.150]:56493 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S319114AbSH2GtX>;
	Thu, 29 Aug 2002 02:49:23 -0400
From: Rusty Russell <rusty@rustcorp.com.au>
To: Daniel Jacobowitz <dan@debian.org>
Cc: junkio@cox.net, linux-kernel@vger.kernel.org,
       Keith Owens <kaos@ocs.com.au>, geert@linux-m68k.org,
       schwidefsky@de.ibm.com, torvalds@transmeta.com
Subject: Re: [TRIVIAL] strlen("literal string") -> (sizeof("literal string")-1) 
In-reply-to: Your message of "Wed, 28 Aug 2002 23:26:42 -0400."
             <20020829032642.GA9201@nevyn.them.org> 
Date: Thu, 29 Aug 2002 16:29:04 +1000
Message-Id: <20020829015407.7DFCE2C0D9@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <20020829032642.GA9201@nevyn.them.org> you write:
> Also disagree; besides, the evidence implies that Keith is wrong.  GCC
> 2.95.3:

i386, m68k, s390 and s390x define inline strlen() versions, so they
are don't optimize strlen("literal").

This premature optimization should probably be fixed,
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
