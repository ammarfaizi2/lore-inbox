Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262646AbSLAVfc>; Sun, 1 Dec 2002 16:35:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262662AbSLAVfc>; Sun, 1 Dec 2002 16:35:32 -0500
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:3308 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S262646AbSLAVfb>; Sun, 1 Dec 2002 16:35:31 -0500
Date: Sun, 1 Dec 2002 16:42:59 -0500
From: Pete Zaitcev <zaitcev@redhat.com>
Message-Id: <200212012142.gB1Lgxj27699@devserv.devel.redhat.com>
To: linux-kernel@vger.kernel.org
Subject: Re: asm/io_apic.h is missing in drivers/pci/quirks.c with kernel 2.5.50
In-Reply-To: <mailman.1038570720.26419.linux-kernel2news@redhat.com>
References: <mailman.1038570720.26419.linux-kernel2news@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> in file drivers/pci/quirks.c of linux kernel 2.5.50
> 
> #include <asm/io_apic.h>
> 
> is missing.

What about architectures which do not have the said header,
because they have no apics? I do not think this is a good idea.

-- Pete
