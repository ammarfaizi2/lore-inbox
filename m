Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285049AbRLFIKq>; Thu, 6 Dec 2001 03:10:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285047AbRLFIK1>; Thu, 6 Dec 2001 03:10:27 -0500
Received: from pizda.ninka.net ([216.101.162.242]:23684 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S285045AbRLFIKM>;
	Thu, 6 Dec 2001 03:10:12 -0500
Date: Thu, 06 Dec 2001 00:09:32 -0800 (PST)
Message-Id: <20011206.000932.95504991.davem@redhat.com>
To: lm@bitmover.com
Cc: davidel@xmailserver.org, rusty@rustcorp.com.au, Martin.Bligh@us.ibm.com,
        riel@conectiva.com.br, lars.spam@nocrew.org, alan@lxorguk.ukuu.org.uk,
        hps@intermeta.de, linux-kernel@vger.kernel.org
Subject: Re: SMP/cc Cluster description
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20011206000216.B18034@work.bitmover.com>
In-Reply-To: <Pine.LNX.4.40.0112051915440.1644-100000@blue1.dev.mcafeelabs.com>
	<20011205.235617.23011309.davem@redhat.com>
	<20011206000216.B18034@work.bitmover.com>
X-Mailer: Mew version 2.0 on Emacs 21.0 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Larry McVoy <lm@bitmover.com>
   Date: Thu, 6 Dec 2001 00:02:16 -0800
   
   Err, Dave, that's *exactly* the point of the ccCluster stuff.  You get
   all that seperation for every data structure for free.  Think about
   it a bit.  Aren't you going to feel a little bit stupid if you do all
   this work, one object at a time, and someone can come along and do the
   whole OS in one swoop?  Yeah, I'm spouting crap, it isn't that easy,
   but it is much easier than the route you are taking.  

How does ccClusters avoid the file system namespace locking issues?
How do all the OS nodes see a consistent FS tree?

All the talk is about the "magic filesystem, thread it as much as you
want" and I'm telling you that is the fundamental problem, the
filesystem name space locking.
