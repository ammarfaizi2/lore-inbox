Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261169AbULWG4p@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261169AbULWG4p (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Dec 2004 01:56:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261171AbULWG4p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Dec 2004 01:56:45 -0500
Received: from gate.crashing.org ([63.228.1.57]:37573 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S261169AbULWG4k (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Dec 2004 01:56:40 -0500
Subject: Re: /sys/block vs. /sys/class/block
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: David Weinehall <tao@debian.org>
Cc: Greg KH <greg@kroah.com>, Stephen Rothwell <sfr@canb.auug.org.au>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       Patrick Mochel <mochel@digitalimplant.org>, Jens Axboe <axboe@suse.de>
In-Reply-To: <20041223063938.GA27718@khan.acc.umu.se>
References: <1103526532.5320.33.camel@gaston>
	 <20041220224950.GA21317@kroah.com> <1103612870.21771.22.camel@gaston>
	 <20041222153449.46da0671.sfr@canb.auug.org.au>
	 <20041222062057.GC31513@kroah.com> <20041223063938.GA27718@khan.acc.umu.se>
Content-Type: text/plain
Date: Thu, 23 Dec 2004 07:55:33 +0100
Message-Id: <1103784933.29975.6.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > But I guess I should ask, who really cares about this, so late in the
> > sysfs structure game?  Is /sys/block/ really a big problem for anyone?
> > And if it is, I'd much rather someone make the required driver core
> > changes to fix this up properly, than just put a symlink to paper over
> > some userspace issue.
> 
> Maybe because *for once* it'd be nice to actually have inconsistencies
> gotten rid of in their relative infancy instead of waiting 10 years
> and then having to explain them as existing only for hysterical
> raisins...

Agreed.

Ben.


