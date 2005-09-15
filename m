Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932595AbVIOXvP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932595AbVIOXvP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Sep 2005 19:51:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932598AbVIOXvP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Sep 2005 19:51:15 -0400
Received: from pop5-1.us4.outblaze.com ([205.158.62.125]:56205 "HELO
	pop5-1.us4.outblaze.com") by vger.kernel.org with SMTP
	id S932595AbVIOXvO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Sep 2005 19:51:14 -0400
From: "Peter T. Breuer" <ptb@inv.it.uc3m.es>
Message-Id: <200509152350.j8FNoTM17346@inv.it.uc3m.es>
Subject: .o.cmd files wanted, static analysis
To: "linux kernel" <linux-kernel@vger.kernel.org>
Date: Fri, 16 Sep 2005 01:50:29 +0200 (MET DST)
X-Anonymously-To: 
Reply-To: ptb@inv.it.uc3m.es
X-Mailer: ELM [version 2.4ME+ PL66 (25)]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

(was sent to Linux Testing Project list, but no answer there yet).


G'day all

I'm looking for a set of .*.o.cmd files for the 2.6 kernel. These are
generated when you compile the kernel. I have about 1600 of them from my
standard compilation choices, but I want the full 6000 odd so that I can
run static analysis tests.

See ftp://oboe.it.uc3m.es/pub/Programs/c-1.2.*.tgz

The currently enabled tests are for sleep under spinlock, double spinlock,
and access to kfree'd memory. I'll add more according to suggestions
received. About 3 errors in each class are detected for every 1000
kernel source files, with about three times that many false alarms
raised. It takes a few seconds per file, at about 10000 expanded lines
of code per second.

Does somebody out there have a pretty complete kernel compilation,
mainly all modules (though I don't care!), and could let me have their
 .*.o.cmd files? In fact, just the FIRST LINE of them.
 
That first line gives me the compile flags used.

Thanks.

Peter


