Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312601AbSGULOH>; Sun, 21 Jul 2002 07:14:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312973AbSGULOG>; Sun, 21 Jul 2002 07:14:06 -0400
Received: from loke.as.arizona.edu ([128.196.209.61]:17797 "EHLO
	loke.as.arizona.edu") by vger.kernel.org with ESMTP
	id <S312601AbSGULOG>; Sun, 21 Jul 2002 07:14:06 -0400
Date: Sun, 21 Jul 2002 04:14:51 -0700 (MST)
From: Craig Kulesa <ckulesa@as.arizona.edu>
To: linux-kernel@vger.kernel.org
cc: linux-mm@kvack.org
Subject: [PATCH 1/2][CFT] Full rmap VM for 2.5.27
Message-ID: <Pine.LNX.4.44.0207210218410.6770-100000@loke.as.arizona.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



A new release of the full-featured rmap patch (Rik van Riel's rmap-13b) is 
available against the minimal rmap in 2.5.27.  This first patch brings the 
2.5 VM into approximate parity with 2.4-ac in terms of basic page 
replacement, page aging, and lru list logic.  

A description from the last posting:  
	http://mail.nl.linux.org/linux-mm/2002-07/msg00215.html


Changelog:
- Sync'ed with the 2.5.27 rmap merge
- Added Bill Irwin's recent patch that converts the pte_chain freelist to 
  use mempool.  Updated VM stats.  A nice patch that seems to work well 
  here, so far... :)


Next release:
- multi-page batch processing of the list-scanning methods in 
  vmscan to reduce lock contention, ala Andrew Morton's recent patches
- looking into 2.4-aa for useful tidbits
- various rmap updates from the usual suspects... :)


Get it here:
	http://loke.as.arizona.edu/~ckulesa/kernel/rmap-vm/2.5.27/


Try it, use it, send feedback. :)

Craig Kulesa
Steward Observatory
Univ. of Arizona

