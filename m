Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264816AbUEPUiV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264816AbUEPUiV (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 16 May 2004 16:38:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264818AbUEPUiV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 16 May 2004 16:38:21 -0400
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:29370
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S264816AbUEPUiU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 16 May 2004 16:38:20 -0400
Date: Sun, 16 May 2004 22:38:18 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Steven Cole <elenstev@mesatop.com>
Cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       adi@bitmover.com, scole@lanl.gov, support@bitmover.com,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 1352 NUL bytes at the end of a page? (was Re: Assertion `s && s->tree' failed: The saga continues.)
Message-ID: <20040516203818.GY3044@dualathlon.random>
References: <200405132232.01484.elenstev@mesatop.com> <Pine.LNX.4.58.0405152147220.25502@ppc970.osdl.org> <20040516052220.GU3044@dualathlon.random> <200405160928.22021.elenstev@mesatop.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200405160928.22021.elenstev@mesatop.com>
User-Agent: Mutt/1.4.1i
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 16, 2004 at 09:28:21AM -0600, Steven Cole wrote:
> Andrea, I did see a significant slowdown with Andy's test script (with DMA on)
> on my timed test of 2.6.6-current vs 2.6.3.

2.6.3 is quite old, as Andrew is wondering about, this is more likely a
vm heuristic issue if something, it cannot be anon-vma related.

btw, if you've 2.6.3 you should download just two patches to go to
2.6.5.
