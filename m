Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135214AbRA2QfW>; Mon, 29 Jan 2001 11:35:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135286AbRA2QfO>; Mon, 29 Jan 2001 11:35:14 -0500
Received: from cache.sh.cvut.cz ([147.32.127.204]:13324 "EHLO cache.sh.cvut.cz")
	by vger.kernel.org with ESMTP id <S135214AbRA2Qe5>;
	Mon, 29 Jan 2001 11:34:57 -0500
Date: Mon, 29 Jan 2001 17:34:37 +0100 (CET)
From: Antonin Kral <A.Kral@sh.cvut.cz>
To: Jonathan Earle <jearle@nortelnetworks.com>
cc: "'jamal'" <hadi@cyberus.ca>, Andrew Morton <andrewm@uow.edu.au>,
        lkml <linux-kernel@vger.kernel.org>, netdev@oss.sgi.com
Subject: RE: sendfile+zerocopy: fairly sexy (nothing to do with ECN)
In-Reply-To: <28560036253BD41191A10000F8BCBD116BDCE5@zcard00g.ca.nortel.com>
Message-ID: <Pine.LNX.4.21.0101291732160.14875-100000@nightmare.sh.cvut.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > Throughput: 100Mbps is really nothing. Linux never had a problem with
> > 4-500Mbps file serving. So throughput is an important number. so is
> > end to end latency, but in file serving case, latency might 
> > not be a big deal so ignore it.
> 
> If I try to route more than 40mbps (40% line utilization) through a 100mbps
> port (tulip) on a 2.4.0-test kernel running on a pIII 500 (or higher)
> system, not only does the performance drop to nearly 0, the system gets all
> sluggish and unusable.  This is with or without Jamal's FF patches.
> 
> How are you managing to get such high throughput?
> 

I have used 2.2.13 to 2.2.18 and 2.4.0, for first approach, with no
patches and with no probles I managed bandwidth about 200 and 300 Mbps

Antonin


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
