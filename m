Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268047AbTBWHGZ>; Sun, 23 Feb 2003 02:06:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268048AbTBWHGY>; Sun, 23 Feb 2003 02:06:24 -0500
Received: from pizda.ninka.net ([216.101.162.242]:4061 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S268047AbTBWHGY>;
	Sun, 23 Feb 2003 02:06:24 -0500
Date: Sat, 22 Feb 2003 23:00:08 -0800 (PST)
Message-Id: <20030222.230008.08415849.davem@redhat.com>
To: albert@users.sourceforge.net
Cc: linux-kernel@vger.kernel.org, rddunlap@osdl.org
Subject: Re: [PATCH] add new DMA_ADDR_T_SIZE define
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <1045983722.32116.8.camel@cube>
References: <1045983722.32116.8.camel@cube>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Albert Cahalan <albert@users.sourceforge.net>
   Date: 23 Feb 2003 02:02:01 -0500
   
   Casts are ugly and they hide bugs. There is a fix
   for this problem: make u64 be "unsigned long long"
   for every arch. That works for both 32-bit and 64-bit
   systems. Likewise, choose "unsigned" for u32 even
   if an "unsigned long" would work for a given arch.
   
That merely hides the lack of user defined printf types
in gcc, it doesn't make the real problem go away.
What you suggest is merely a bandaid.
