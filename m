Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286282AbRLJPMt>; Mon, 10 Dec 2001 10:12:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286283AbRLJPMj>; Mon, 10 Dec 2001 10:12:39 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:46856 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S286282AbRLJPMe>; Mon, 10 Dec 2001 10:12:34 -0500
Subject: Re: mm question
To: volodya@mindspring.com
Date: Mon, 10 Dec 2001 15:21:49 +0000 (GMT)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.20.0112101001220.17259-100000@node2.localnet.net> from "volodya@mindspring.com" at Dec 10, 2001 10:03:47 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16DSFZ-0002KX-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Right, but then my card refuses to dma into anything with address smaller
> than 04000000.

What was your board designer on when they decided to bar DMA below 64Mb ?

> amount) but this would place a big load on the system during buffer
> allocation.

And might never terminate

> I was hoping for something more elegant, but I am not adverse to writing
> my own get_free_page_from_range().

Thats not a trivial task.
