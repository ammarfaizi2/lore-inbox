Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284406AbRLDAVE>; Mon, 3 Dec 2001 19:21:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284697AbRLDAPl>; Mon, 3 Dec 2001 19:15:41 -0500
Received: from battlejitney.wdhq.scyld.com ([216.254.93.178]:25076 "EHLO
	vaio.greennet") by vger.kernel.org with ESMTP id <S284910AbRLCSFm>;
	Mon, 3 Dec 2001 13:05:42 -0500
Date: Mon, 3 Dec 2001 13:12:20 -0500 (EST)
From: Donald Becker <becker@scyld.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Linux/Pro  -- clusters
Message-ID: <Pine.LNX.4.10.10112031239100.978-100000@vaio.greennet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Davide Libenzi (davidel@xmailserver.org) wrote

>And if you're the prophet and you think that the future of multiprocessing 
>is UP on clusters, why instead of spreading your word between us poor 
>kernel fans don't you pull out money from your pocket ( or investors ) and 
>start a new Co. that will have that solution has primary and unique goal ? 

I believe that the future of multiprocessing is clusters of small scale
SMP machines, 2-8 processors each.  And the most important part of
clustering them together isn't single system image from the programmers
point of view, it's transparent administration for the end user.  Thus
our system has a unified process space and a single point of control,
while imposing no overhead on processes.

You are right that there is no reason to convince people here -- I tried
to do that a few years ago.  Instead I've put lots of my own time and
money, as well as investor money, into a company that does only cluster
system software.

Anyway, my real point is that while I'm a big proponent of designing
consistent interfaces rather than the haphazard, incompatible changes
that have been occurring, this is far from predict-the-future design.

The goal of designing the kernel to support 128 way SMP systems is a
perfect example of the difference.  A few days or weeks of using a
proposed interface change will show if the advantages are worth the cost
of the change.  We won't know for years if redesigning the kernel for
large scale SMP system is useful
  - does it actually work,
  - will big SMP machines be common, or even exist?
  - will big SMP machines have the characteristics we predict
let alone worth the costs such as
  - UP performance hit
  - complexity increase slows other improvements
  - difficult performance tuning


Donald Becker				becker@scyld.com
Scyld Computing Corporation		http://www.scyld.com
410 Severn Ave. Suite 210		Second Generation Beowulf Clusters
Annapolis MD 21403			410-990-9993

