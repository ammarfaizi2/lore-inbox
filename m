Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319202AbSH2Ne0>; Thu, 29 Aug 2002 09:34:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319203AbSH2Ne0>; Thu, 29 Aug 2002 09:34:26 -0400
Received: from ns.suse.de ([213.95.15.193]:33028 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id <S319202AbSH2NeZ>;
	Thu, 29 Aug 2002 09:34:25 -0400
Date: Thu, 29 Aug 2002 15:38:47 +0200
From: Dave Jones <davej@suse.de>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Linus Torvalds <torvalds@transmeta.com>,
       Dominik Brodowski <devel@brodo.de>, cpufreq@www.linux.org.uk,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH][2.5.32] CPU frequency and voltage scaling (0/4)
Message-ID: <20020829153847.D24918@suse.de>
Mail-Followup-To: Dave Jones <davej@suse.de>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Linus Torvalds <torvalds@transmeta.com>,
	Dominik Brodowski <devel@brodo.de>, cpufreq@www.linux.org.uk,
	linux-kernel@vger.kernel.org
References: <Pine.LNX.4.44.0208281649540.27728-100000@home.transmeta.com> <1030618420.7290.112.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <1030618420.7290.112.camel@irongate.swansea.linux.org.uk>; from alan@lxorguk.ukuu.org.uk on Thu, Aug 29, 2002 at 11:53:40AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 29, 2002 at 11:53:40AM +0100, Alan Cox wrote:
 > >  { min-Hz, max-Hz, policy }
 > For a few of the processors "event-hz" or similar would be nice. The
 > Geode supports hardware assisted bursting to full processor speed when
 > doing SMM, I/O and IRQ handling.

If we do implement (for sake of argument) /proc/sys/performance or
whatever, changing the cpufreq interface so it performs 'stacking'
would be a good idea too.
Eg, on a K6-3+ system, we could do cpu scaling and chipset throttling
just by doing a echo "min" > /proc/sys/perf or whatever, and have
the code call 'chains' of performance related features.

Comments? 

        Dave
-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs
