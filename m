Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262756AbUEWMAs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262756AbUEWMAs (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 23 May 2004 08:00:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262766AbUEWMAs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 May 2004 08:00:48 -0400
Received: from willy.net1.nerim.net ([62.212.114.60]:25867 "EHLO
	willy.net1.nerim.net") by vger.kernel.org with ESMTP
	id S262756AbUEWMAo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 23 May 2004 08:00:44 -0400
Date: Sun, 23 May 2004 13:59:36 +0200
From: Willy Tarreau <willy@w.ods.org>
To: linux-kernel@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
       akpm@osdl.org
Subject: Re: i486 emu in mainline?
Message-ID: <20040523115936.GB16726@alpha.home.local>
References: <20040522234059.GA3735@infradead.org> <20040523082912.GA16071@alpha.home.local> <20040523105130.GA588@samarkand.rivenstone.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040523105130.GA588@samarkand.rivenstone.net>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 23, 2004 at 06:51:30AM -0400, Joseph Fannin wrote:
> On Sun, May 23, 2004 at 10:29:12AM +0200, Willy Tarreau wrote:
> 
> > On Sun, May 23, 2004 at 01:40:59AM +0200, Christoph Hellwig wrote:
> >> These days gcc uses i486+ only instruction by default in libstdc++ so
> >> most modern distros wouldn't work on i386 cpus anymore.  To make it work
> >> again Debian merged Willy Tarreau's patch to trap those and emulate them
> >> on real i386 cpus.  The patch is extremely non-invasive and would
> >> certainly be usefull for mainline.  Any reason not to include it?
> 
> 
> >   - I couldn't emulate locks, so this will break on SMP systems, and so
> >     will it if you need to access some memory share with an external
> >     microcontroller or something like that.
> 
>     Does this mean that programs that use the NPTL will work on
> non-SMP 386s?

I have no idea. Why would NPTL not work on i386 ?

Willy

