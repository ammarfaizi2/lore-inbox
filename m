Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318483AbSGSJ3i>; Fri, 19 Jul 2002 05:29:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318485AbSGSJ3i>; Fri, 19 Jul 2002 05:29:38 -0400
Received: from loke.as.arizona.edu ([128.196.209.61]:36484 "EHLO
	loke.as.arizona.edu") by vger.kernel.org with ESMTP
	id <S318483AbSGSJ3f>; Fri, 19 Jul 2002 05:29:35 -0400
Date: Fri, 19 Jul 2002 02:30:27 -0700 (MST)
From: Craig Kulesa <ckulesa@as.arizona.edu>
To: linux-kernel@vger.kernel.org
cc: linux-mm@kvack.org
Subject: [PATCH 6/6] VM statistics for full rmap
Message-ID: <Pine.LNX.4.44.0207190154390.4647-100000@loke.as.arizona.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



This adopts Rik van Riel's recent extended VM statistics patch for the 
'armed-to-the-gills-kitchen-sink rmap' against 2.5.26.  The aim, in 
combination with a meaningful benchmark suite, is to be able to have the 
statistical ammunition to fine tune the VM properly, rather than twiddling 
all knobs at once hoping to make things better. 

Get the patch series here: 
	http://loke.as.arizona.edu/~ckulesa/kernel/rmap-vm/2.5.26/

Rik's original announcement is here:
	http://mail.nl.linux.org/linux-mm/2002-07/msg00172.html

and I have added Bill Irwin's alterations to the patch, described here:
	http://www.cs.helsinki.fi/linux/linux-kernel/2002-28/1287.html

Given the late hour, I have almost certainly forgotten some hooks in 
vmscan, so count it as a first, harmless cut at the problem.  Feedback 
and fixes welcome! :)

For 2.5.27, I'll make sure this patch is incremental to Rik's stats patch, 
and not a replacement for it.  Sorry 'bout that...

Craig Kulesa
Steward Observatory
Univ. of Arizona

