Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131165AbQKJPtw>; Fri, 10 Nov 2000 10:49:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131183AbQKJPtm>; Fri, 10 Nov 2000 10:49:42 -0500
Received: from pizda.ninka.net ([216.101.162.242]:21124 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S131165AbQKJPt3>;
	Fri, 10 Nov 2000 10:49:29 -0500
Date: Fri, 10 Nov 2000 07:34:53 -0800
Message-Id: <200011101534.HAA25728@pizda.ninka.net>
From: "David S. Miller" <davem@redhat.com>
To: trini@kernel.crashing.org
CC: bh40@calva.net, alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org
In-Reply-To: <20001110084211.B24101@opus.bloom.county> (message from Tom Rini
	on Fri, 10 Nov 2000 08:42:11 -0700)
Subject: Re: Linux 2.2.18pre21
In-Reply-To: <200011100344.TAA01282@pizda.ninka.net> <19341005050711.11931@192.168.1.2> <20001110084211.B24101@opus.bloom.county>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   Date: Fri, 10 Nov 2000 08:42:11 -0700
   From: Tom Rini <trini@kernel.crashing.org>

   One question here.  Is it important here that the # be consistant?
   I mean since to change a sysctl isn't the name the important bit?
   ie: dev.md.speed_limit would work regardless of if DEV_MD is 3 or
   4?

These nodes are accessible via both /proc/sys/* and the
sys_sysctl(...) system call, the latter uses the numbers
so they are hard coded into application binaries.

Later,
David S. Miller
davem@redhat.com
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
