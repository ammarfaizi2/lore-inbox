Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290744AbSBLDHB>; Mon, 11 Feb 2002 22:07:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290746AbSBLDGv>; Mon, 11 Feb 2002 22:06:51 -0500
Received: from pizda.ninka.net ([216.101.162.242]:40839 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S290744AbSBLDGe>;
	Mon, 11 Feb 2002 22:06:34 -0500
Date: Mon, 11 Feb 2002 19:04:49 -0800 (PST)
Message-Id: <20020211.190449.55725714.davem@redhat.com>
To: davidm@hpl.hp.com
Cc: anton@samba.org, linux-kernel@vger.kernel.org, zippel@linux-m68k.org
Subject: Re: thread_info implementation
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <15464.34183.282646.869983@napali.hpl.hp.com>
In-Reply-To: <15464.33256.837784.657759@napali.hpl.hp.com>
	<20020211.185100.68039940.davem@redhat.com>
	<15464.34183.282646.869983@napali.hpl.hp.com>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: David Mosberger <davidm@hpl.hp.com>
   Date: Mon, 11 Feb 2002 19:01:27 -0800

   No, it will slow down ia64 and you haven't shown that it helps others.

That's crap.  You haven't shown this yet, it didn't slow down sparc64
so I doubt you'll be able to.

You don't have any facts, you just "think" it will slow things down
because of the pointer dereference.  I challenge you to show it
actually shows up on the performance radar.

The thing is going to be fully hot in the cache all the time, there
is no way you'll take a cache miss for this dereference.
