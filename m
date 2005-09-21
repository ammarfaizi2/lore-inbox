Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751241AbVIURKt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751241AbVIURKt (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Sep 2005 13:10:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751253AbVIURKt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Sep 2005 13:10:49 -0400
Received: from teetot.devrandom.net ([66.35.250.243]:5297 "EHLO
	teetot.devrandom.net") by vger.kernel.org with ESMTP
	id S1751241AbVIURKs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Sep 2005 13:10:48 -0400
Date: Wed, 21 Sep 2005 10:21:57 -0700
From: thockin@hockin.org
To: "Shawn M. Campbell" <scampbell@malone.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: PCI Express or TG3 issue
Message-ID: <20050921172156.GA31339@hockin.org>
References: <433182C8.2060006@malone.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <433182C8.2060006@malone.edu>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 21, 2005 at 11:56:56AM -0400, Shawn M. Campbell wrote:
> 0000:02:00.0 Ethernet controller: Broadcom Corporation NetXtreme BCM5751
> Gigabit Ethernet PCI Express (rev 11)
>         Subsystem: IBM: Unknown device 02f7
>         Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
> ParErr+ Stepping- SERR+ FastB2B-
>         Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
> <TAbort- <MAbort- >SERR- <PERR-
>         Latency: 0, Cache Line Size: 0x08 (32 bytes)
>         Interrupt: pin A routed to IRQ 5
>         Region 0: Memory at <ignored> (64-bit, non-prefetchable)
                    ^^^^^^^^^^^^^^^^^^
		    Problem.

hexdump /proc/bus/pci/02/00.0 and send it here.
