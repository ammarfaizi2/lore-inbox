Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265800AbSKAWa3>; Fri, 1 Nov 2002 17:30:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265801AbSKAWa3>; Fri, 1 Nov 2002 17:30:29 -0500
Received: from air-2.osdl.org ([65.172.181.6]:18850 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S265800AbSKAWa2>;
	Fri, 1 Nov 2002 17:30:28 -0500
Message-Id: <200211012236.gA1MaqT20507@mail.osdl.org>
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
To: Hans Reiser <reiser@namesys.com>
cc: linux-kernel@vger.kernel.org, reiserfs-list@namesys.com,
       Reiserfs developers mail-list <Reiserfs-Dev@namesys.com>,
       Oleg Drokin <green@namesys.com>, Nikita Danilov <Nikita@namesys.com>,
       cliffw@osdl.org
Subject: Re: We need help benchmarking and debugging reiser4 
In-Reply-To: Message from Hans Reiser <reiser@namesys.com> 
   of "Wed, 30 Oct 2002 11:30:31 +0300." <3DBF98A7.8060906@namesys.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Fri, 01 Nov 2002 14:36:52 -0800
From: Cliff White <cliffw@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Can some of you help us by doing such things as replicating our 
> benchmarks, and helping us debug it as we enter the last stretch before 
> Halloween?
> 

We are interested in helping, but i haven't seen the follow-up mail 
mentioned below - if you could send us some more specifics, we'd be
glad to join the fun.
cliffw
OSDL

> Nikita and Oleg will describe the details of what to do to replicate the 
> benchmarks, please be sure to use reiser4 readdir order for writes to 
> reiser4 (that means don't use tarballs made from ext2 (Remember that 
> writes determine subsequent read performance.)), and to use the latest 
> hard drives and fast processors with udma 5 turned on.  We are quite 
> sensitive to transfer speed since we do a good job of avoiding seeks.  
> We are sensitive to readdir order because we sort directory entries 
> (which is necessary for having efficient large directory lookups).   In 
> reiser4.1 we will ship a repacker, and then it won't matter what order 
> you do writes in so long as the repacker gets a chance to run at night.  
> 
> -- 
> Hans
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 


