Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262153AbTIAE1j (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Sep 2003 00:27:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262263AbTIAE1j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Sep 2003 00:27:39 -0400
Received: from rwcrmhc11.comcast.net ([204.127.198.35]:17832 "EHLO
	rwcrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S262153AbTIAE1i (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Sep 2003 00:27:38 -0400
Subject: bitkeeper comments
From: Albert Cahalan <albert@users.sf.net>
To: linux-kernel mailing list <linux-kernel@vger.kernel.org>
Cc: Linus Torvalds <torvalds@osdl.org>, ak@suse.de, lm@bitmover.com
Content-Type: text/plain
Organization: 
Message-Id: <1062389729.314.31.camel@cube>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 01 Sep 2003 00:15:30 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This just got into BitKeeper, about 10 hours ago:

> [PATCH] x86-64 update
>
> Make everything compile and boot again.
>
> The earlier third party ioport.c changes unfortunately
> didn't even compile, fix that too.
>
> - Update defconfig
> - Some minor cleanup
> - Introduce physid_t for APIC masks (fixes UP kernels)
> - Finish ioport.c merge and fix compilation

Several days ago, I mailed Andi Kleen a build log which
showed that ioport.c builds perfectly well on x86-64.
The whole 2.6.0-test4 kernel does in fact, as downloaded
from kernel.org. Andi Kleen agreed...

...and now this comment gets submitted to Linus, ending
up in BitKeeper. I'd like this changed. I realize that
it may be a rather difficult thing to change at this point,
but it is clearly wrong.


