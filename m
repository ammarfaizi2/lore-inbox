Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317675AbSFLJbB>; Wed, 12 Jun 2002 05:31:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317676AbSFLJbA>; Wed, 12 Jun 2002 05:31:00 -0400
Received: from pizda.ninka.net ([216.101.162.242]:30671 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S317675AbSFLJa7>;
	Wed, 12 Jun 2002 05:30:59 -0400
Date: Wed, 12 Jun 2002 02:26:41 -0700 (PDT)
Message-Id: <20020612.022641.123609388.davem@redhat.com>
To: rusty@rustcorp.com.au
Cc: akpm@zip.com.au, torvalds@transmeta.com, linux-kernel@vger.kernel.org,
        k-suganuma@mvj.biglobe.ne.jp
Subject: Re: [PATCH] 2.5.21 Nonlinear CPU support 
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <E17I25H-0002hf-00@wagner.rustcorp.com.au>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Rusty Russell <rusty@rustcorp.com.au>
   Date: Wed, 12 Jun 2002 16:58:23 +1000

   In message <20020611.021043.04190747.davem@redhat.com> you write:
   > And remember, it's the anal "every microoptimization at all costs"
   > people that keep the kernel sane and from running out of control bloat
   > wise.
   
   But it also gave us crap like net/ipv4/route.c:ip_rt_acct_read() 8(

That's far from being an attempt optimization :-)
Furthermore, cleanup patches are always happily accepted.
9 out of 10 2.5.x networking patches I apply are cleanups
from Arnaldo these days.
