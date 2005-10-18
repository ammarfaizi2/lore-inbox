Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751463AbVJRIPE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751463AbVJRIPE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Oct 2005 04:15:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751470AbVJRIPE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Oct 2005 04:15:04 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:25262 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S1751463AbVJRIPC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Oct 2005 04:15:02 -0400
Date: Tue, 18 Oct 2005 10:15:01 +0200
From: Pavel Machek <pavel@suse.cz>
To: Richard Purdie <rpurdie@rpsys.net>
Cc: lenz@cs.wisc.edu, zaurus@orca.cx,
       kernel list <linux-kernel@vger.kernel.org>
Subject: Re: spitz (zaurus sl-c3000) support
Message-ID: <20051018081501.GE12283@atrey.karlin.mff.cuni.cz>
References: <20051012223036.GA3610@elf.ucw.cz> <1129158864.8340.20.camel@localhost.localdomain> <20051012233917.GA2890@elf.ucw.cz> <1129192418.8238.21.camel@localhost.localdomain> <20051013224419.GF1876@elf.ucw.cz> <1129244547.8238.100.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1129244547.8238.100.camel@localhost.localdomain>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > Thanks. Kernel works, even with 3.5.3 opie. [But touchscreen gets
> > extremely interesting, you have to click top-right corner to get it to
> > register click in bottom-left].
> 
> Yes, there's a bug in the opie (qte specifically) calibration code which
> is fixed in 3.5.4 (I fixed it). I ended up replacing qte's algorithm
> with a decent 5 point one.
...
> Yes, place the file as gnu.tar on the flashcard with updater.sh.
> updater.sh is indeed an "encrypted" shell script! There are tools around
> to decode/encode it.

Yes, now it updated correctly. Thanks!

> > Oh, okay, one more question. Do you trust your battery charging code
> > enough to leave spitz overnight in charger? I would hate to be awaken
> > by angry lithium ;-).
> 
> My spitz has been left plugged in all the time with my charging code and
> has yet to explode. ;-) Its very similar to the c7x0 code which people
> have happily been using for a while in OpenZaurus c7x0 2.6. Spitz does
> contain a charging chip which should prevent major damage to the
> battery. The software just tries to help it along...

Charge led does not go off, but pavouk (has c7x0) told me that's
pretty much normal. It made me a bit nervous.
								Pavel
-- 
Boycott Kodak -- for their patent abuse against Java.
