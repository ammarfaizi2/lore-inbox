Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268510AbSIRRyV>; Wed, 18 Sep 2002 13:54:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268514AbSIRRyU>; Wed, 18 Sep 2002 13:54:20 -0400
Received: from hq.fsmlabs.com ([209.155.42.197]:45272 "EHLO hq.fsmlabs.com")
	by vger.kernel.org with ESMTP id <S268510AbSIRRyS>;
	Wed, 18 Sep 2002 13:54:18 -0400
From: Cort Dougan <cort@fsmlabs.com>
Date: Wed, 18 Sep 2002 11:57:10 -0600
To: "Martin J. Bligh" <mbligh@aracnet.com>
Cc: Linus Torvalds <torvalds@transmeta.com>, Ingo Molnar <mingo@elte.hu>,
       Rik van Riel <riel@conectiva.com.br>, Andries Brouwer <aebr@win.tue.nl>,
       William Lee Irwin III <wli@holomorphy.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [patch] lockless, scalable get_pid(), for_each_process() elimination, 2.5.35-BK
Message-ID: <20020918115710.A656@host110.fsmlabs.com>
References: <20020918113551.A654@host110.fsmlabs.com> <343149182.1032346081@[10.10.2.3]>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <343149182.1032346081@[10.10.2.3]>; from mbligh@aracnet.com on Wed, Sep 18, 2002 at 10:48:03AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm also a big fan of "Do that crap outside the kernel until it works
properly" type projects.  If you want to talk about real-time scheduling as
an example... looks at the trouble it's causing now.  I think it makes my
point for me very strongly.

The Linux view should not be that N-way boxes are its manifest destiny.
The same goes for thousands of threads.  Linux works pretty well on 95% of
the boxes that it is being run on.  Lets not screw that up to fix the other
5%.  Try some fixes _outside_ the main kernel for a while, find a workable
solution and then merge it in.

The Linux bus is getting really top-heavy because of some macho-features.

} Like real time scheduling or embedded systems for example?
} Be careful what you ask for ....
