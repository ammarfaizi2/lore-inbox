Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932339AbWG3QJw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932339AbWG3QJw (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Jul 2006 12:09:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932335AbWG3QJw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Jul 2006 12:09:52 -0400
Received: from pfepa.post.tele.dk ([195.41.46.235]:39917 "EHLO
	pfepa.post.tele.dk") by vger.kernel.org with ESMTP id S932339AbWG3QJv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Jul 2006 12:09:51 -0400
Subject: Re: ipw3945 status
From: Kasper Sandberg <lkml@metanurb.dk>
To: Theodore Tso <tytso@mit.edu>
Cc: Matthew Garrett <mjg59@srcf.ucam.org>, Jan Dittmer <jdi@l4x.org>,
       Pavel Machek <pavel@suse.cz>, Jirka Lenost Benc <jbenc@suse.cz>,
       kernel list <linux-kernel@vger.kernel.org>,
       ipw2100-admin@linux.intel.com
In-Reply-To: <20060730150944.GG23279@thunk.org>
References: <20060730104042.GE1920@elf.ucw.cz>
	 <20060730112827.GA25540@srcf.ucam.org> <44CC993B.6070309@l4x.org>
	 <20060730114722.GA26046@srcf.ucam.org>
	 <1154264478.13635.22.camel@localhost> <20060730145305.GE23279@thunk.org>
	 <1154271654.13635.33.camel@localhost>  <20060730150944.GG23279@thunk.org>
Content-Type: text/plain
Date: Sun, 30 Jul 2006 18:09:40 +0200
Message-Id: <1154275780.13635.36.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.0 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2006-07-30 at 11:09 -0400, Theodore Tso wrote:
> On Sun, Jul 30, 2006 at 05:00:54PM +0200, Kasper Sandberg wrote:
> > thats entirely different, if some firmware image is loaded into a card,
> > thats that, but running a userspace daemon is just entirely different,
> > what would happen if intel for some reason stopped supporting earlier
> > cards(as hardware manufactureres do after some time), and linux
> > kernel/userspace gets some change, preventing the binary daemon from
> > running? then what? we have lost.
> 
> Um, last time I checked we could still run some *minix* binaries from
> before Linux was born, and we still can run statically linked a.out
> programs created over a decade ago.  I don't think this is a serious
> objection, given that historically the Linux kernel/userspace syscall
> interface has been quite stable. 
thats besides the point, i was arguing the difference between loading a
firmware image and running a binary daemon.
> 
> Of course, I'd recomend against said driver using sysfs, but Greg K-H
> tells us that all breakagaes are the fault of buggy device drivers
> (just as supposedly all swsuspend problems are also about buggy device
> drivers), so I guess we're OK.  :-)
> 
> 							- Ted
> 

