Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964891AbWDDD66@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964891AbWDDD66 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Apr 2006 23:58:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751473AbWDDD66
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Apr 2006 23:58:58 -0400
Received: from mail.kroah.org ([69.55.234.183]:7321 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1751467AbWDDD65 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Apr 2006 23:58:57 -0400
Date: Mon, 3 Apr 2006 20:52:55 -0700
From: Greg KH <gregkh@suse.de>
To: Andrew Morton <akpm@osdl.org>
Cc: hjlipp@web.de, kkeil@suse.de, i4ldeveloper@listserv.isdn4linux.de,
       linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       tilman@imap.cc
Subject: Re: [PATCH 0/13] isdn4linux: Siemens Gigaset drivers update
Message-ID: <20060404035255.GA12156@suse.de>
References: <gigaset307x.2006.04.04.001.0@hjlipp.my-fqdn.de> <20060404025818.GA12076@suse.de> <20060403201132.3d0f51e7.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060403201132.3d0f51e7.akpm@osdl.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 03, 2006 at 08:11:32PM -0700, Andrew Morton wrote:
> Greg KH <gregkh@suse.de> wrote:
> >
> > On Tue, Apr 04, 2006 at 02:00:24AM +0200, Hansjoerg Lipp wrote:
> > > The following series of patches contains updates to the Siemens Gigaset
> > > drivers suggested by various reviewers on lkml. These should go into
> > > 2.6.17 if at all possible. Please apply in order.
> > 
> > Hm, the big merge window for 2.6.17 is past.  If this is a
> > single-driver-only update, it might be argued that this should be
> > accepted into 2.6.17, but only after it has had a few weeks of testing
> > in -mm.  After a few weeks being in -mm however, it will be too late to
> > go into 2.6.17.
> > 
> > So, is 2.6.18 ok?
> > 
> 
> This driver will be new-in-2.6.17.  Usually after a feature is first merged
> in mainline there will be a string of fairly significant updates from the
> original development team and from others as things get sorted out.
> 
> These patches are almost always good and they're things which we want to
> get into the next release, so I tend to ignore the merging rules in this
> case, particularly around the -rc1-rc2 timeframe when we have lots of
> testing/eyeballing time to go.
> 
> Plus these patches provide things which were supposed to be in the initial
> merge, only nobody told us..

Ah, ok, I didn't realize this was that same driver.  So in that case,
yes, I agree with you, these should go in.

thanks,

greg k-h
