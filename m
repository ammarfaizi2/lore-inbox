Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267926AbUJOPfs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267926AbUJOPfs (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Oct 2004 11:35:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268040AbUJOPfs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Oct 2004 11:35:48 -0400
Received: from clock-tower.bc.nu ([81.2.110.250]:21199 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S267926AbUJOPfp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Oct 2004 11:35:45 -0400
Subject: Re: Generic VESA framebuffer driver and Video card BOOT?
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Andi Kleen <ak@muc.de>
Cc: KendallB@scitechsoft.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <m3655cjc1r.fsf@averell.firstfloor.org>
References: <2Pkf0-42m-11@gated-at.bofh.it> <2PncW-6j9-19@gated-at.bofh.it>
	 <2PncW-6j9-21@gated-at.bofh.it> <20030401205016$5cc4@gated-at.bofh.it>
	 <20030401205016$63f7@gated-at.bofh.it>
	 <20030424075011$4028@gated-at.bofh.it> <1ewKr-2Kh-41@gated-at.bofh.it>
	 <CebL.O9.13@gated-at.bofh.it> <1bucs-57R-33@gated-at.bofh.it>
	 <2PncW-6j9-23@gated-at.bofh.it> <20030423094012$4166@gated-at.bofh.it>
	 <2PncW-6j9-17@gated-at.bofh.it> <2PAMY-7Ir-21@gated-at.bofh.it>
	 <m3655cjc1r.fsf@averell.firstfloor.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1097850784.9857.20.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Fri, 15 Oct 2004 15:33:05 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Gwe, 2004-10-15 at 15:22, Andi Kleen wrote:
> > There is exactly that in 2.6 - the hotplug interfaces allow the kernel
> > to fire off userspace programs. Jon Smirl (who you should definitely
> > talk to about this stuff) has been hammering out a design for moving
> > almost all the mode switching into user space for kernel video.
> 
> The problem is that this would imply that the console would only
> work after user space is running. Even with initrd that's quite late.

It doesn't imply this at all. You set an initial mode with the BIOS
during boot up. When your initrd runs you gain the ability to flip mode
and do cool stuff - arguably it doesn't even need to be in initrd.


