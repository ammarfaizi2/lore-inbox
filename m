Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261794AbSJMUkN>; Sun, 13 Oct 2002 16:40:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261749AbSJMUkN>; Sun, 13 Oct 2002 16:40:13 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:55174 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S261796AbSJMUkM>; Sun, 13 Oct 2002 16:40:12 -0400
Date: Sun, 13 Oct 2002 13:41:41 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Linus Torvalds <torvalds@transmeta.com>
cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH] Summit support for 2.5 [0/4]
Message-ID: <39770000.1034541701@flay>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This set of 4 patches puts in the core support for the Summit chipset
used by IBM x440 machines - this is a major new platform for IBM, and
we'd really like to have it supported in 2.6 ... the changes are actually
pretty small, it keys off a lot of the same stuff as the NUMA-Q.

I've taken James Cleverdon's patches (he did all the hard work on this)
and split it into bite-sized chunks, where each patch is small, confined
and (IMHO) easily readable, and it should be easy to see it won't break
anything else. 

I've dropped some cleanup work that he did - you seem to like that seperate 
from features, and I agree ... it's much easier to read the patches like this.
I will invest some serious effort and time in cleanup after the feature freeze,
including investigating using the subarch support which I know some people
would like to see done.

I've also tested these on a standard desktop PC, a standard 4-way SMP box,
and a 16-way NUMA-Q (against 2.5.42). No problems found.

Please apply!

Thanks,

Martin.

