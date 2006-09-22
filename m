Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932374AbWIVMdf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932374AbWIVMdf (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Sep 2006 08:33:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932379AbWIVMdf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Sep 2006 08:33:35 -0400
Received: from nat-132.atmel.no ([80.232.32.132]:53211 "EHLO relay.atmel.no")
	by vger.kernel.org with ESMTP id S932374AbWIVMde (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Sep 2006 08:33:34 -0400
Date: Fri, 22 Sep 2006 14:32:54 +0200
From: Haavard Skinnemoen <hskinnemoen@atmel.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, David Woodhouse <dwmw2@infradead.org>
Subject: Re: 2.6.19 -mm merge plans: AVR32
Message-ID: <20060922143254.50e25ebd@cad-250-152.norway.atmel.com>
In-Reply-To: <20060920135438.d7dd362b.akpm@osdl.org>
References: <20060920135438.d7dd362b.akpm@osdl.org>
Organization: Atmel Norway
X-Mailer: Sylpheed-Claws 2.5.0-rc2 (GTK+ 2.8.20; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 20 Sep 2006 13:54:38 -0700
Andrew Morton <akpm@osdl.org> wrote:

>  AVR32 architecture.  Will fold into a single patch, and will merge.

Thanks a lot :-) I will do my best to ensure it stays in good shape
during the -rc series.

> avr32-mtd-static-memory-controller-driver-try-2.patch
> avr32-mtd-at49bv6416-platform-device-for-atstk1000.patch
> avr32-mtd-unlock-flash-if-necessary.patch
> 
>  MTD changes for avr32.   Will send to dwmw2.

It might actually make more sense to fold the first two into the avr32
architecture patch. Especially now that David has picked up the third
one (which ended up not being AVR32-specific at all.)

The static memory controller driver isn't really specific to MTD
anyway, it should be equally useful for all kinds of external
memory-mapped devices including CompactFlash.

Haavard
