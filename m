Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932254AbVIYSDv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932254AbVIYSDv (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Sep 2005 14:03:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751549AbVIYSDu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Sep 2005 14:03:50 -0400
Received: from S01060013109fe3d4.vc.shawcable.net ([24.85.133.133]:25501 "EHLO
	montezuma.fsmlabs.com") by vger.kernel.org with ESMTP
	id S1751547AbVIYSDu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Sep 2005 14:03:50 -0400
Date: Sun, 25 Sep 2005 11:09:56 -0700 (PDT)
From: Zwane Mwaikambo <zwane@arm.linux.org.uk>
To: "Protasevich, Natalie" <Natalie.Protasevich@UNISYS.com>
cc: Linux Kernel <linux-kernel@vger.kernel.org>, Andi Kleen <ak@suse.de>,
       "Nakajima, Jun" <jun.nakajima@intel.com>,
       "Raj, Ashok" <ashok.raj@intel.com>, bjorn.helgaas@hp.com
Subject: Re: [RFT][PATCH] i386 per cpu IDT (2.6.12-rc1-mm1)
In-Reply-To: <Pine.LNX.4.61.0509251101060.1684@montezuma.fsmlabs.com>
Message-ID: <Pine.LNX.4.61.0509251104210.1682@montezuma.fsmlabs.com>
References: <Pine.LNX.4.61.0509251101060.1684@montezuma.fsmlabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 25 Sep 2005, Zwane Mwaikambo wrote:

> Apologies for the long periods between updates, i've been doing some 
> relocating.
> 
> Changes since last post:
> 
> * Current interrupt handling domain is still on a node basis, although i 
> have moved over to dynamically allocated per cpu IDTs.

One thing i have to fix here is alignment of cpu_idt_table, since the per 
cpu allocator can't guarantee much in that regard.
