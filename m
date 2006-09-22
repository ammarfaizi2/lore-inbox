Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751116AbWIVJYf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751116AbWIVJYf (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Sep 2006 05:24:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751119AbWIVJYe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Sep 2006 05:24:34 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:39332 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1751116AbWIVJYe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Sep 2006 05:24:34 -0400
Subject: Re: 2.6.19 -mm merge plans
From: David Woodhouse <dwmw2@infradead.org>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20060920135438.d7dd362b.akpm@osdl.org>
References: <20060920135438.d7dd362b.akpm@osdl.org>
Content-Type: text/plain
Date: Fri, 22 Sep 2006 10:24:06 +0100
Message-Id: <1158917046.24527.662.camel@pmac.infradead.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.3 (2.6.3-1.fc5.5.dwmw2.1) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-09-20 at 13:54 -0700, Andrew Morton wrote:
> 
> mtd-maps-ixp4xx-partition-parsing.patch
> fix-the-unlock-addr-lookup-bug-in-mtd-jedec-probe.patch
> mtd-printk-format-warning.patch
> fs-jffs2-jffs2_fs_ih-removal-of-old-code.patch
> drivers-mtd-nand-au1550ndc-removal-of-old-code.patch
> 
>  MTD queue -> dwmw2

Merged, with the exception of the unlock addr one which I'm still not
sure about -- about to investigate harder.

Also merged are
pci-mtd-switch-to-pci_get_device-and-do-ref-counting.patch and
avr32-mtd-unlock-flash-if-necessary.patch

-- 
dwmw2

