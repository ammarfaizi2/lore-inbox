Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285196AbRLFUy5>; Thu, 6 Dec 2001 15:54:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285192AbRLFUxT>; Thu, 6 Dec 2001 15:53:19 -0500
Received: from bitmover.com ([192.132.92.2]:33923 "EHLO bitmover.bitmover.com")
	by vger.kernel.org with ESMTP id <S284245AbRLFUuG>;
	Thu, 6 Dec 2001 15:50:06 -0500
Date: Thu, 6 Dec 2001 12:50:05 -0800
From: Larry McVoy <lm@bitmover.com>
To: Pavel Machek <pavel@suse.cz>
Cc: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>, Larry McVoy <lm@bitmover.com>,
        Stephan von Krawczynski <skraw@ithnet.com>,
        Horst von Brand <vonbrand@sleipnir.valparaiso.cl>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: Linux/Pro [was Re: Coding style - a non-issue]
Message-ID: <20011206125005.K27589@work.bitmover.com>
Mail-Followup-To: Pavel Machek <pavel@suse.cz>,
	"Martin J. Bligh" <Martin.Bligh@us.ibm.com>,
	Larry McVoy <lm@bitmover.com>,
	Stephan von Krawczynski <skraw@ithnet.com>,
	Horst von Brand <vonbrand@sleipnir.valparaiso.cl>,
	lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <20011202155440.F2622@work.bitmover.com> <2379997133.1007402344@mbligh.des.sequent.com> <20011206134642.D49@toy.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <20011206134642.D49@toy.ucw.cz>; from pavel@suse.cz on Thu, Dec 06, 2001 at 01:46:43PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Then we can create memnet (netdevice over shared memory), and Larry's dream
> can come true...

I'm hoping, but my dreams do not include shared memory over a network.
That's just way too slow.  It's been done a pile of times, every time
people say that the caching will make it fast enough and those people
are wrong every time.

People who think DSM is a good idea are the same people who think a
millisecond is OK for a cache miss (current cache miss times are well
under .0002 milliseconds).
-- 
---
Larry McVoy            	 lm at bitmover.com           http://www.bitmover.com/lm 
