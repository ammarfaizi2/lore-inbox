Return-Path: <owner-linux-kernel-outgoing@vger.rutgers.edu>
Received: by vger.rutgers.edu id <155344-27243>; Fri, 28 Aug 1998 05:06:07 -0400
Received: from exchange.telindus.be ([194.7.48.10]:2859 "EHLO exchange.telindus.be" ident: "TIMEDOUT") by vger.rutgers.edu with ESMTP id <156614-27243>; Fri, 28 Aug 1998 02:02:23 -0400
Message-Id: <3.0.1.32.19980828095136.00942370@exchange.telindus.be>
X-Mailer: Windows Eudora Light Version 3.0.1 (32)
Date: Fri, 28 Aug 1998 09:51:36 +0200
To: linux-kernel@vger.rutgers.edu
From: Marnix Coppens <maco@telindus.be>
Subject: Re: 2.1.xxx makes Electric Fence 22x slower
In-Reply-To: <199808261517.JAA24949@nyx10.nyx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: owner-linux-kernel@vger.rutgers.edu

>
>A simple lagged-fibonacci generator like x[i] = x[i-24] + x[i-55] would
>do fine.  Moving to a twisted generator (TGFSR) improves things even more.
>What is arguably the best PRNG currently existing, the Mersenne Twister
>(Can you say "perfect score on the spectral test with up to 600 dimensions",
>boys and girls?), is quite fast.
>

MT19937 has a period of 2^19937 - 1, with a "623-dimensional equidistribution
property". It's available from http://www.math.keio.ac.jp/matumoto/emt.html .
Don't kill their machine though.


Marnix Coppens

---
Reality is that which                   | Artificial Intelligence
when you stop believing                 | stands no chance against
in it doesn't go away. (Philip K. Dick) | Natural Stupidity.


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.rutgers.edu
Please read the FAQ at http://www.altern.org/andrebalsa/doc/lkml-faq.html
