Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422634AbWKHTjA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422634AbWKHTjA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Nov 2006 14:39:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422638AbWKHTjA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Nov 2006 14:39:00 -0500
Received: from nat-132.atmel.no ([80.232.32.132]:8154 "EHLO relay.atmel.no")
	by vger.kernel.org with ESMTP id S1422634AbWKHTi7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Nov 2006 14:38:59 -0500
Date: Wed, 8 Nov 2006 20:33:58 +0100
From: Haavard Skinnemoen <hskinnemoen@atmel.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Andrew Victor <andrew@sanpeople.com>, Jeff Garzik <jgarzik@pobox.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: [-mm patch 0/2] MACB driver update
Message-ID: <20061108203358.558c28d3@cad-250-152.norway.atmel.com>
Organization: Atmel Norway
X-Mailer: Sylpheed-Claws 2.5.6 (GTK+ 2.8.20; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew,

After Andrew Victor explained to me how at91rm9200 does hardware
address initialization and phy probing, I decided to give it a go on
avr32 as well. So here's one patch for the avr32 platform code and one
for the actual macb driver which implements those changes.

I suspect that the avr32 platform patches might get messy, so feel free
to drop them all and pull from the master branch of

	git://www.atmel.no/~hskinnemoen/linux/kernel/avr32.git master

instead. I won't put any new drivers or updates to drivers that are not
in mainline there.

I will still post patches for the avr32 platform code just to show how
things are affecting the platform-specific bits.

Haavard
