Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262153AbUDJXOq (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Apr 2004 19:14:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262119AbUDJXOq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Apr 2004 19:14:46 -0400
Received: from mlf.linux.rulez.org ([192.188.244.13]:49168 "EHLO
	mlf.linux.rulez.org") by vger.kernel.org with ESMTP id S262153AbUDJXOp
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Apr 2004 19:14:45 -0400
Date: Sun, 11 Apr 2004 01:14:42 +0200 (MEST)
From: Szakacsits Szabolcs <szaka@sienet.hu>
To: viro@parcelfarce.linux.theplanet.co.uk
Cc: Andries Brouwer <aebr@win.tue.nl>, fledely <fledely@bgumail.bgu.ac.il>,
       linux-ntfs-dev@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: Accessing odd last partition sector (was: [Linux-NTFS-Dev] mkntfs
 dirty volume marking)
In-Reply-To: <20040410225514.GX31500@parcelfarce.linux.theplanet.co.uk>
Message-ID: <Pine.LNX.4.21.0404110104230.840-100000@mlf.linux.rulez.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sat, 10 Apr 2004 viro@parcelfarce.linux.theplanet.co.uk wrote:
> On Sun, Apr 11, 2004 at 12:23:47AM +0200, Szakacsits Szabolcs wrote:
>  
> > Just one question, in the most common cases the block size ends up between
> > 512 and 4096 bytes. Depending on how this block size used, it can have a
> > significant impact on performance (e.g. 512 vs 4096). Is this true or is
> > it used to be performance independent?
> 
> Resulting requests are immediately merged anyway.  Yes, we get more bio
> sitting on top of the merged request; however, it's heavily IO-dominated
> and I would be surprised if you really saw any noticable overhead in that
> situation.

Thanks, I'll test it in the near future unless somebody does it earlier. 

I have my test stuff but I'm interested of you could suggest specific ones
that might exhibit/trigger the overhead if it exists at all.

	Szaka

