Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311749AbSHRIpy>; Sun, 18 Aug 2002 04:45:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312558AbSHRIpy>; Sun, 18 Aug 2002 04:45:54 -0400
Received: from pizda.ninka.net ([216.101.162.242]:20437 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S311749AbSHRIpx>;
	Sun, 18 Aug 2002 04:45:53 -0400
Date: Sun, 18 Aug 2002 01:35:15 -0700 (PDT)
Message-Id: <20020818.013515.105779373.davem@redhat.com>
To: lm@bitmover.com
Cc: Ruth.Ivimey-Cook@ivimey.org, matti.aarnio@zmailer.org, dax@gurulabs.com,
       linux-kernel@vger.kernel.org
Subject: Re: Does Solaris really scale this well?
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20020817175517.A31128@work.bitmover.com>
References: <20020817182715.GC32427@mea-ext.zmailer.org>
	<Pine.LNX.4.44.0208172358460.3111-100000@sharra.ivimey.org>
	<20020817175517.A31128@work.bitmover.com>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Larry McVoy <lm@bitmover.com>
   Date: Sat, 17 Aug 2002 17:55:17 -0700

   On Sun, Aug 18, 2002 at 12:03:24AM +0100, Ruth Ivimey-Cook wrote:
   > >> "When you take a 99-way UltraSPARC III machine and add a 100th processor, 
   > >> you get 94 percent linear scalability. You can't get 94 percent linear 
   > >> scalability on your first Intel chip. It's very, very hard to do, and they 
   > >> have not done it."
   > 
   > I've seen scientific reports of scalability that good in non-shared memory
   > computers (mostly in transputer arrays) where (with a scalable algorithm)
   > unless you got >90% you were doing something wrong.  However, if you insist on
   > sharing main memory, I still don't believe you can get anywhere near that...
   > IMO 30% is doing very well once past the first few CPUs.
   
   Please reconsider your opinion.  Both Sun and SGI scale past 100 CPUs on
   reasonable workloads in shared memory.  Where "reasonable" != easy to do.

Also consider that if you start having performed so badly in the
uniprocessor case like Solaris does, it doesn't take so much effort to
get good scalability percentages as you add cpus because there isn't
much to scale. :-)

To Sun's credit, they have on their side the fact that in the x86
world there still has never has been a very good large scale SMP
backplane as of yet.  At least not on the order of what you'd find
on one of Sun's big boxes.

But in the same breath this is what will kill Sun in the end.  Over
time, the commodity stuff inches closer and closer to what Sun's "high
end" is.
