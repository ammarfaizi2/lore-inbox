Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315389AbSEGJGQ>; Tue, 7 May 2002 05:06:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315393AbSEGJGP>; Tue, 7 May 2002 05:06:15 -0400
Received: from imladris.infradead.org ([194.205.184.45]:7428 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S315389AbSEGJGP>; Tue, 7 May 2002 05:06:15 -0400
Date: Tue, 7 May 2002 10:02:32 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Greg KH <greg@kroah.com>
Cc: torvalds@transmeta.com, mochel@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [BK PATCH] PCI reorg changes for 2.5.14
Message-ID: <20020507100232.A28174@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Greg KH <greg@kroah.com>, torvalds@transmeta.com, mochel@osdl.org,
	linux-kernel@vger.kernel.org
In-Reply-To: <20020506222506.GA8718@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 06, 2002 at 03:25:07PM -0700, Greg KH wrote:
> Linus,
> 
> Here is a series of changesets that reorganize the core and i386 PCI
> files.  It splits the current big files up into smaller pieces,
> according to the different function and platform type (removing lots of
> #ifdefs in the process.)  Pat Mochel did 99.9% of this work, and I've
> tested it out and forward ported it to your most recent kernel version.
> 
> Due to there not being a active PCI maintainer (Martin Mares has
> abdicated the maintainership for 2.5 work), would you please apply these
> to your tree?
> 
> Pull from:  bk://ldm.bkbits.net/linux-2.5-pci

I think arch/i386/pci would be more appropinquate than arch/i386/kernel/pci.

