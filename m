Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964987AbWDDDMe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964987AbWDDDMe (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Apr 2006 23:12:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964988AbWDDDMe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Apr 2006 23:12:34 -0400
Received: from smtp.osdl.org ([65.172.181.4]:12510 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S964987AbWDDDMd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Apr 2006 23:12:33 -0400
Date: Mon, 3 Apr 2006 20:11:32 -0700
From: Andrew Morton <akpm@osdl.org>
To: Greg KH <gregkh@suse.de>
Cc: hjlipp@web.de, kkeil@suse.de, i4ldeveloper@listserv.isdn4linux.de,
       linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       tilman@imap.cc
Subject: Re: [PATCH 0/13] isdn4linux: Siemens Gigaset drivers update
Message-Id: <20060403201132.3d0f51e7.akpm@osdl.org>
In-Reply-To: <20060404025818.GA12076@suse.de>
References: <gigaset307x.2006.04.04.001.0@hjlipp.my-fqdn.de>
	<20060404025818.GA12076@suse.de>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH <gregkh@suse.de> wrote:
>
> On Tue, Apr 04, 2006 at 02:00:24AM +0200, Hansjoerg Lipp wrote:
> > The following series of patches contains updates to the Siemens Gigaset
> > drivers suggested by various reviewers on lkml. These should go into
> > 2.6.17 if at all possible. Please apply in order.
> 
> Hm, the big merge window for 2.6.17 is past.  If this is a
> single-driver-only update, it might be argued that this should be
> accepted into 2.6.17, but only after it has had a few weeks of testing
> in -mm.  After a few weeks being in -mm however, it will be too late to
> go into 2.6.17.
> 
> So, is 2.6.18 ok?
> 

This driver will be new-in-2.6.17.  Usually after a feature is first merged
in mainline there will be a string of fairly significant updates from the
original development team and from others as things get sorted out.

These patches are almost always good and they're things which we want to
get into the next release, so I tend to ignore the merging rules in this
case, particularly around the -rc1-rc2 timeframe when we have lots of
testing/eyeballing time to go.

Plus these patches provide things which were supposed to be in the initial
merge, only nobody told us..
