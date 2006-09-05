Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965077AbWIEOSj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965077AbWIEOSj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Sep 2006 10:18:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965075AbWIEOSi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Sep 2006 10:18:38 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:22685 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S965073AbWIEOSh
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Sep 2006 10:18:37 -0400
Subject: Re: PATA drivers queued for 2.6.19
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Helge Hafting <helge.hafting@aitel.hist.no>
Cc: Jan Engelhardt <jengelh@linux01.gwdg.de>,
       Grant Coady <gcoady.lk@gmail.com>, Jeff Garzik <jeff@garzik.org>,
       "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <44FD7B1E.7020102@aitel.hist.no>
References: <44FC0779.9030405@garzik.org>
	 <po4of2pnhpc0325kqj2hd37b7eh3epcdsm@4ax.com>
	 <Pine.LNX.4.61.0609041406140.21005@yvahk01.tjqt.qr>
	 <44FD7B1E.7020102@aitel.hist.no>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Tue, 05 Sep 2006 15:39:36 +0100
Message-Id: <1157467176.9018.48.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Maw, 2006-09-05 am 15:26 +0200, ysgrifennodd Helge Hafting:
> between sda/hda unless they also use an initrd.  The kernel
> itself does not seem to support partition by label. :-(

This is correct and one reason vendor kernels generally use an initrd.
The kernel does however support "root=/dev/sda1"

Alan

