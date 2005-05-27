Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262636AbVE0WUO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262636AbVE0WUO (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 May 2005 18:20:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262631AbVE0WTI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 May 2005 18:19:08 -0400
Received: from cantor2.suse.de ([195.135.220.15]:62439 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S262611AbVE0WPV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 May 2005 18:15:21 -0400
Date: Sat, 28 May 2005 00:15:16 +0200
From: Olaf Hering <olh@suse.de>
To: Alexey Dobriyan <adobriyan@gmail.com>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: update-comment-about-gzip-scratch-size.patch added to -mm tree
Message-ID: <20050527221516.GA8259@suse.de>
References: <200505272149.j4RLnKZW011173@shell0.pdx.osdl.net> <200505280215.01241.adobriyan@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <200505280215.01241.adobriyan@gmail.com>
X-DOS: I got your 640K Real Mode Right Here Buddy!
X-Homeland-Security: You are not supposed to read this line! You are a terrorist!
User-Agent: Mutt und vi sind doch schneller als Notes (und GroupWise)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 On Sat, May 28, Alexey Dobriyan wrote:

> On Saturday 28 May 2005 01:50, akpm@osdl.org wrote:
> > From: Olaf Hering <olh@suse.de>
> > 
> > fix a comment about the array size.
> 
> > --- 25/arch/ppc/boot/openfirmware/chrpmain.c~update-comment-about-gzip-scratch-size
> > +++ 25-akpm/arch/ppc/boot/openfirmware/chrpmain.c
> 
> >  #define SCRATCH_SIZE	(128 << 10)
> >  
> > -static char scratch[SCRATCH_SIZE];	/* 1MB of scratch space for gunzip */
> > +static char scratch[SCRATCH_SIZE];	/* 128k of scratch space for gunzip */
> 
> How about this?

Better remove the comment.
Or replace it with an URL to /. where we annouce the existence of scratch space for gzip.
