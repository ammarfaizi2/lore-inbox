Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129404AbQLAJlL>; Fri, 1 Dec 2000 04:41:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129514AbQLAJlB>; Fri, 1 Dec 2000 04:41:01 -0500
Received: from max.phys.uu.nl ([131.211.32.73]:58892 "EHLO max.phys.uu.nl")
	by vger.kernel.org with ESMTP id <S129404AbQLAJkt>;
	Fri, 1 Dec 2000 04:40:49 -0500
Date: Fri, 1 Dec 2000 10:10:22 +0100 (MET)
From: Dries van Oosten <D.vanOosten@phys.uu.nl>
To: <linux-kernel@vger.kernel.org>
Subject: 2.4 routing problem
Message-ID: <Pine.OSF.4.30.0012011006130.5824-100000@ruunat.phys.uu.nl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Can someone point me to how routing is done in the 2.4 kernel?
My net-tools don't work anymore (specifically route fails to produce the
routing table). I look around a bit in the kernel sources and notice
things have changed. What kind of options are there now to influence the
routing table?

Groeten,
Dries
p.s. I also noticed that the rtable struct in include/route.h has an extra
element squeezed in (inet_peer has been added). The version of route.h is
however the same as that of the 2.2.16 kernel. I would say that this
change justifies mentioning. How strict is the versioning of files in the
kernel sources?

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
