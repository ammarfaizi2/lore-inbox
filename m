Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275853AbRJBHxH>; Tue, 2 Oct 2001 03:53:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275856AbRJBHw5>; Tue, 2 Oct 2001 03:52:57 -0400
Received: from zok.SGI.COM ([204.94.215.101]:35042 "EHLO zok.sgi.com")
	by vger.kernel.org with ESMTP id <S275853AbRJBHwx>;
	Tue, 2 Oct 2001 03:52:53 -0400
From: "LA Walsh" <law@sgi.com>
To: <linux-kernel@vger.kernel.org>
Subject: 'dd' local works, but not over net, help as to why?
Date: Tue, 2 Oct 2001 00:52:48 -0700
Message-ID: <NDBBJDKDKDGCIJFBPLFHMEJPCGAA.law@sgi.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2911.0)
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4522.1200
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I'm sure there's an obvious answer to this, but it is eluding me.

If I am on my local laptop, I can 'dd' an 8G partition to a
removable HD of the same or slightly larger size (slightly large
because of geometry differences).

If I am on my desktop, "I can 'dd' the same size partition to
a slightly larger one -- again, no problem.

But if I use:

dd if=/dev/hda2 bs=1M|rsh other-system of=/dev/sda2 bs=1M, I
get failures of running out of room on target.  I've tried
a variety of block size ranging from 1K->64G, but no luck.

Is there something in the networking code that's preventing me
from transferring more than a 2 or 4 G limit?

I just wanted an exact image off onto another system.  Would
seem to have been straight forwared. but I guess not?  

Thanks in advance for any work-arounds and explanations...

-linda

