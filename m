Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314546AbSHGW4A>; Wed, 7 Aug 2002 18:56:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314080AbSHGW4A>; Wed, 7 Aug 2002 18:56:00 -0400
Received: from kweetal.tue.nl ([131.155.2.7]:733 "EHLO kweetal.tue.nl")
	by vger.kernel.org with ESMTP id <S314553AbSHGW4A>;
	Wed, 7 Aug 2002 18:56:00 -0400
Date: Thu, 8 Aug 2002 00:59:39 +0200
From: Andries Brouwer <aebr@win.tue.nl>
To: Christoph Hellwig <hch@lst.de>, Kurt Garloff <kurt@garloff.de>,
       Linux kernel list <linux-kernel@vger.kernel.org>,
       Marcelo Tosatti <marcelo@conectiva.com.br>
Subject: Re: [PATCH] conditionally re-enable per-disk stats, convert to seq_file
Message-ID: <20020807225939.GA509@win.tue.nl>
References: <20020806160848.A2413@lst.de> <20020807210225.GD31622@nbkurt.etpnet.phys.tue.nl> <20020807211856.GB322@win.tue.nl> <20020808003325.A14578@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020808003325.A14578@lst.de>
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 08, 2002 at 12:33:25AM +0200, Christoph Hellwig wrote:
> On Wed, Aug 07, 2002 at 11:18:56PM +0200, Andries Brouwer wrote:
> > But why in /proc/partitions ?
> > Maybe /proc/partitions can go away eventually with all info available
> > under driverfs or so. But for the time being, /proc/partitions is used,
> > and some changes are planned to make identification of the devices
> > involved easier.
> > It is really ugly to stuff a lot of garbage into a file just because
> > it happens to exist already. If you want disk statistics, why not
> > put it in /proc/diskstatistics?
> 
> Because it's where existing tools expect it.  I agree with you that we
> want a nicer interface for 2.6, but give the userbase some time to
> prepare for a new interface.

You create a mess in the official kernel because your user space tools
are broken? And it is easier to patch the kernel than to fix them,
even though you'll have to fix them eventually?
And fixing these tools consists of replacing one filename?
