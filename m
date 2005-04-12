Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262392AbVDLWaH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262392AbVDLWaH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Apr 2005 18:30:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262551AbVDLW0r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Apr 2005 18:26:47 -0400
Received: from gate.crashing.org ([63.228.1.57]:12454 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S262392AbVDLWSq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Apr 2005 18:18:46 -0400
Subject: Re: [PATCH] ppc64: very basic desktop g5 sound support (#2)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Andreas Schwab <schwab@suse.de>
Cc: Andrew Morton <akpm@osdl.org>, linuxppc64-dev <linuxppc64-dev@ozlabs.org>,
       Linus Torvalds <torvalds@osdl.org>, Andrea Arcangeli <andrea@suse.de>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <jell7nu6yk.fsf@sykes.suse.de>
References: <1113282436.21548.42.camel@gaston>
	 <jell7nu6yk.fsf@sykes.suse.de>
Content-Type: text/plain
Date: Wed, 13 Apr 2005 08:17:05 +1000
Message-Id: <1113344225.21548.108.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-04-12 at 21:32 +0200, Andreas Schwab wrote:
> Benjamin Herrenschmidt <benh@kernel.crashing.org> writes:
> 
> > This patch hacks the current PowerMac Alsa driver to add some basic
> > support of analog sound output to some desktop G5s. It has severe
> > limitations though:
> >
> >  - Only 44100Khz 16 bits
> >  - Only work on G5 models using a TAS3004 analog code, that is early
> >    single CPU desktops and all dual CPU desktops at this date, but none
> >    of the more recent ones like iMac G5.
> >  - It does analog only, no digital/SPDIF support at all, no native
> >    AC3 support
> 
> On my PowerMac the internal speaker is now working, but unfortunately on
> the line-out I get nearly no output.  I have pushed both the master and
> pcm control to the maximum and still barely hear anything.

Yes, I noticed that too on some models, not sure what's up at this
point. What about the headphone jack on the front ? That one appears to
work.

Ben.


