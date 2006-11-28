Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1757377AbWK1Wwx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757377AbWK1Wwx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Nov 2006 17:52:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757477AbWK1Wwx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Nov 2006 17:52:53 -0500
Received: from smtp.osdl.org ([65.172.181.25]:18871 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1757377AbWK1Wwu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Nov 2006 17:52:50 -0500
Date: Tue, 28 Nov 2006 14:49:07 -0800
From: Andrew Morton <akpm@osdl.org>
To: David Woodhouse <dwmw2@infradead.org>
Cc: Adrian Bunk <bunk@stusta.de>, linux-mtd@lists.infradead.org,
       linux-kernel@vger.kernel.org, Akinobu Mita <akinobu.mita@gmail.com>
Subject: Re: [-mm patch] drivers/mtd/nand/rtc_from4.c: use lib/bitrev.c
Message-Id: <20061128144907.a9f4bb21.akpm@osdl.org>
In-Reply-To: <1164752376.14595.22.camel@pmac.infradead.org>
References: <20061114014125.dd315fff.akpm@osdl.org>
	<20061122043811.GG5200@stusta.de>
	<1164752376.14595.22.camel@pmac.infradead.org>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 28 Nov 2006 22:19:36 +0000
David Woodhouse <dwmw2@infradead.org> wrote:

> On Wed, 2006-11-22 at 05:38 +0100, Adrian Bunk wrote:
> > This patch converts drivers/mtd/nand/rtc_from4.c to use the new 
> > lib/bitrev.c
> > 
> > Signed-off-by: Adrian Bunk <bunk@stusta.de>
> 
> Applied; thanks.
> 

Won't compile - you don't have the bitrev library patches.

I'll take that as an ack and shall merge this once
crc32-replace-bitreverse-by-bitrev32.patch is merged ;)

