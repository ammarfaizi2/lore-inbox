Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751601AbWFUOce@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751601AbWFUOce (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jun 2006 10:32:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751624AbWFUOcK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jun 2006 10:32:10 -0400
Received: from wildsau.enemy.org ([193.170.194.34]:48541 "EHLO
	wildsau.enemy.org") by vger.kernel.org with ESMTP id S1751629AbWFUObv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jun 2006 10:31:51 -0400
From: Herbert Rosmanith <kernel@wildsau.enemy.org>
Message-Id: <200606211425.k5LEPtY6012550@wildsau.enemy.org>
Subject: Re: gcc-4.1.1 and kernel-2.4.32
In-Reply-To: <Pine.LNX.4.61.0606211615390.31302@yvahk01.tjqt.qr>
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Date: Wed, 21 Jun 2006 16:25:55 +0200 (MET DST)
CC: linux-kernel@vger.kernel.org
X-Mailer: ELM [version 2.4ME+ PL100 (25)]
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> In effect (mainline) no. Linux 2.2 and 2.0 won't be fixed for the same 
> reason; called deep maintenance. 2.6 has been on the road since Dec 2003, 
> that's over 2 years. Do away with the old stuff.

we are in the process of switching, which is not unproblematic. on
the other hand, we have to support existing installations as well.

by the way ... "switching is not unproblematic": I just had to examine
a notebook which had problems with our software: a
"toshiba portege m400". 2.4 seems to work so far, as does 2.6.16.
I also tried 2.6.17, but get a strange problem: it simply hangs
after writing "PCI: probing hardware" (or similar). A closer look
reveals that it hangs in drivers/pci/probe.c, in pci_read_bases. What's
exactly going on, I don't know...

this shows that sometimes the old stuff works better than the new
stuff ;-)

kind regards,
h.rosmanith
