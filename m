Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262032AbVCIRCz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262032AbVCIRCz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Mar 2005 12:02:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262047AbVCIRCz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Mar 2005 12:02:55 -0500
Received: from clock-tower.bc.nu ([81.2.110.250]:30090 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S262032AbVCIRCx
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Mar 2005 12:02:53 -0500
Subject: Re: [PATCH] Support for GEODE CPUs
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: torvalds@osdl.org
In-Reply-To: <200503081935.j28JZ433020124@hera.kernel.org>
References: <200503081935.j28JZ433020124@hera.kernel.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1110387668.28860.205.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Wed, 09 Mar 2005 17:01:09 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Maw, 2005-03-08 at 17:39, Linux Kernel Mailing List wrote:
> ChangeSet 1.2088, 2005/03/08 09:39:30-08:00, kianusch@sk-tech.net
> 
> 	[PATCH] Support for GEODE CPUs
> 	

This patch is also incorrect.

> 	This patch has been on my homepage
> 	(http://www.sk-tech.net/support/soekris.html) for quite a time - but I've
> 	been asked several time to have it included in the main kernel.

And I have each time pointed out it is wrong over time because

a) "Geode" (Geode GX) runs -m486 code faster than -m586
b) "Geode" as a name also includes AMD Athlon "Geode NX" processors
c) Geode GX does not need OOSTORE because the processor manages DMA
snooping in hardware.

Linus please drop this patch.

Alan

