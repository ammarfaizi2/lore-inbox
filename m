Return-Path: <linux-kernel-owner+w=401wt.eu-S1751830AbXAOIh7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751830AbXAOIh7 (ORCPT <rfc822;w@1wt.eu>);
	Mon, 15 Jan 2007 03:37:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751826AbXAOIh7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Jan 2007 03:37:59 -0500
Received: from nat-132.atmel.no ([80.232.32.132]:63218 "EHLO relay.atmel.no"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751830AbXAOIh6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Jan 2007 03:37:58 -0500
Date: Mon, 15 Jan 2007 09:37:35 +0100
From: Haavard Skinnemoen <hskinnemoen@atmel.com>
To: Ben Nizette <ben.nizette@iinet.net.au>
Cc: Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH -mm] AVR32: fix build breakage
Message-ID: <20070115093735.6dc06b9c@dhcp-252-105.norway.atmel.com>
In-Reply-To: <45AAF9A9.9080501@iinet.net.au>
References: <45AAF9A9.9080501@iinet.net.au>
Organization: Atmel Norway
X-Mailer: Sylpheed-Claws 2.6.0 (GTK+ 2.8.20; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 15 Jan 2007 14:48:57 +1100
Ben Nizette <ben.nizette@iinet.net.au> wrote:

> Remove an unwanted remnant of the recent revert of AVR32/AT91 SPI 
> patches in -mm.  Without this patch, the AVR32 build of 
> 2.6.20-rc[34]-mm1 breaks.

Actually, this is broken in my tree. Wonder how I managed to do that
and not even notice it.

I'll apply this patch and push out a new avr32-arch branch for Andrew.
Thanks for testing.

Haavard
