Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270240AbRHMPIC>; Mon, 13 Aug 2001 11:08:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270246AbRHMPHw>; Mon, 13 Aug 2001 11:07:52 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:53765 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S270240AbRHMPHj>; Mon, 13 Aug 2001 11:07:39 -0400
Subject: Re: struct page to 36 (or 64) bit bus address?
To: davem@redhat.com (David S. Miller)
Date: Mon, 13 Aug 2001 16:10:07 +0100 (BST)
Cc: alan@lxorguk.ukuu.org.uk, sandy@storm.ca, linux-kernel@vger.kernel.org
In-Reply-To: <no.id> from "David S. Miller" at Aug 13, 2001 07:21:57 AM
X-Mailer: ELM [version 2.5 PL5]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15WJLz-0007ae-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> And net drivers would do something similar, registering something
> that will do "netdev_wake_queue();" etc.

I don't want a callback, or if you give me a callback for scsi I'll just
turn it into a callback to wake_up(). Thats all I happen to need. net
drivers might be different

Alan
