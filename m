Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267430AbUGNQPc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267430AbUGNQPc (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jul 2004 12:15:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267442AbUGNQP0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jul 2004 12:15:26 -0400
Received: from mail-relay-4.tiscali.it ([213.205.33.44]:36049 "EHLO
	mail-relay-4.tiscali.it") by vger.kernel.org with ESMTP
	id S267446AbUGNQOX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jul 2004 12:14:23 -0400
Date: Wed, 14 Jul 2004 18:14:11 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, torvalds@osdl.org, mason@suse.com
Subject: Re: writepage fs corruption fixes
Message-ID: <20040714161411.GC974@dualathlon.random>
References: <20040709040151.GB20947@dualathlon.random> <20040708212923.406135f0.akpm@osdl.org> <20040709044205.GF20947@dualathlon.random> <20040708215645.16d0f227.akpm@osdl.org> <20040710001600.GT20947@dualathlon.random> <20040710010738.GX20947@dualathlon.random> <20040710045920.GY20947@dualathlon.random> <20040709225634.2eb0b8b0.akpm@osdl.org> <20040710061133.GB20947@dualathlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040710061133.GB20947@dualathlon.random>
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

JFYI, the two writepages silent-fs-corruption fixes I posted in this
thread are reported to fix the ext2 fs corruption after 24 hours into
the test.  Need to pass 72 hours before it's officially fixed though
(only 1/3 is passed so far). Chris's memset(0) correctness fix is also
applied.
