Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132800AbRDIRCe>; Mon, 9 Apr 2001 13:02:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132801AbRDIRCZ>; Mon, 9 Apr 2001 13:02:25 -0400
Received: from battlejitney.wdhq.scyld.com ([216.254.93.178]:16370 "EHLO
	vaio.greennet") by vger.kernel.org with ESMTP id <S132800AbRDIRCJ>;
	Mon, 9 Apr 2001 13:02:09 -0400
Date: Mon, 9 Apr 2001 13:03:31 -0400 (EDT)
From: Donald Becker <becker@scyld.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH 2.4.2] ne.c: Add to bad_clone_list
Message-ID: <Pine.LNX.4.10.10104091238440.4813-100000@vaio.greennet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>From: Jan-Benedict Glaw (jbglaw@lug-owl.de)
>Date: Mon Apr 09 2001 - 12:07:16 EDT 

>This allows me to use some (old and broken) AT/LANTIC boards. 

Please re-test this patch.

Boards based on DP83905 AT/LANTIC chip should never need to be added to
the bad clone list.  The bad clone list should now be almost read-only,
since it's very unlikely that anyone is making new ISA NE2000 and not
following the design rules.

Donald Becker				becker@scyld.com
Scyld Computing Corporation		http://www.scyld.com
410 Severn Ave. Suite 210		Second Generation Beowulf Clusters
Annapolis MD 21403			410-990-9993

