Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030513AbWK3PcN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030513AbWK3PcN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Nov 2006 10:32:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030528AbWK3PcM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Nov 2006 10:32:12 -0500
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:24209 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1030513AbWK3PcL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Nov 2006 10:32:11 -0500
Date: Thu, 30 Nov 2006 15:39:06 +0000
From: Alan <alan@lxorguk.ukuu.org.uk>
To: Yaroslav Halchenko <yoh@psychology.rutgers.edu>
Cc: linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: kswapd/tg3 issue
Message-ID: <20061130153906.59d78223@localhost.localdomain>
In-Reply-To: <20061130151003.GM2021@washoe.onerussian.com>
References: <20061130144355.GK2021@washoe.onerussian.com>
	<20061130150406.3d0b6afd@localhost.localdomain>
	<20061130151003.GM2021@washoe.onerussian.com>
X-Mailer: Sylpheed-Claws 2.6.0 (GTK+ 2.8.20; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 30 Nov 2006 10:10:03 -0500
Yaroslav Halchenko <yoh@psychology.rutgers.edu> wrote:

> Thank you Alan
> 
> Ok - I am adding more memory in my purchasing plan ;-) For now I guess
> adding swap space should help, right?

Under heavy network or I/O pressure it may not have time to swap to get
the memory. Thus adding swap won't usually help. Adding RAM may do but
its often not the best answer. Arjan's suggestion should sort it, and -
yes typically boxes with very high I/O and network load need more of a
pool of memory free for immediate use than other systems.
