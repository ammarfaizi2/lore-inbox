Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261548AbULBCcU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261548AbULBCcU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Dec 2004 21:32:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261573AbULBCcU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Dec 2004 21:32:20 -0500
Received: from MAIL.13thfloor.at ([212.16.62.51]:20361 "EHLO mail.13thfloor.at")
	by vger.kernel.org with ESMTP id S261548AbULBCcO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Dec 2004 21:32:14 -0500
Date: Thu, 2 Dec 2004 03:32:13 +0100
From: Herbert Poetzl <herbert@13thfloor.at>
To: Marek Habersack <grendel@caudium.net>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Peter Chubb <peter@chubb.wattle.id.au>, Jeff Dike <jdike@addtoit.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: user- vs kernel-level resource sandbox for Linux?
Message-ID: <20041202023213.GA12857@mail.13thfloor.at>
Mail-Followup-To: Marek Habersack <grendel@caudium.net>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Peter Chubb <peter@chubb.wattle.id.au>,
	Jeff Dike <jdike@addtoit.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20041129101919.GB9419@beowulf.thanes.org> <200411292000.iATK0qOF004026@ccure.user-mode-linux.org> <16811.40687.892939.304185@wombat.chubb.wattle.id.au> <20041130023947.GI5378@beowulf.thanes.org> <1101840505.25628.105.camel@localhost.localdomain> <20041130204708.GB14080@beowulf.thanes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041130204708.GB14080@beowulf.thanes.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 30, 2004 at 09:47:08PM +0100, Marek Habersack wrote:
> On Tue, Nov 30, 2004 at 06:48:27PM +0000, Alan Cox scribbled:
> > On Maw, 2004-11-30 at 02:39, Marek Habersack wrote:
> > > per-process isn't enough. I specifically need something to limit the memory
> > > usage on a more global scale - per user ID or per process group or a similar
> > > way of grouping related processes. That's the only way to tame processes
> > > like apache. At this point the option I'm considering is Xen, unless I can
> > > find a userland solution to the problem...
> > 
> > I'd suggest playing with Xen - its very efficient and it really does
> > come close to perfect constraint for resources.
> That's my current impression. I also considered writing a simple kernel
> module to intercept sys_brk, but that seemed to be a bit clumsy. We have
> been running a test installation of Xen with 2 VMs under quite high load and
> it performs outstandingly well in "laboratory environment".
> Also, I seem to recall there used to be a patch for the linux kernel to implement 
> BSD-like jail environment, which would suit my purpose too, do you know what happened
> to the project/where it can be found? It would be a great addition to the
> kernel, just like the Zones in Solaris 10 are (which are based on the BSD
> jail concept as well).

maybe this might be of interest for you:

  http://linux-vserver.org/
  http://linux-vserver.org/Linux-VServer-Paper

best,
Herbert

> regards,
> 
> marek


