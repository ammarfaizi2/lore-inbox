Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271310AbTHHMcF (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Aug 2003 08:32:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271311AbTHHMcF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Aug 2003 08:32:05 -0400
Received: from skif.spylog.com ([194.67.35.250]:14269 "EHLO mail.spylog.com")
	by vger.kernel.org with ESMTP id S271310AbTHHMcD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Aug 2003 08:32:03 -0400
Date: Fri, 8 Aug 2003 16:34:04 +0400
From: Andrey Nekrasov <andy@spylog.ru>
To: linux-kernel@vger.kernel.org
Subject: Re: 3ware Escalade 7500-4LP & linux 2.4.x
Message-ID: <20030808123404.GA43602@an.spylog.com>
Mail-Followup-To: Andrey Nekrasov <andy@spylog.ru>,
	linux-kernel@vger.kernel.org
References: <20030808103230.GA43166@an.spylog.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <20030808103230.GA43166@an.spylog.com>
Organization: SpyLOG ltd.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Linux kernel can't find controller:
> ...
> 3ware Storage Controller device driver for Linux v1.02.00.036.
> PCI: No IRQ known for interrupt pin A of device 02:02.0. Probably buggy MP table.
> scsi0 : Found a 3ware Storage Controller at 0x3000, IRQ: 0, P-chip: 1.3
> 3w-xxxx: scsi0: Error requesting IRQ: 0.
> 3w-xxxx: tw_findcards(): Error requesting irq for card 0.
> 3w-xxxx: No cards found.
> ...

 The problem is solved.
 At compilation of a kernel has included support ACPI. 

bye.
