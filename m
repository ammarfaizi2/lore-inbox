Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267864AbUJONtq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267864AbUJONtq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Oct 2004 09:49:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267856AbUJONrR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Oct 2004 09:47:17 -0400
Received: from clock-tower.bc.nu ([81.2.110.250]:7119 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S267777AbUJONmQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Oct 2004 09:42:16 -0400
Subject: Re: Generic VESA framebuffer driver and Video card BOOT?
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Kendall Bennett <KendallB@scitechsoft.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <416E8322.25700.29ACC2F1@localhost>
References: <2PjiW-3hl-21@gated-at.bofh.it>
	 (Kendall Bennett's message of "Thu, 14 Oct 2004 21:20:10 +0200")  <416E8322.25700.29ACC2F1@localhost>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1097843969.9863.8.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Fri, 15 Oct 2004 13:39:33 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Iau, 2004-10-14 at 21:46, Kendall Bennett wrote:
> a way to spawn a user mode process that early in the boot sequence (it 
> would have to come from the initrd image I expect) then the only option 
> is to compile it into the kernel.

There is exactly that in 2.6 - the hotplug interfaces allow the kernel
to fire off userspace programs. Jon Smirl (who you should definitely
talk to about this stuff) has been hammering out a design for moving
almost all the mode switching into user space for kernel video.


