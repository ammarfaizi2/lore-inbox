Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263062AbTFOX6Q (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Jun 2003 19:58:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263077AbTFOX6Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Jun 2003 19:58:16 -0400
Received: from snoopy.pacific.net.au ([61.8.0.36]:45289 "EHLO
	snoopy.pacific.net.au") by vger.kernel.org with ESMTP
	id S263062AbTFOX6P (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Jun 2003 19:58:15 -0400
Date: Mon, 16 Jun 2003 10:11:41 +1000
From: CaT <cat@zip.com.au>
To: Pavel Machek <pavel@suse.cz>
Cc: swsusp@lister.fornax.hu, linux-kernel@vger.kernel.org
Subject: Re: [FIX, please test] Re: 2.5.70-bk16 - nfs interferes with s4bios suspend
Message-ID: <20030616001141.GA364@zip.com.au>
References: <20030613033703.GA526@zip.com.au> <20030615183111.GD315@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030615183111.GD315@elf.ucw.cz>
User-Agent: Mutt/1.3.28i
Organisation: Furball Inc.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 15, 2003 at 08:31:11PM +0200, Pavel Machek wrote:
> >  stopping tasks failed (2 tasks remaining)
> > Suspend failed: Not all processes stopped!
> > Restarting tasks...<6> Strange, rpciod not stopped
> 
> This should fix it... Someone please test it.

I didn't have any actual nfs mounts at the time but I tried it
with an otherwise similar system. It went through, got to freeing
memory, showed me a bunch of fullstops being drawn and then went
into an endless BUG loop. All I could pick out (after many a moment
of staring) was 'schedule in atmoic'.

I'll do a proper test with a console cable present in a few days. I
can't atm cos I'm not on the same network and don't have a 2nd 
computer to hook up the null-modem cable to.

Pre-empt is on btw.

-- 
Martin's distress was in contrast to the bitter satisfaction of some
of his fellow marines as they surveyed the scene. "The Iraqis are sick
people and we are the chemotherapy," said Corporal Ryan Dupre. "I am
starting to hate this country. Wait till I get hold of a friggin' Iraqi.
No, I won't get hold of one. I'll just kill him."
	- http://www.informationclearinghouse.info/article2479.htm
