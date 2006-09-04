Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964904AbWIDNFF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964904AbWIDNFF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Sep 2006 09:05:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964902AbWIDNFF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Sep 2006 09:05:05 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:37854 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S964901AbWIDNFB
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Sep 2006 09:05:01 -0400
Subject: Re: PATA drivers queued for 2.6.19
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Grant Coady <gcoady.lk@gmail.com>
Cc: Jeff Garzik <jeff@garzik.org>,
       "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <po4of2pnhpc0325kqj2hd37b7eh3epcdsm@4ax.com>
References: <44FC0779.9030405@garzik.org>
	 <po4of2pnhpc0325kqj2hd37b7eh3epcdsm@4ax.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Mon, 04 Sep 2006 14:27:09 +0100
Message-Id: <1157376429.30801.57.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Llu, 2006-09-04 am 22:02 +1000, ysgrifennodd Grant Coady:
> I can't see an easy way to arrange multi-boot with different /etc/fstab 
> depending if I'm trying /dev/hdaX or /dev/sdaX.  Parallel '/' partitions?

Mount by label on modern distributions. You can also generally boot far
enough to just test by booting a libata kernel with
root=/dev/sdawhatever init=/bin/sh

Thats enough to get a test shell and poke around and check the boot
messages

