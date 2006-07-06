Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965173AbWGFE0i@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965173AbWGFE0i (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jul 2006 00:26:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965174AbWGFE0i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jul 2006 00:26:38 -0400
Received: from smtp.osdl.org ([65.172.181.4]:8093 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S965173AbWGFE0h (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Jul 2006 00:26:37 -0400
Date: Wed, 5 Jul 2006 21:26:35 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Linux v2.6.18-rc1
Message-ID: <Pine.LNX.4.64.0607052115210.12404@g5.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Ok,
 the merge window for 2.6.18 is closed, and -rc1 is out there (git trees 
updated, the tar-ball and patches are still uploading over my pitiful DSL 
line - and as usual it may take a short while before mirroring takes 
place and distributes things across the globe).

The changes are too big for the mailing list, even just the shortlog. As 
usual, lots of stuff happened. Most architectures got updated, ACPI 
updates, networking, SCSI and sound, IDE, infiniband, input, DVB etc etc 
etc.

There's also a fair amount of basic infrastructure updates here, with 
things like the generic IRQ layer, the lockdep (oh, and priority- 
inheritance mutex support) stuff by Ingo &co, some generic 
timekeeping infrastructure ("clocksource") stuff, memory hotplug 
(and page migration) support, etc etc.

Git users should generally just select the part they are interested in, 
and do something like

	git log v2.6.17.. -- drivers/usb/ | git shortlog | less -S

to get a better and more focused view of what has changed.

Have fun,

		Linus
