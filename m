Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131171AbRCUBkP>; Tue, 20 Mar 2001 20:40:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131063AbRCUBkG>; Tue, 20 Mar 2001 20:40:06 -0500
Received: from pizda.ninka.net ([216.101.162.242]:20096 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S130882AbRCUBj4>;
	Tue, 20 Mar 2001 20:39:56 -0500
From: "David S. Miller" <davem@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15032.1585.623431.370770@pizda.ninka.net>
Date: Tue, 20 Mar 2001 17:38:57 -0800 (PST)
To: buhr@stat.wisc.edu (Kevin Buhr)
Cc: Linus Torvalds <torvalds@transmeta.com>, Serge Orlov <sorlov@con.mcst.ru>,
        <linux-kernel@vger.kernel.org>,
        Jakob Østergaard <jakob@unthought.net>
Subject: Re: Linux 2.4.2 fails to merge mmap areas, 700% slowdown.
In-Reply-To: <vba1yrr7w9v.fsf@mozart.stat.wisc.edu>
In-Reply-To: <Pine.LNX.4.31.0103201042360.1990-100000@penguin.transmeta.com>
	<vba1yrr7w9v.fsf@mozart.stat.wisc.edu>
X-Mailer: VM 6.75 under 21.1 (patch 13) "Crater Lake" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Kevin Buhr writes:
 > If I recall correctly, RedHat's 2.96 was a modified development
 > snapshot of GCC 3.0, not an official GCC release.  If this is just a
 > quirk in 2.96 that can be fixed before the official release of 3.0 by
 > a trivial patch to libiberty, maybe your original hunch was right and
 > the kernel should be left as-is.

It is the garbage collector scheme used for memory allocation in gcc
>=2.96 that triggers the bad cases seen by Serge.

Later,
David S. Miller
davem@redhat.com
