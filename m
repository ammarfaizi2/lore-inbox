Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268762AbUIGXUn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268762AbUIGXUn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Sep 2004 19:20:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268759AbUIGXSS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Sep 2004 19:18:18 -0400
Received: from mailgate.urz.tu-dresden.de ([141.30.66.154]:15776 "EHLO
	mailgate.urz.tu-dresden.de") by vger.kernel.org with ESMTP
	id S268762AbUIGXPi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Sep 2004 19:15:38 -0400
Date: Wed, 8 Sep 2004 01:15:36 +0200 (MEST)
From: Hendrik Fehr <s4248297@rcs.urz.tu-dresden.de>
To: linux-kernel@vger.kernel.org
Subject: Re: PROBLEM: Full CPU-usage on sis5513-chipset disc input/output-operations
In-Reply-To: <Pine.GSO.4.10.10409080011370.6828-100000@rcs54.urz.tu-dresden.de>
Message-ID: <Pine.GSO.4.10.10409080112400.7148-100000@rcs54.urz.tu-dresden.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-TUD-Virus-Scanned: by amavisd-new at rks24.urz.tu-dresden.de
X-TUD-Spam-Checker-Version: SpamAssassin 2.63 (2004-01-11) on rks24
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hello again!

SUMMARY:
I reported that i discover full cpu usage when performing disc i/o on an
sis5513 ide dma chipset. Disabling acpi and io-apic in the kernel and
passing pci=biosirq did not solve the problem. 

NEWS:
I think i found it!
I did not noticed that the /proc/stat fields changed between 2.4 and 2.6.
(my monitor util mystiriously couted/added "wating for io" to the sys cpu
time.)
That was what drived me crazy.
Yes, yes i did not check CHANGES file, sorry for the disturbing.

question: is "waiting for io" real cpu time, or can i consider this
time as idle? I was unable to figure this out by myself, sorry.
 
Best regards, 
Hendrik Fehr
PS: german for this is something like: "peinlich peinlich". 


