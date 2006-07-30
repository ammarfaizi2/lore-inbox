Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932324AbWG3PKO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932324AbWG3PKO (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Jul 2006 11:10:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932328AbWG3PKO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Jul 2006 11:10:14 -0400
Received: from thunk.org ([69.25.196.29]:1250 "EHLO thunker.thunk.org")
	by vger.kernel.org with ESMTP id S932324AbWG3PKM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Jul 2006 11:10:12 -0400
Date: Sun, 30 Jul 2006 11:09:44 -0400
From: Theodore Tso <tytso@mit.edu>
To: Kasper Sandberg <lkml@metanurb.dk>
Cc: Matthew Garrett <mjg59@srcf.ucam.org>, Jan Dittmer <jdi@l4x.org>,
       Pavel Machek <pavel@suse.cz>, Jirka Lenost Benc <jbenc@suse.cz>,
       kernel list <linux-kernel@vger.kernel.org>,
       ipw2100-admin@linux.intel.com
Subject: Re: ipw3945 status
Message-ID: <20060730150944.GG23279@thunk.org>
Mail-Followup-To: Theodore Tso <tytso@mit.edu>,
	Kasper Sandberg <lkml@metanurb.dk>,
	Matthew Garrett <mjg59@srcf.ucam.org>, Jan Dittmer <jdi@l4x.org>,
	Pavel Machek <pavel@suse.cz>, Jirka Lenost Benc <jbenc@suse.cz>,
	kernel list <linux-kernel@vger.kernel.org>,
	ipw2100-admin@linux.intel.com
References: <20060730104042.GE1920@elf.ucw.cz> <20060730112827.GA25540@srcf.ucam.org> <44CC993B.6070309@l4x.org> <20060730114722.GA26046@srcf.ucam.org> <1154264478.13635.22.camel@localhost> <20060730145305.GE23279@thunk.org> <1154271654.13635.33.camel@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1154271654.13635.33.camel@localhost>
User-Agent: Mutt/1.5.11
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on thunker.thunk.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 30, 2006 at 05:00:54PM +0200, Kasper Sandberg wrote:
> thats entirely different, if some firmware image is loaded into a card,
> thats that, but running a userspace daemon is just entirely different,
> what would happen if intel for some reason stopped supporting earlier
> cards(as hardware manufactureres do after some time), and linux
> kernel/userspace gets some change, preventing the binary daemon from
> running? then what? we have lost.

Um, last time I checked we could still run some *minix* binaries from
before Linux was born, and we still can run statically linked a.out
programs created over a decade ago.  I don't think this is a serious
objection, given that historically the Linux kernel/userspace syscall
interface has been quite stable.  

Of course, I'd recomend against said driver using sysfs, but Greg K-H
tells us that all breakagaes are the fault of buggy device drivers
(just as supposedly all swsuspend problems are also about buggy device
drivers), so I guess we're OK.  :-)

							- Ted
