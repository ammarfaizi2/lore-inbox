Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965908AbWCTQwo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965908AbWCTQwo (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Mar 2006 11:52:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965914AbWCTQwo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Mar 2006 11:52:44 -0500
Received: from stat9.steeleye.com ([209.192.50.41]:52356 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S965908AbWCTQwn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Mar 2006 11:52:43 -0500
Subject: Re: [PATCHSET] block: fix PIO cache coherency bug
From: James Bottomley <James.Bottomley@SteelEye.com>
To: "Randy.Dunlap" <rdunlap@xenotime.net>
Cc: htejun@gmail.com, davem@redhat.com, axboe@suse.de, bzolnier@gmail.com,
       james.steward@dynamicratings.com, jgarzik@pobox.com,
       linux-kernel@vger.kernel.org, mattjreimer@gmail.com,
       rmk+lkml@arm.linux.org.uk
In-Reply-To: <20060320085008.d13dd57e.rdunlap@xenotime.net>
References: <11371658562541-git-send-email-htejun@gmail.com>
	 <1137167419.3365.5.camel@mulgrave>
	 <20060113182035.GC25849@flint.arm.linux.org.uk>
	 <1137177324.3365.67.camel@mulgrave>
	 <20060113190613.GD25849@flint.arm.linux.org.uk>
	 <20060222082732.GA24320@htj.dyndns.org>
	 <1142871172.3283.17.camel@mulgrave.il.steeleye.com>
	 <20060320085008.d13dd57e.rdunlap@xenotime.net>
Content-Type: text/plain
Date: Mon, 20 Mar 2006 10:52:06 -0600
Message-Id: <1142873526.3283.30.camel@mulgrave.il.steeleye.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-03-20 at 08:50 -0800, Randy.Dunlap wrote:
> > If everyone's happy with this approach, I'll take it over to
> linux-arch.
> 
> why is that the right place for it?

Because the implementation details of flush_kernel_dcache_page() are
arch specific, so linux-arch is the list to notify about it.

James


