Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262025AbVAOBoZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262025AbVAOBoZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Jan 2005 20:44:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262069AbVAOBmX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Jan 2005 20:42:23 -0500
Received: from [81.2.110.250] ([81.2.110.250]:35561 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S262025AbVAOBh5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Jan 2005 20:37:57 -0500
Subject: Re: ServerWorks CSB6 DMA problems
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Gian-Carlo Pascutto <gpascutto@nero.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <41E83C2D.6070101@nero.com>
References: <41E83C2D.6070101@nero.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1105744528.9838.37.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Sat, 15 Jan 2005 00:33:25 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Gwe, 2005-01-14 at 21:39, Gian-Carlo Pascutto wrote:
> On a machine with a RHEL3 kernel (2.4.21-27.0.1.EL), the kernel seems to 
> enable UDMA33 on the first connected disk (Seagate 7200.7) but uses PIO 
> mode on the second (Maxtor 6Y080P0).
> 
> I found out this is for good reasons because after enabling UDMA100 on 
> both disks, via hdparm, filesystem corruption quickly resulted.

That all suprises me a great deal, although the modes are normally BIOS
selected by the Serverworks and then read by the kernel. CBS5/CSB6 IDE
should be very reliable indeed (OSB4 is a much older chipset and the
problem it has is OSB4 specific)

I'd also suggest you raise it with your RHEL support and/or
bugzilla.redhat.com

Alan

