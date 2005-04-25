Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262391AbVDYBEk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262391AbVDYBEk (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Apr 2005 21:04:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262392AbVDYBEc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Apr 2005 21:04:32 -0400
Received: from mail.kroah.org ([69.55.234.183]:48544 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262391AbVDYBE0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Apr 2005 21:04:26 -0400
Date: Sun, 24 Apr 2005 18:03:51 -0700
From: Greg KH <greg@kroah.com>
To: Timur Tabi <timur.tabi@ammasso.com>
Cc: Andrew Morton <akpm@osdl.org>, hch@infradead.org, roland@topspin.com,
       hozer@hozed.org, linux-kernel@vger.kernel.org,
       openib-general@openib.org
Subject: Re: [PATCH][RFC][0/4] InfiniBand userspace verbs implementation
Message-ID: <20050425010351.GA21246@kroah.com>
References: <20050411180107.GF26127@kalmia.hozed.org> <52oeclyyw3.fsf@topspin.com> <20050411171347.7e05859f.akpm@osdl.org> <4263DEC5.5080909@ammasso.com> <20050418164316.GA27697@infradead.org> <4263E445.8000605@ammasso.com> <20050423194421.4f0d6612.akpm@osdl.org> <426BABF4.3050205@ammasso.com> <20050424205309.GA5386@kroah.com> <426C151F.3000407@ammasso.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <426C151F.3000407@ammasso.com>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 24, 2005 at 04:52:31PM -0500, Timur Tabi wrote:
> Greg KH wrote:
> 
> >You don't "support" i386 or ia64 or x86-64 or ppc64 systems?  What
> >hardware do you support? 
> 
> I've never seen or heard of any x86-32 or x86-64 system that supports 
> hot-swap RAM.

I know of at least 1 x86-32 box from a three-letter-named company with
this feature that has been shipping for a few _years_ now.  That box is
pretty much everywhere now, and I know that other versions of it are
also quite popular (despite the high cost...)

> Our hardware does not support PPC, and our software doesn't support
> ia-64.

Your hardware is just a pci card, right?  Why wouldn't it work on ppc64
and ia64 then?

> > And what about the fact that you are aiming to
> >get this code into mainline, right?  If not, why are you asking here?
> >:)
> 
> Well, our primary concern is getting our stuff to work.  Since 
> get_user_pages() doesn't work, but mlock() does, that's what we use.  I 
> don't know how to fix get_user_pages(), and I don't have the time right now 
> to figure it out.  I know that technically mlock() is not the right way to 
> do it, and so we're not going to be submitting our code for the mainline 
> until get_user_pages() works and our code uses it instead of mlock().

Wait, what _is_ "your stuff"?  The open-ib code?  Or some other, private
fork?  Any pointers to this stuff?

thanks,

greg k-h
