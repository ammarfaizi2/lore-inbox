Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261939AbUKCW2M@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261939AbUKCW2M (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Nov 2004 17:28:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261950AbUKCW0j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Nov 2004 17:26:39 -0500
Received: from mail.kroah.org ([69.55.234.183]:32933 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261939AbUKCWWU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Nov 2004 17:22:20 -0500
Date: Wed, 3 Nov 2004 14:21:45 -0800
From: Greg KH <greg@kroah.com>
To: Pavel Machek <pavel@ucw.cz>
Cc: Andrew Morton <akpm@zip.com.au>,
       kernel list <linux-kernel@vger.kernel.org>
Subject: Re: Type-checking for pci layer
Message-ID: <20041103222145.GA30900@kroah.com>
References: <20041103214711.GA1885@elf.ucw.cz> <20041103215130.GA30621@kroah.com> <20041103221440.GG1574@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041103221440.GG1574@elf.ucw.cz>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 03, 2004 at 11:14:40PM +0100, Pavel Machek wrote:
> Hi!
> 
> > > This adds type-checking to PCI layer. u32 has been replaced with
> > > defines, so it is no longer easy to confuse it with system suspend
> > > level. Patrick included it in his power tree, but I guess direct
> > > merging to you (Andrew) is faster/easier way to go? Please apply,
> > > 
> > > 								Pavel
> > > 
> > > Acked-by: Greg KH <greg@kroah.com>
> > 
> > Woah, I've never acked this patch.  Let me push it through my pci trees,
> > or if Pat's already taken it, I'll get it from him through that path.
> 
> Did I misunderstandd email exchange? [I have full version with all
> headers, too...]. [I hope I sent same patch as last time... Hmm, only
> files were transposed]
> 
> Or did you just say that you agree with Patrick, nothing about
> original patch?

Ugh, there are just too many pm patches flying around.  Sorry, but yes,
I did ack this patch, but I did so to let Pat take it.  He's the one
collecting all of these changes.

Also, due to the fact that we are all still discussing (well, I'm
listening at least) how this is all going to work on the linux-pm
mailing list, I think it's quite early to be getting patches like these
into the tree right now.

So, in short, Andrew, don't apply it.  Let Pat collect them, and then
I'll channel them in through the proper paths.

thanks,

greg k-h
