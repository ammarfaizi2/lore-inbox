Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262241AbTCHW2o>; Sat, 8 Mar 2003 17:28:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262248AbTCHW2o>; Sat, 8 Mar 2003 17:28:44 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:55052 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S262241AbTCHW2o>; Sat, 8 Mar 2003 17:28:44 -0500
Date: Sat, 8 Mar 2003 14:36:53 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Christoph Hellwig <hch@infradead.org>,
       Joel Becker <Joel.Becker@oracle.com>, Greg KH <greg@kroah.com>,
       <Andries.Brouwer@cwi.nl>, <akpm@digeo.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] register_blkdev
In-Reply-To: <1047166634.26807.50.camel@irongate.swansea.linux.org.uk>
Message-ID: <Pine.LNX.4.44.0303081431030.19716-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 8 Mar 2003, Alan Cox wrote:
> 
> No vendor I have spoken too intends to care what Linus thinks about it.
> Linus tried this in 2.4. We all got together to create a numbering
> repository instead of letting Linus do it.

I was right, though. Look at how useless the fixed numbers are getting.

I certainly agree that we'll need to open up the number space, but I 
really do think that the way to _manage_ it is something like what Greg 
pointed to - dynamic tols with "rules" on allocation, instead of the 
stupid static manual assignment thing.

We're pretty close to it already. I thought some Linux vendors are already 
starting to pick up on the hotplugging tools, simply because there are no 
real alternatives.

And once you do it that way, the static numbers are meaningless. And good 
riddance.

		Linus

