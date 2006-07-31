Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932500AbWGaBRE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932500AbWGaBRE (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Jul 2006 21:17:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932508AbWGaBRE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Jul 2006 21:17:04 -0400
Received: from pfepa.post.tele.dk ([195.41.46.235]:25533 "EHLO
	pfepa.post.tele.dk") by vger.kernel.org with ESMTP id S932500AbWGaBRB
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Jul 2006 21:17:01 -0400
Subject: Re: ipw3945 status
From: Kasper Sandberg <lkml@metanurb.dk>
To: Alistair John Strachan <s0348365@sms.ed.ac.uk>
Cc: Pavel Machek <pavel@suse.cz>, Theodore Tso <tytso@mit.edu>,
       Matthew Garrett <mjg59@srcf.ucam.org>, Jan Dittmer <jdi@l4x.org>,
       Jirka Lenost Benc <jbenc@suse.cz>,
       kernel list <linux-kernel@vger.kernel.org>,
       ipw2100-admin@linux.intel.com
In-Reply-To: <200607310123.06177.s0348365@sms.ed.ac.uk>
References: <20060730104042.GE1920@elf.ucw.cz>
	 <20060730145305.GE23279@thunk.org> <20060730231251.GB1800@elf.ucw.cz>
	 <200607310123.06177.s0348365@sms.ed.ac.uk>
Content-Type: text/plain
Date: Mon, 31 Jul 2006 03:16:54 +0200
Message-Id: <1154308614.13635.49.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.0 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-07-31 at 01:23 +0100, Alistair John Strachan wrote:
> On Monday 31 July 2006 00:12, Pavel Machek wrote:
> [snip]
> > And... Intel will not even tell you WTF that daemon does. They claim
> > it is for FCC, but it seems to be doing more than that. So maybe I'm
> > not _that_ paranoid.
> 
> Agreed, from what Matthew's said it seems like the daemon is being used to 
> hide intellectual property, not something we should really be encouraging.
> 
> I think the title "regulatory daemon" has multiple meanings, it REGULATES your 
> frequencies to FCC specs, it REGULATES your wireless card's power and 
> temperature levels, and it REGULATES your right to use the hardware ;-)
> 
> Ultimately the question remains, will we open this can of worms by accepting 
> drivers that depend on proprietary software (i.e. they will not function at 
> all without it). I'm fairly sure the answer should be "No".
I entirely agree that this should not be merged, those will accept these
kindof things, can use intels out of tree driver.

i sincerely hope for a forked/rewritten driver which does not depend on
closed userspace daemons.
> 

