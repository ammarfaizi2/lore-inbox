Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285383AbRLGCtq>; Thu, 6 Dec 2001 21:49:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285384AbRLGCtg>; Thu, 6 Dec 2001 21:49:36 -0500
Received: from rwcrmhc53.attbi.com ([204.127.198.39]:46244 "EHLO
	rwcrmhc53.attbi.com") by vger.kernel.org with ESMTP
	id <S285383AbRLGCtY>; Thu, 6 Dec 2001 21:49:24 -0500
Content-Type: text/plain; charset=US-ASCII
From: Adam Keys <akeys@post.cis.smu.edu>
To: Larry McVoy <lm@bitmover.com>
Subject: Re: SMP/cc Cluster description
Date: Thu, 6 Dec 2001 20:49:58 -0600
X-Mailer: KMail [version 1.3.2]
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20011206122116.H27589@work.bitmover.com> <20011206.150847.45874365.davem@redhat.com> <20011206152654.S27589@work.bitmover.com>
In-Reply-To: <20011206152654.S27589@work.bitmover.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20011207024919.MBX24045.rwcrmhc53.attbi.com@there>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On December 06, 2001 05:26, Larry McVoy wrote: > Yeah, it's possible that you 
could get something booting in a week but I > think it's a bit harder than 
that too. One idea that was kicked around > was to use Jeff's UML work and 
"boot" multiple UML's on top of a virtual > SMP. You get things to work there 
and then do a "port" to real hardware. > Kind of a cool idea if you ask me.

Point me in the right direction. After reading over your slides and SMP paper 
(still have the labs.pdf on my queue), it seemed to me that you could easily 
simulate what you want with lots of UML's talking to each other. I think you 
would need to create some kind of device that uses a file or a shared memory 
segment as the cluster's memory. Actually, I think that (shared memory) is 
how Jeff had intended on implementing SMP in UML anyway. At this point I 
don't think UML supports SMP though I know of at least one person who was 
attempting it.

Once said device would implemented, you could start working on the unique 
challenges ccClusters present. I guess this would be what you consider 
"bootstrapping", although I don't really know what that would entail at this 
point. Then you just need some bored college student :) to hack it out.

I've been negligent in following this mammoth link...cluebat me if you 
mentioned it somewhere upthread.

-- akk~
