Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932213AbWG3PA5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932213AbWG3PA5 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Jul 2006 11:00:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932325AbWG3PA4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Jul 2006 11:00:56 -0400
Received: from pfepc.post.tele.dk ([195.41.46.237]:33253 "EHLO
	pfepc.post.tele.dk") by vger.kernel.org with ESMTP id S932213AbWG3PA4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Jul 2006 11:00:56 -0400
Subject: Re: ipw3945 status
From: Kasper Sandberg <lkml@metanurb.dk>
To: Theodore Tso <tytso@mit.edu>
Cc: Matthew Garrett <mjg59@srcf.ucam.org>, Jan Dittmer <jdi@l4x.org>,
       Pavel Machek <pavel@suse.cz>, Jirka Lenost Benc <jbenc@suse.cz>,
       kernel list <linux-kernel@vger.kernel.org>,
       ipw2100-admin@linux.intel.com
In-Reply-To: <20060730145305.GE23279@thunk.org>
References: <20060730104042.GE1920@elf.ucw.cz>
	 <20060730112827.GA25540@srcf.ucam.org> <44CC993B.6070309@l4x.org>
	 <20060730114722.GA26046@srcf.ucam.org>
	 <1154264478.13635.22.camel@localhost>  <20060730145305.GE23279@thunk.org>
Content-Type: text/plain
Date: Sun, 30 Jul 2006 17:00:54 +0200
Message-Id: <1154271654.13635.33.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.0 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2006-07-30 at 10:53 -0400, Theodore Tso wrote:
> On Sun, Jul 30, 2006 at 03:01:17PM +0200, Kasper Sandberg wrote:
> > > Because it would involve a moderate rewriting of the driver, and we'd 
> > > have to carry a delta against Intel's code forever.
> >
> > without knowing this for sure, dont you think that if a largely changed
> > version of the driver appeared in the tree, intel may start developing
> > on that? cause then they wouldnt be the ones that "broke" compliance
> > with FCC(hah) by not doing binaryonly.
> 
> It's just as likely that their lawyers would tell them that they would
> have to pretend that the modifications don't exist at all, and not
> release any changes for any driver (like OpenBSD's) that bypassed the
> regulatory daemon.  The bigger worry would be if they decided that
> they couldn't risk supporting their current out-of-tree driver, and
> couldn't release Linux drivers for their softmac wireless devices in
> the future.
i think, that if no driver exists, there would be further incentive for
people to reverse engineer, as i also believe that if nvidia didnt
release their closed driver, there would be a project that would have
created a working driver for it(also supporting 3d)
> 
> Personally, I don't see why the requirement of an external daemon is
> really considered that evil.  We allow drivers that depend on firmware
> loaders, don't we?  I could imagine a device that required a digitally
thats entirely different, if some firmware image is loaded into a card,
thats that, but running a userspace daemon is just entirely different,
what would happen if intel for some reason stopped supporting earlier
cards(as hardware manufactureres do after some time), and linux
kernel/userspace gets some change, preventing the binary daemon from
running? then what? we have lost. but i do not believe any change can
really be made, that would mean the existing binary firmware images
could not be loaded into the hardware.
> signed message (using RSA) with a challenge/response protocol embedded
> inside that was necessary to configure said device, which is
> calculated in userspace and then passed down into the kernel to be
> installed into the device so that it could function.  Do we really
> want to consider that to be objectionable?
> 
> 						- Ted
> 

