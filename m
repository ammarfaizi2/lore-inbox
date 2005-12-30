Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751206AbVL3Hth@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751206AbVL3Hth (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Dec 2005 02:49:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751208AbVL3Hth
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Dec 2005 02:49:37 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:8603 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1751206AbVL3Hth (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Dec 2005 02:49:37 -0500
Date: Fri, 30 Dec 2005 08:49:16 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Tim Schmielau <tim@physik3.uni-rostock.de>
Cc: Arjan van de Ven <arjan@infradead.org>, Linus Torvalds <torvalds@osdl.org>,
       Dave Jones <davej@redhat.com>, Andrew Morton <akpm@osdl.org>,
       lkml <linux-kernel@vger.kernel.org>, mpm@selenic.com
Subject: Re: [patch 00/2] improve .text size on gcc 4.0 and newer compilers
Message-ID: <20051230074916.GC25637@elte.hu>
References: <20051228214845.GA7859@elte.hu> <20051228201150.b6cfca14.akpm@osdl.org> <20051229073259.GA20177@elte.hu> <Pine.LNX.4.64.0512290923420.14098@g5.osdl.org> <20051229202852.GE12056@redhat.com> <Pine.LNX.4.64.0512291240490.3298@g5.osdl.org> <Pine.LNX.4.64.0512291322560.3298@g5.osdl.org> <20051229224839.GA12247@elte.hu> <1135897092.2935.81.camel@laptopd505.fenrus.org> <Pine.LNX.4.63.0512300035550.2747@gockel.physik3.uni-rostock.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.63.0512300035550.2747@gockel.physik3.uni-rostock.de>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -1.9
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-1.9 required=5.9 tests=ALL_TRUSTED,AWL autolearn=no SpamAssassin version=3.0.3
	-2.8 ALL_TRUSTED            Did not pass through any untrusted hosts
	0.9 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Tim Schmielau <tim@physik3.uni-rostock.de> wrote:

> What about the previous suggestion to remove inline from *all* static 
> inline functions in .c files?

i think this is a way too static approach. Why go from one extreme to 
the other, when my 3 simple patches (which arguably create a more 
flexible scenario) gives us savings of 7.7%?

	Ingo
