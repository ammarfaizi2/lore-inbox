Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1945998AbWGOH3D@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1945998AbWGOH3D (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 15 Jul 2006 03:29:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946001AbWGOH3C
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 15 Jul 2006 03:29:02 -0400
Received: from quasar.dynaweb.hu ([195.70.37.87]:52869 "EHLO quasar.dynaweb.hu")
	by vger.kernel.org with ESMTP id S1945998AbWGOH3A (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 15 Jul 2006 03:29:00 -0400
Date: Sat, 15 Jul 2006 09:28:56 +0200
From: Rumi Szabolcs <rumi_ml@rtfm.hu>
To: "Allen Martin" <AMartin@nvidia.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Athlon64 + Nforce4 MCE panic
Message-Id: <20060715092856.7f9882f5.rumi_ml@rtfm.hu>
In-Reply-To: <DBFABB80F7FD3143A911F9E6CFD477B00E48CFD9@hqemmail02.nvidia.com>
References: <20060714093749.07529924.rumi_ml@rtfm.hu>
	<DBFABB80F7FD3143A911F9E6CFD477B00E48CFD9@hqemmail02.nvidia.com>
X-Mailer: Sylpheed version 2.2.5 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 14 Jul 2006 11:18:38 -0700
"Allen Martin" <AMartin@nvidia.com> wrote:

> > 1x Asrock NF4G-SATA2 motherboard 
> > (http://www.asrock.com/product/939NF4G-SATA2.htm)
> > 1x Athlon64 "Venice" 3500+ with a huge Arctic cooler
> > 1x Corsair kit of 2 matched 512MB DDR400 modules
> > 1x Seagate 160GB SATA drive
> > 1x well ventilated Chieftec rackmount chassis w/PSU
> 
> You don't have any PATA devices at all?  SATA is a lot more resilient to
> this type of problem.

Exactly. I hooked up a PATA CDROM temporarily when I changed the mobo,
but otherwise the only storage it has is that SATA disk.

> > So I have a reason to believe that this could be a chipset specific
> > problem which not only affects me but quite a number of NF4 users,
> > most of which (using Windo$$$) will probably never know why their
> > system suddenly hung after some weeks or months of use...
> 
> Windows will generate a bugcheck on an MCA exception just like Linux.
> We have really detailed statistics on Windows bugchecks due to OCA, so I
> know this is not a widespread issue at least on Windows.

Do you think that this problem is caused by or at least triggered by
Linux or it's disk usage patterns? At least if you type "b200000000070f0f"
into g00gle you get a lot of hits all of which has something to do with
Linux.

> The stack trace will almost always tell you exactly what device timed
> out the PIO, you should start there.

Well I have to admit I'm not a kernel hacker but a simple user without a clue
so I have no idea how I could have got a stack trace from a kernel that is
paniced, frozen hard, and couldn't even sync it's disks so after I realized
there is no reaction to any input devices on the system I've just hit the
reset button and hoped it will come up again. I guess this is exactly what
Windo$$$ users used to do when they get a blue screen... ;)

Thanks!

Regards,

Sab
