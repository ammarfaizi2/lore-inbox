Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262838AbUBNRHj (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Feb 2004 12:07:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262794AbUBNRGS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Feb 2004 12:06:18 -0500
Received: from verein.lst.de ([212.34.189.10]:43226 "EHLO mail.lst.de")
	by vger.kernel.org with ESMTP id S262686AbUBNRGJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Feb 2004 12:06:09 -0500
Date: Sat, 14 Feb 2004 18:06:00 +0100
From: Christoph Hellwig <hch@lst.de>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Christoph Hellwig <hch@lst.de>, jsimmons@infradead.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] back out fbdev sysfs support
Message-ID: <20040214170600.GA16147@lst.de>
Mail-Followup-To: Christoph Hellwig <hch@lst.de>,
	Linus Torvalds <torvalds@osdl.org>, jsimmons@infradead.org,
	linux-kernel@vger.kernel.org
References: <20040214165037.GA15985@lst.de> <Pine.LNX.4.58.0402140857520.13436@home.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0402140857520.13436@home.osdl.org>
User-Agent: Mutt/1.3.28i
X-Spam-Score: -4.901 () BAYES_00
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 14, 2004 at 09:02:12AM -0800, Linus Torvalds wrote:
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

Hey, that's not what I meant.  Sorry for the silly language.  I'm the
last one to argue in favour of a single big diff.  But all the driver
fixes are easily separatable, in fact benh probably still has all the
individual diffs for all the mac drivers.

What I meant is that the FB maintainer should try to get the existing
fixes merged before adding dubious features.

