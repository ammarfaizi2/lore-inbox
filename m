Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932309AbVIEPc7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932309AbVIEPc7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Sep 2005 11:32:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932313AbVIEPc7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Sep 2005 11:32:59 -0400
Received: from [85.8.12.41] ([85.8.12.41]:12416 "EHLO smtp.drzeus.cx")
	by vger.kernel.org with ESMTP id S932309AbVIEPc6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Sep 2005 11:32:58 -0400
Message-ID: <431C6522.2090700@drzeus.cx>
Date: Mon, 05 Sep 2005 17:32:50 +0200
From: Pierre Ossman <drzeus-list@drzeus.cx>
User-Agent: Mozilla Thunderbird 1.0.6-5 (X11/20050818)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jeff Garzik <jgarzik@pobox.com>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] ISA DMA suspend for i386
References: <200509050815.j858FWrw027844@hera.kernel.org> <431C021C.2030603@pobox.com>
In-Reply-To: <431C021C.2030603@pobox.com>
X-Enigmail-Version: 0.90.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik wrote:
> 
> Where is CONFIG_PM?
> 
>     Jeff

I'm not sure you're receiving my mails, but I'll give it a try anyway.
It would also seem that my MTA is choking on your MX entries. I'll look
into that once I get home.

CONFIG_PM is missing because of consistency with i8259.c, on which the
code is based. So if it is desired I suppose a patch for them both would
be in order.

Rgds
Pierre

