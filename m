Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261952AbUKCWyf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261952AbUKCWyf (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Nov 2004 17:54:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261890AbUKCWwo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Nov 2004 17:52:44 -0500
Received: from gprs214-112.eurotel.cz ([160.218.214.112]:28547 "EHLO
	amd.ucw.cz") by vger.kernel.org with ESMTP id S261925AbUKCWtC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Nov 2004 17:49:02 -0500
Date: Wed, 3 Nov 2004 23:48:42 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Greg KH <greg@kroah.com>
Cc: Andrew Morton <akpm@zip.com.au>,
       kernel list <linux-kernel@vger.kernel.org>
Subject: Re: Type-checking for pci layer
Message-ID: <20041103224842.GH1574@elf.ucw.cz>
References: <20041103214711.GA1885@elf.ucw.cz> <20041103215130.GA30621@kroah.com> <20041103221440.GG1574@elf.ucw.cz> <20041103222145.GA30900@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041103222145.GA30900@kroah.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!
> > > > This adds type-checking to PCI layer. u32 has been replaced with
> > > > defines, so it is no longer easy to confuse it with system suspend
> > > > level. Patrick included it in his power tree, but I guess direct
> > > > merging to you (Andrew) is faster/easier way to go? Please apply,
> > > > 
> > > > 								Pavel
> > > > 
> > > > Acked-by: Greg KH <greg@kroah.com>
> > > 
> > > Woah, I've never acked this patch.  Let me push it through my pci trees,
> > > or if Pat's already taken it, I'll get it from him through that path.
> > 
> > Did I misunderstandd email exchange? [I have full version with all
> > headers, too...]. [I hope I sent same patch as last time... Hmm, only
> > files were transposed]
> > 
> > Or did you just say that you agree with Patrick, nothing about
> > original patch?
> 
> Ugh, there are just too many pm patches flying around.  Sorry, but yes,
> I did ack this patch, but I did so to let Pat take it.  He's the one
> collecting all of these changes.
> 
> Also, due to the fact that we are all still discussing (well, I'm
> listening at least) how this is all going to work on the linux-pm
> mailing list, I think it's quite early to be getting patches like these
> into the tree right now.
> 
> So, in short, Andrew, don't apply it.  Let Pat collect them, and then
> I'll channel them in through the proper paths.

Ok, I was hoping this change could go in because it does not change
any code and David was already posting changes that should better be
done relative to this one.

[Problem with Pat's tree is that I'm unable to access it :-(].
								Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
