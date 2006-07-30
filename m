Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751418AbWG3W3a@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751418AbWG3W3a (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Jul 2006 18:29:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751426AbWG3W3a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Jul 2006 18:29:30 -0400
Received: from run.smurf.noris.de ([192.109.102.41]:37328 "EHLO smurf.noris.de")
	by vger.kernel.org with ESMTP id S1751418AbWG3W33 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Jul 2006 18:29:29 -0400
Date: Mon, 31 Jul 2006 00:28:49 +0200
To: Andi Kleen <ak@muc.de>
Cc: Andrew Morton <akpm@osdl.org>, john stultz <johnstul@us.ibm.com>,
       linux-kernel@vger.kernel.org, torvalds@osdl.org, bunk@stusta.de,
       lethal@linux-sh.org, hirofumi@mail.parknet.co.jp,
       asit.k.mallick@intel.com
Subject: Re: REGRESSION: the new i386 timer code fails to sync CPUs
Message-ID: <20060730222849.GC3662@kiste.smurf.noris.de>
References: <20060723120829.GA7776@kiste.smurf.noris.de> <20060723053755.0aaf9ce0.akpm@osdl.org> <1153756738.9440.14.camel@localhost> <20060724171711.GA3662@kiste.smurf.noris.de> <20060724175150.GD50320@muc.de> <1153774443.12836.6.camel@localhost> <20060730020346.5d301bb5.akpm@osdl.org> <20060730201005.GA85093@muc.de> <20060730211359.GZ3662@kiste.smurf.noris.de> <20060730215705.GA90965@muc.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060730215705.GA90965@muc.de>
User-Agent: Mutt/1.5.11
From: Matthias Urlichs <smurf@smurf.noris.de>
X-Smurf-Spam-Score: -2.6 (--)
X-Smurf-Whitelist: +relay_from_hosts
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Andi Kleen:
> > I'll postpone that until we have a working kernel fix,
> > for obvious reasons.
> 
> What are the obvious reasons?
> 
- No endangering of customers' production machines without a compelling
  reason.

- No stepping back, as I don't know which BIOS version is on the
  board (DMI says "6.0", but Tyan has 1.0x on their website; the
  release date doesn't match either).

- I'd rather test a working workaround in the kernel before updating;
  if I have the problem, others have it too, and gettng Linux to boot in
  that situation isn't exactly trivial -- the fact that you need a
  clock= parameter when udevsend hangs is kindof non-obvious.

- ... and the not-quite-obvious reason: Tyan specifies that I *need* a
  Win95 or Win98 boot floppy to do that. While I don't really believe
  them, I still don't have one of those handy ... which brings me back
  to the first item in this list.

-- 
Matthias Urlichs   |   {M:U} IT Design @ m-u-it.de   |  smurf@smurf.noris.de
Disclaimer: The quote was selected randomly. Really. | http://smurf.noris.de
 - -
"Seems I can't get me 'ead down these days without rescuin' people or
foilin' robbers or sunnink."
        -- It's a wonder dog's life
           (Terry Pratchett, Moving Pictures)
