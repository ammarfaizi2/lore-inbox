Return-Path: <owner-linux-kernel-outgoing@vger.rutgers.edu>
Received: by vger.rutgers.edu id <154195-17165>; Tue, 1 Dec 1998 22:13:20 -0500
Received: from home.gis.net ([208.218.130.20]:47160 "EHLO home.gis.net" ident: "NO-IDENT-SERVICE[2]") by vger.rutgers.edu with ESMTP id <154889-17165>; Tue, 1 Dec 1998 18:18:22 -0500
Message-Id: <199812020121.UAA10120@home.gis.net>
Comments: Authenticated sender is <bricedue@gis.net>
From: "Brice Due" <bricedue@gis.net>
To: linux-kernel@vger.rutgers.edu
Date: Tue, 1 Dec 1998 09:25:49 +0000
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Subject: Improving Linux VM: Two papers re: OS mitigation of TLB/cache mi
X-mailer: Pegasus Mail for Windows (v2.42a)
Sender: owner-linux-kernel@vger.rutgers.edu

Hello.  I have been doing some recreational digging in CS literature in a
recent project aimed at understanding virtual memory implementations.  I was
perplexed that Intel's 486 design included only a 32-entry TLB (translation
lookaside buffer) and that it is flushed on each context switch.  To me, green
as I was, this seemed like a very likely bottleneck for heavy users of VM such
as Linux. The literature available on the net bore this assumption out:  TLB
misses are significant performance problems which become only _more_ significant
as processors continue to out-pace memory and data/code grows.

To make a long post short, I am not a systems programmer, but two CS papers
stood out as being potentially very useful in the future development of the
Linux kernel.  If the specific techniques outlined are not implementable on the
486 and kin (to the best of my memory the 486 does not allow software
management of the TLB, etc.), then certainly the ideas will be food for
improvements in VM implementation.  Hopefully this forum will reach some of the
people working on this area of the kernel.

The first paper is the largest, but the most inovative.  It is a 2Mb PS file
with a web page front-end containing the abstract:

Ph.D. Dissertation: Using Virtual Memory to Improve Cache and TLB Performance 
http://www.cs.washington.edu/homes/romer/thesis.html


The second is a <200Kb PS file:

Surpassing the TLB Performance of Superpages with less Operating System Support
ftp://ftp.cs.wisc.edu/markhill/Papers/asplos6_superpages.ps

The author of the second paper has a homepage with link to the paper:
http://www.cs.wisc.edu/~markhill/markhill.html



Long live Linux.
-brice

P.S.  This was originally posted to comp.os.linux.development.system - hesitantly. 
Now that I've found it, I am _sure_ this list is the best place to post this info.
Enjoy.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.rutgers.edu
Please read the FAQ at http://www.tux.org/lkml/
