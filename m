Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267970AbUHPWIW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267970AbUHPWIW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Aug 2004 18:08:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267972AbUHPWIW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Aug 2004 18:08:22 -0400
Received: from fw.osdl.org ([65.172.181.6]:226 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S267970AbUHPWIV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Aug 2004 18:08:21 -0400
Date: Mon, 16 Aug 2004 15:06:41 -0700
From: Andrew Morton <akpm@osdl.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: ecki-news2004-05@lina.inka.de, linux-kernel@vger.kernel.org
Subject: Re: Linux SATA RAID FAQ
Message-Id: <20040816150641.108c66a6.akpm@osdl.org>
In-Reply-To: <1092315392.21994.52.camel@localhost.localdomain>
References: <E1BvFmM-0007W5-00@calista.eckenfels.6bone.ka-ip.net>
	<1092315392.21994.52.camel@localhost.localdomain>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
>
> I'm currently trying to fix up the IT8212 which is an older PATA board
>  which does have real h/w raid 0/1

I'm sitting on the vendor's driver for these cards.  How does your work
differ from this?

hch questioned why we need the driver at all: just put the card in JBOD
mode and use s/w raid drivers.  But the thing does have an on-board CPU and
the idea is that by offloading to that, the data transits the bus just a
single time.  The developers are off doing some comparative benchmarking at
present.

