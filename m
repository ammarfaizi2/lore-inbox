Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161115AbWHDIwi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161115AbWHDIwi (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Aug 2006 04:52:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030224AbWHDIwi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Aug 2006 04:52:38 -0400
Received: from nat-132.atmel.no ([80.232.32.132]:34540 "EHLO relay.atmel.no")
	by vger.kernel.org with ESMTP id S1030209AbWHDIwh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Aug 2006 04:52:37 -0400
Date: Fri, 4 Aug 2006 10:52:20 +0200
From: Haavard Skinnemoen <hskinnemoen@atmel.com>
To: David Woodhouse <dwmw2@infradead.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MTD jedec_probe: Recognize Atmel AT49BV6416
Message-ID: <20060804105220.6d125976@cad-250-152.norway.atmel.com>
In-Reply-To: <1154680798.31031.179.camel@shinybook.infradead.org>
References: <11546801142874-git-send-email-hskinnemoen@atmel.com>
	<1154680798.31031.179.camel@shinybook.infradead.org>
Organization: Atmel Norway
X-Mailer: Sylpheed-Claws 2.3.1 (GTK+ 2.8.18; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 04 Aug 2006 16:39:58 +0800
David Woodhouse <dwmw2@infradead.org> wrote:

> On Fri, 2006-08-04 at 10:28 +0200, Haavard Skinnemoen wrote:
> > Atmel AT49BV6416 is used on the AT32STK1000 development board for
> > AVR32. This patch makes jedec_probe recognize it.
> 
> Ew. People are still making non-CFI chips?

It is actually a CFI chip. But I couldn't figure out how to install the
fixup in the other patch in the CFI code. The AT49BV6416 chip
identifies itself as using the AMD command set, so the fixup must be
installed based on the jedec ID...

Haavard
