Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265146AbTLKQRr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Dec 2003 11:17:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265147AbTLKQRr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Dec 2003 11:17:47 -0500
Received: from zxa8020.lanisdn-gte.net ([206.46.31.146]:40657 "EHLO
	links.magenta.com") by vger.kernel.org with ESMTP id S265146AbTLKQRo
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Dec 2003 11:17:44 -0500
Date: Thu, 11 Dec 2003 11:17:41 -0500
From: moth@magenta.com
To: linux-kernel@vger.kernel.org
Subject: Re: PROBLEM: Linux 2.6.0-test11 only lets me use 1GB out of 2GB ram.
Message-ID: <20031211111741.H28449@links.magenta.com>
References: <C033B4C3E96AF74A89582654DEC664DB0672F1@aruba.maner.org> <3FD7FCF5.7030109@cyberone.com.au> <3FD801B3.7080604@wmich.edu> <20031211054111.GX8039@holomorphy.com> <20031211094148.G28449@links.magenta.com> <20031211150011.GF8039@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20031211150011.GF8039@holomorphy.com>; from wli@holomorphy.com on Thu, Dec 11, 2003 at 07:00:11AM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 11, 2003 at 07:00:11AM -0800, William Lee Irwin III wrote:
> You should probably ignore this thread. It's probably not relevant to
> you.

Ok, thanks.  My mistake.

> > [In my fantasies, I was thinking that the system came up with only 1GB of
> > the memory easily usable, and that the lack of support for my hardware
> > meant that it couldn't be properly reconfigured.  But I recognize that
> > I haven't spent the time researching this to see if in fact this is
> > the case.]
> 
> Highmem support gets you this on ia32. Other architectures can support it
> with less overhead.

Are there docs on this?

> > I am in the process of bringing up an cross compilation environment for
> > amd64 -- I need to do that anyways -- and I'll try building a real 64
> > bit kernel to see if that helps any.  If that doesn't, I guess I'll try
> > a couple 4G highmem kernels (one 64 bit, one 32 bit).  If nothing else,
> > that will eat up some time...
> 
> If you have such a cpu why are you bothering with highmem (or wondering
> if > 2GB is supported)?

I'm not wondering if > 2GB is supported.  I'm trying to get 2GB
to work (and I'm having a problem -- perhaps because I believe
Documentation/memory.txt doesn't cover the issues I'm facing).

I've not yet bothered with highmem, but I will if building a 64 bit
kernel doesn't get me access to 2GB.

Does that answer your question?

Thanks,

-- 
Raul
