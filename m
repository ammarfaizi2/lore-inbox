Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131772AbRAOVv4>; Mon, 15 Jan 2001 16:51:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131773AbRAOVvq>; Mon, 15 Jan 2001 16:51:46 -0500
Received: from delta.ds2.pg.gda.pl ([153.19.144.1]:56269 "EHLO
	delta.ds2.pg.gda.pl") by vger.kernel.org with ESMTP
	id <S131772AbRAOVvb>; Mon, 15 Jan 2001 16:51:31 -0500
Date: Mon, 15 Jan 2001 22:51:04 +0100 (MET)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: "H. Peter Anvin" <hpa@transmeta.com>
cc: Hugh Dickins <hugh@veritas.com>, Linus Torvalds <torvalds@transmeta.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Andrea Arcangeli <andrea@suse.de>,
        Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] i386/setup.c cpuinfo notsc
In-Reply-To: <3A636E77.3A409B17@transmeta.com>
Message-ID: <Pine.GSO.3.96.1010115224843.16619d-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 15 Jan 2001, H. Peter Anvin wrote:

> Right, but I'd also like to see the global flags exported explicitly to
> /proc/cpuinfo.

 That's desirable, but how would we fit it into the existing layout? 
Would it be feasible to put it into /proc/cpuflags, instead?  Anyway, with
all necessary code and structures in place it will be a one-liner or so to
add, so I'll write the underlying code first.

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
