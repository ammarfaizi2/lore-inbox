Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263568AbUBNXFQ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Feb 2004 18:05:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263595AbUBNXFP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Feb 2004 18:05:15 -0500
Received: from gate.crashing.org ([63.228.1.57]:44188 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S263568AbUBNXFH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Feb 2004 18:05:07 -0500
Subject: Re: [PATCH] back out fbdev sysfs support
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Christoph Hellwig <hch@lst.de>, James Simmons <jsimmons@infradead.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.58.0402140857520.13436@home.osdl.org>
References: <20040214165037.GA15985@lst.de>
	 <Pine.LNX.4.58.0402140857520.13436@home.osdl.org>
Content-Type: text/plain
Message-Id: <1076799884.4199.37.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Sun, 15 Feb 2004 10:04:45 +1100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2004-02-15 at 04:02, Linus Torvalds wrote:
> On Sat, 14 Feb 2004, Christoph Hellwig wrote:
> > 
> > <rant>
> > James, what about pushing the 2GB worth of fbdev driver fixes in your
> > tree to Linus so people actually get working fb support again instead
> > of adding new holes?
> 
> Sorry, but at this point I WOULD NOT EVEN TAKE IT ANY MORE.
> 
> That's just how I work: if somebody maintains his own tree and builds up a 
> lot of patches, that's _his_ problem. I'm not going to replace things 
> totally unless there is some really fundamental reason I would have to. 
> And quite frankly, the most common "fundamental reason" is that the 
> maintainer has not done his job.
> 
> I want controlled patches that do one thing at a time. Not a 2GB untested 
> dump.

I'll send you/andrew individually the drivers I control and the ones I
already fixed in james tree (5 or 6 drivers)

James: The fbcon & cursor changes must get in asap. There are races that
I fixed, without the changes, those races will be in 2.6.3.

Ben.

