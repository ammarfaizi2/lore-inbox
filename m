Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274215AbRIYW1R>; Tue, 25 Sep 2001 18:27:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274388AbRIYW1L>; Tue, 25 Sep 2001 18:27:11 -0400
Received: from pizda.ninka.net ([216.101.162.242]:53396 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S274215AbRIYW1C>;
	Tue, 25 Sep 2001 18:27:02 -0400
Date: Tue, 25 Sep 2001 15:26:55 -0700 (PDT)
Message-Id: <20010925.152655.85393753.davem@redhat.com>
To: gerrit@us.ibm.com
Cc: riel@conectiva.com.br, marcelo@conectiva.com.br, andrea@suse.de,
        torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: Re: Locking comment on shrink_caches() 
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <200109252215.f8PMFDa02034@eng2.beaverton.ibm.com>
In-Reply-To: <Pine.LNX.4.33L.0109251723160.26091-100000@duckman.distro.conectiva>
	<200109252215.f8PMFDa02034@eng2.beaverton.ibm.com>
X-Mailer: Mew version 2.0 on Emacs 21.0 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Gerrit Huizenga <gerrit@us.ibm.com>
   Date: Tue, 25 Sep 2001 15:15:13 PDT

   I'm very curious as to what workloads are showing pagecache_lock as
   a bottleneck.  We haven't noticed this particular bottleneck in most
   of the workloads we are running.  Is there a good workload that shows
   this type of load?
   
Again, I defer to Ingo for specifics, but essentially something like
specweb99 where the whole dataset fits in memory.

Franks a lot,
David S. Miller
davem@redhat.com
