Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261949AbVASWmX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261949AbVASWmX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Jan 2005 17:42:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261951AbVASWmX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Jan 2005 17:42:23 -0500
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:47692
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S261949AbVASWmC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Jan 2005 17:42:02 -0500
Date: Wed, 19 Jan 2005 23:42:01 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Tony Lindgren <tony@atomide.com>
Cc: Pavel Machek <pavel@suse.cz>, George Anzinger <george@mvista.com>,
       john stultz <johnstul@us.ibm.com>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       Con Kolivas <kernel@kolivas.org>,
       Martin Schwidefsky <schwidefsky@de.ibm.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dynamic tick patch
Message-ID: <20050119224201.GD12647@dualathlon.random>
References: <20050119000556.GB14749@atomide.com> <20050119094342.GB25623@elf.ucw.cz> <20050119171323.GB14545@atomide.com> <20050119174858.GB12647@dualathlon.random> <20050119181947.GF14545@atomide.com> <20050119191208.GC12647@dualathlon.random> <20050119191731.GG14545@atomide.com> <20050119193419.GH14545@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050119193419.GH14545@atomide.com>
X-AA-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-AA-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
X-Cpushare-GPG-Key: 1024D/4D11C21C 5F99 3C8B 5142 EB62 26C3  2325 8989 B72A 4D11 C21C
X-Cpushare-SSL-SHA1-Cert: 38 12 CD 76 E4 82 94 AF 02 0C 0F FA E1 FF 55 9D 9B 4F A5 9B
X-Cpushare-SSL-MD5-Cert: ED A5 F2 DA 1D 32 75 60 5E 07 6C 91 BF FC B8 85
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 19, 2005 at 11:34:20AM -0800, Tony Lindgren wrote:
> It could be HPET that kills it. I don't have any boxes with HPET
> timer, can you try without HPET?

There's no hpet hardware in that system. Also the problem I'm having is
not with your patch but on some code that should be exercised by your
patch (it's the firewall so it's not very handy to test patches on it).
I'll test on a different system next time to see if I can reproduce only
on the firewall or not.
