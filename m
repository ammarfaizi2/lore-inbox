Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131957AbRASQzp>; Fri, 19 Jan 2001 11:55:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132486AbRASQzf>; Fri, 19 Jan 2001 11:55:35 -0500
Received: from burdell.cc.gatech.edu ([130.207.3.207]:40966 "EHLO
	burdell.cc.gatech.edu") by vger.kernel.org with ESMTP
	id <S131957AbRASQzY>; Fri, 19 Jan 2001 11:55:24 -0500
From: "J.D. Hollis" <jdhollis@cc.gatech.edu>
To: <linux-kernel@vger.kernel.org>
Subject: class handles
Date: Fri, 19 Jan 2001 11:49:44 -0500
Message-ID: <CBECJLMFDMBGLDALACILMEHMCHAA.jdhollis@cc.gatech.edu>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2910.0)
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've been working on automatic assignment of unique class handles inside of
a system call.  I came across the function qdisc_alloc_handle in
net/sch_api.c, and I tried to use that.  it didn't work, and I'm sure I'm
missing something obvious.  I don't think I clearly understand how handles
are used in the kernel.  could someone explain to me how they work?  I've
read the source code and the comments, but I'm still not clear on just how
it all fits together.  thanks.

j.d.

p.s. could you please cc me, as I'm not subscribed to linux-kernel at the
moment.

---
J.D. Hollis (jdhollis@cc.gatech.edu)

"That which is overdesigned, too highly specific, anticipates outcome; the
anticipation of outcome guarantees, if not failure, the absence of grace." -
`All Tomorrow's Parties', William Gibson

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
