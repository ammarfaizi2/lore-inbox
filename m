Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261965AbTLLWIA (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Dec 2003 17:08:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261967AbTLLWIA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Dec 2003 17:08:00 -0500
Received: from gprs149-168.eurotel.cz ([160.218.149.168]:60033 "EHLO
	amd.ucw.cz") by vger.kernel.org with ESMTP id S261965AbTLLWHs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Dec 2003 17:07:48 -0500
Date: Fri, 12 Dec 2003 23:08:53 +0100
From: Pavel Machek <pavel@ucw.cz>
To: "Martin J. Bligh" <mbligh@aracnet.com>
Cc: Jean-Marc Valin <Jean-Marc.Valin@USherbrooke.ca>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Increasing HZ (patch for HZ > 1000)
Message-ID: <20031212220853.GA314@elf.ucw.cz>
References: <1071126929.5149.24.camel@idefix.homelinux.org> <1293500000.1071127099@[10.10.2.4]>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1293500000.1071127099@[10.10.2.4]>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> >> Why would you want to *increase* HZ? I'd say 1000 is already too high
> >> personally, but I'm curious what you'd want to do with it? Embedded
> >> real-time stuff?
> > 
> > Actually, my reasons may sound a little strange, but basically I'd be
> > fine with HZ=1000 if it wasn't for that annoying ~1 kHz sound when the
> > CPU is idle (probably bad capacitors). By increasing HZ to 10 kHz, the
> > sound is at a frequency where the ear is much less sensitive. Anyway, I
> > thought some people might be interested in high HZ for other (more
> > fundamental) reasons, so I posted the patch.
> 
> Ha! ;-) 
> A hardware fix might be in order ;-)

Every notebook from thinkpad 560X up has produced some kind of
cpu-load-related-noise. You'd have to throw out quite a lot of
notebooks...
								Pavel
PS: Jean, can you try how high you can get it? You might want to go to
24kHz so that no human can hear it, or to 100kHz to be kind to
cats. At ~1MHz you'd be even kind to bats :-), but it is probably
impossible to get over 200kHz or so. Still it might be funny
experiment.

-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
