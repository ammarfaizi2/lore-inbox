Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267493AbUHDW4I@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267493AbUHDW4I (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Aug 2004 18:56:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267454AbUHDW4I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Aug 2004 18:56:08 -0400
Received: from mail.kroah.org ([69.55.234.183]:4545 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S267493AbUHDWzs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Aug 2004 18:55:48 -0400
Date: Wed, 4 Aug 2004 15:38:36 -0700
From: Greg KH <greg@kroah.com>
To: David Woodhouse <dwmw2@infradead.org>
Cc: dsaxena@plexity.net, linux-kernel@vger.kernel.org, ralf@linux-mips.org,
       akpm@osdl.org
Subject: Re: [PATCH][5/3][ARM] PCI quirks update for ARM
Message-ID: <20040804223835.GA10284@kroah.com>
References: <1091554419.4383.1611.camel@hades.cambridge.redhat.com> <20040803193716.GA16737@plexity.net> <1091625077.4383.2728.camel@hades.cambridge.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1091625077.4383.2728.camel@hades.cambridge.redhat.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 04, 2004 at 02:11:18PM +0100, David Woodhouse wrote:
> On Tue, 2004-08-03 at 12:37 -0700, Deepak Saxena wrote:
> > On Aug 03 2004, at 18:33, David Woodhouse was caught saying:
> > > It's a pain in the arse to set up platform-specific PCI quirks -- you
> > > have to put your platform-specific quirk into the generic (or at least
> > > the architecture) array. This patch fixes that, allowing you to
> > > DECLARE_PCI_FIXUP_HEADER() or DECLARE_PCI_FIXUP_FINAL() anywhere you
> > > like.
> > 
> > Good idea.  Following is ARM patch.
> 
> Thanks. I did the rest of the architectures too -- it's all at 
> bk://linux-mtd.bkbits.net/quirks-2.6
> 
> It probably doesn't want to go to Linus until after 2.6.8 is released,
> but perhaps we could put it in the -mm tree until then?

Thanks, I've pulled all of these into my pci bk tree, and will send them
off to Linus after 2.6.8 is out.

greg k-h
