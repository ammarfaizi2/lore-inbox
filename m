Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262754AbULQGFC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262754AbULQGFC (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Dec 2004 01:05:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262755AbULQGFC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Dec 2004 01:05:02 -0500
Received: from news.suse.de ([195.135.220.2]:1997 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S262754AbULQGE4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Dec 2004 01:04:56 -0500
Date: Fri, 17 Dec 2004 07:04:56 +0100
From: Andi Kleen <ak@suse.de>
To: Ian Pratt <Ian.Pratt@cl.cam.ac.uk>
Cc: Andrew Morton <akpm@osdl.org>, ak@suse.de, alan@lxorguk.ukuu.org.uk,
       riel@redhat.com, linux-kernel@vger.kernel.org, Steven.Hand@cl.cam.ac.uk,
       Christian.Limpach@cl.cam.ac.uk, Keir.Fraser@cl.cam.ac.uk
Subject: Re: arch/xen is a bad idea
Message-ID: <20041217060456.GD12049@wotan.suse.de>
References: <20041216130330.6f44c244.akpm@osdl.org> <E1Cf3Ib-0006dM-00@mta1.cl.cam.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1Cf3Ib-0006dM-00@mta1.cl.cam.ac.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 16, 2004 at 09:36:36PM +0000, Ian Pratt wrote:
> > Ian Pratt <Ian.Pratt@cl.cam.ac.uk> wrote:
> > >
> > > I'm not convinced that maintaining xen/i386 in its current form
> > >  is going to be as hard as Andi thinks. We already share many
> > >  files unmodified from i386.
> > 
> > How are they shared?  Inclusion, symlinks, makefile references or
> 
> The makefile creates symlinks. 

That's deprecated because it breaks with separate objdirs (make O=/other/dir) 
See the x86-64 makefiles on how to do it properly. 

-Andi
