Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270447AbTHSOMs (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Aug 2003 10:12:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270319AbTHSOKD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Aug 2003 10:10:03 -0400
Received: from zeus.kernel.org ([204.152.189.113]:45052 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S270692AbTHSNfN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Aug 2003 09:35:13 -0400
Date: Tue, 19 Aug 2003 15:27:08 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Stephan von Krawczynski <skraw@ithnet.com>
Cc: Mike Fedyk <mfedyk@matchmail.com>, green@namesys.com,
       marcelo@conectiva.com.br, akpm@osdl.org, alan@lxorguk.ukuu.org.uk,
       linux-kernel@vger.kernel.org, mason@suse.com
Subject: Re: 2.4.22-pre lockups (now decoded oops for pre10)
Message-ID: <20030819132708.GL16139@dualathlon.random>
References: <20030813125509.360c58fb.skraw@ithnet.com> <Pine.LNX.4.44.0308131143570.4279-100000@localhost.localdomain> <20030813145940.GC26998@namesys.com> <20030813171224.2a13b97f.skraw@ithnet.com> <20030813153009.GA27209@namesys.com> <20030819011208.GK10320@matchmail.com> <20030819091243.007acac0.skraw@ithnet.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030819091243.007acac0.skraw@ithnet.com>
User-Agent: Mutt/1.4i
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 19, 2003 at 09:12:43AM +0200, Stephan von Krawczynski wrote:
> Besides the favourite test box I have others (already mentioned in this thread)
> - SMP with completely different hw - where I can make 2.4.21 and above crash,
> too.

Did you post any backtrace for those other boxes yet? It would be
especially useful if you could demonstrate the same random mm corruption
with different ram/motherboard/cpus (I mean all of them different), if
the devices are the same that's ok (since it could be a software bug in
a driver).

At the moment I doubt a bug in the common code since AFIK you are the
only one running into this sort of corruption and at the very least I
can't trigger it here (OTOH maybe it triggers with only one certain
application).

(just for clarity: with my previous posts I didn't mean it's not a
software bug, I only wanted to point out that with the current info we
cannot exclude completely an hardware issue yet)

Andrea
