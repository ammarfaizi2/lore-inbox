Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268855AbTCCXEG>; Mon, 3 Mar 2003 18:04:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268860AbTCCXEG>; Mon, 3 Mar 2003 18:04:06 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:11015 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S268855AbTCCXEE>; Mon, 3 Mar 2003 18:04:04 -0500
Date: Tue, 4 Mar 2003 00:14:30 +0100
From: Pavel Machek <pavel@suse.cz>
To: Andrea Arcangeli <andrea@suse.de>
Cc: Larry McVoy <lm@work.bitmover.com>, Jeff Garzik <jgarzik@pobox.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Arador <diegocg@teleline.es>,
       "Adam J. Richter" <adam@yggdrasil.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       pavel@janik.cz, pavel@ucw.cz
Subject: Re: BitBucket: GPL-ed *notrademarkhere* clone
Message-ID: <20030303231430.GA28055@atrey.karlin.mff.cuni.cz>
References: <20030302014915.34a6de37.diegocg@teleline.es> <1046571336.24903.0.camel@irongate.swansea.linux.org.uk> <3E615C38.7030609@pobox.com> <20030302014039.GC1364@dualathlon.random> <3E616224.6040003@pobox.com> <20030302020907.GE1364@dualathlon.random> <3E623F37.6060005@pobox.com> <20030302181615.GA25902@dualathlon.random> <20030303183734.GB21701@work.bitmover.com> <20030303225702.GP16918@dualathlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030303225702.GP16918@dualathlon.random>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > How close is http://www.bitmover.com/EXPORT to what you want (3MB file).
> > 
> > Note that this is very coarse granularity, it's very 2.5.62 up to 2.5.63,
> 
> I'm probably missing something obvious but it's not clear to me how to
> extract the changeset info from this format.

Is that format parsable at all? It looks like strange changeset
comments could confuse parsers...

> Let's assume I want to extract this changeset:
> 
> hangeSet@1.1021, 2003-02-24 10:49:30-08:00, randy.dunlap@verizon.net
>   [PATCH] convert /proc/io{mem,ports} to seq_file
> 
>   This converts /proc/io{mem,ports} to the seq_file interface
>   (single_open).
> 
> How can I?
> 
> I mean, the above format is fine, as far as we have a file like that per
> changeset (or alternatively per Linus's merge, even if not for every
> single changeset, when he does the pulls). Clearly a file of that format
> for a 2.5.62->63 diff is not finegrined enough.

Ben's bitsubversion script is somewhat slow, but should be capable of
pulling any diff you want...
								Pavel

-- 
Horseback riding is like software...
...vgf orggre jura vgf serr.
