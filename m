Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262720AbVCDKvg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262720AbVCDKvg (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Mar 2005 05:51:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262633AbVCDKvf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Mar 2005 05:51:35 -0500
Received: from clock-tower.bc.nu ([81.2.110.250]:53466 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S262720AbVCDKtz
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Mar 2005 05:49:55 -0500
Subject: Re: IDE locking (was: Re: RFD: Kernel release numbering)
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: CaT <cat@zip.com.au>
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20050304014415.GG30616@zip.com.au>
References: <20050302205826.523b9144.davem@davemloft.net>
	 <4226C235.1070609@pobox.com> <20050303080459.GA29235@kroah.com>
	 <4226CA7E.4090905@pobox.com>
	 <Pine.LNX.4.58.0503030750420.25732@ppc970.osdl.org>
	 <42274171.3030702@nortel.com> <20050303165940.GA11144@kroah.com>
	 <1109893901.21780.68.camel@localhost.localdomain>
	 <20050304001930.GF30616@zip.com.au>
	 <1109897041.21781.75.camel@localhost.localdomain>
	 <20050304014415.GG30616@zip.com.au>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1109933282.26799.2.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Fri, 04 Mar 2005 10:48:04 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Gwe, 2005-03-04 at 01:44, CaT wrote:
> > Depends on your PCI bus and also if the are on the same IRQ. In the same
> Hmm. How can I check on this? What should I look for?

If you've got two promise cards on a VIA 133Mhz or early 266Mhz chipset
for example then there are large numbers of reports both Linux and other
OS about problems.

> The problems were weird. The fs I was copying from decided it was
> corrupt. Unmounting the partition and trying an fsck reported that it
> couldn't find the partition. After a reboot all was well and a fsck
> reported no problems.

That indicates the corruption was in memory not on disk. I take it the
box passes memtest86 fine however ?
