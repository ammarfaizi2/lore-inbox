Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316667AbSEQTik>; Fri, 17 May 2002 15:38:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316669AbSEQTij>; Fri, 17 May 2002 15:38:39 -0400
Received: from pizda.ninka.net ([216.101.162.242]:48287 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S316667AbSEQTii>;
	Fri, 17 May 2002 15:38:38 -0400
Date: Fri, 17 May 2002 12:25:19 -0700 (PDT)
Message-Id: <20020517.122519.102199743.davem@redhat.com>
To: ak@muc.de
Cc: linux-kernel@vger.kernel.org, dipankar@in.ibm.com
Subject: Re: 16-CPU #s for lockfree rtcache (rt_rcu)
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <m37km2vaoz.fsf@averell.firstfloor.org>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Andi Kleen <ak@muc.de>
   Date: 17 May 2002 21:25:16 +0200

   "David S. Miller" <davem@redhat.com> writes:
   
   > Provide the data, it will be interesting.
   
   I bet the numbers would be much better if the x86 
   do_gettimeofday() was converted to a lockless version first ...
   Currently it is bouncing around its readlock for every incoming packet.

That is true.  But right now we are trying to analyze the effects of
his patch all by itself.
