Return-Path: <owner-linux-kernel-outgoing@vger.rutgers.edu>
Received: by vger.rutgers.edu via listexpand id <160734-27300>; Mon, 1 Feb 1999 04:28:04 -0500
Received: by vger.rutgers.edu id <160661-27300>; Mon, 1 Feb 1999 04:27:44 -0500
Received: from mail0.u-aizu.ac.jp ([163.143.103.60]:2690 "EHLO mail0.u-aizu.ac.jp" ident: "NO-IDENT-SERVICE[2]") by vger.rutgers.edu with ESMTP id <160730-27300>; Mon, 1 Feb 1999 04:27:24 -0500
Message-ID: <36B575AF.52CB3B07@neuro-nt.u-aizu.ac.jp>
Date: Mon, 01 Feb 1999 18:36:47 +0900
From: Sebastien Gignoux <gignoux@neuro-nt.u-aizu.ac.jp>
X-Mailer: Mozilla 4.5 [en] (WinNT; I)
X-Accept-Language: en,fr,ja
MIME-Version: 1.0
To: linux-kernel@vger.rutgers.edu
Subject: Page coloring (found a PhD Dissertation)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux-kernel@vger.rutgers.edu


I have found a Dissertation (supervised by M.J. Flynn) who study page coloring.
It looks interesting (I have not read it yet) and with detailed results.

You can download (PS file) it at: http://umunhum.stanford.edu/phds.html ("The
Interaction of Virtual Memory and Cache Memory.")

Reference and abstract bellow.

I hope it could help.

Sebastien



The Interaction of Virtual Memory and Cache Memory
by  William L. Lynch

October 1993
Computer Systems Laboratory
Departments of Electrical Engineering and Computer Science
Stanford University

Abstract :
This dissertation concerns itself with the interactions of unified-,
instruction-, and data-cache memory, and
virtual memory: specifically, the interactions caused by the continued trends
increasing the cache size and
decreasing the cache associativity, resulting in the indexing of caches with
virtual-memory-system-translated
physical page number bits.
Caches indexed with physical page-number bits possess two problems. First, the
cache miss rate varies
between runs, as data location in the cache depends on the placement of virtual
pages in physical memory.
Secondly, the virtual-to-physical address translation must precede cache
indexing, increasing latency.
Controlling (coloring) page allocation eliminates the inter-run variation and
improves the mean miss rate.
Simulation results provide distribution of miss rates caused by conventional
page allocation for a variety of
cache organizations and size, and several page sizes.
Several page coloring heuristics demonstrate a reduction in the variation of
miss rate, including a strict page
coloring algorithm which also allows cache indexing to precede address
translation.
This strict page allocation partitions physical memory, and thus may increase
the page fault rate. Simulations
show that this change in page fault rate is small for a range of memory sizes
and degrees of partitioning.

Key Words and Phrases: Page Coloring, Virtual Memory, Direct-Mapped Caches


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.rutgers.edu
Please read the FAQ at http://www.tux.org/lkml/
