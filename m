Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261238AbUKHVJz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261238AbUKHVJz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Nov 2004 16:09:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261228AbUKHVJr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Nov 2004 16:09:47 -0500
Received: from mailhost.tue.nl ([131.155.2.7]:49677 "EHLO pastinakel.tue.nl")
	by vger.kernel.org with ESMTP id S261238AbUKHVH6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Nov 2004 16:07:58 -0500
Date: Mon, 8 Nov 2004 22:07:51 +0100
From: Andries Brouwer <aebr@win.tue.nl>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: Andries Brouwer <Andries.Brouwer@cwi.nl>, torvalds@osdl.org, akpm@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ext2 docs
Message-ID: <20041108210751.GA2946@pclin040.win.tue.nl>
References: <20041108135541.GA23052@apps.cwi.nl> <20041108173007.GB2900@logos.cnet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041108173007.GB2900@logos.cnet>
User-Agent: Mutt/1.4.2i
X-Spam-DCC: CollegeOfNewCaledonia: mailhost.tue.nl 1189; Body=1 Fuz1=1 Fuz2=1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 08, 2004 at 03:30:07PM -0200, Marcelo Tosatti wrote:

> > +oldalloc			Enable the old block allocator. Orlov should
> > +				have better performance, we'd like to get some
> > +				feedback if it's the contrary for you.
> > +orlov			(*)	Use the Orlov block allocator.
> > +				(See http://lwn.net/Articles/14633/ and
> > +				http://lwn.net/Articles/14446/.)
> 
> Did you really mean to use the second link "14446" ? 
> 
> It points to a patch from Ted fixing a memory leak into the Orlov allocator,
> which is not very useful. 
> 
> You probably meant http://lwn.net/Articles/14447/, which contains the full
> Orlov ext3 patch?

No, not at all. I am a collector of information, and 14447 has nothing
at all, but 14446 documents the EXT2_TOPDIR_FL flag that is undocumented
in the kernel source. The flag can be set using chattr +T.

Andries
