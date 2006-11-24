Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1757762AbWKXN3M@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757762AbWKXN3M (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Nov 2006 08:29:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757764AbWKXN3M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Nov 2006 08:29:12 -0500
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:52165 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1757761AbWKXN3L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Nov 2006 08:29:11 -0500
Date: Fri, 24 Nov 2006 13:33:31 +0000
From: Alan <alan@lxorguk.ukuu.org.uk>
To: "Martin A. Fink" <fink@mpe.mpg.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: SATA Performance with Intel ICH6
Message-ID: <20061124133331.6bf0d7cc@localhost.localdomain>
In-Reply-To: <200611241407.01210.fink@mpe.mpg.de>
References: <200611241407.01210.fink@mpe.mpg.de>
X-Mailer: Sylpheed-Claws 2.6.0 (GTK+ 2.8.20; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 24 Nov 2006 14:07:01 +0100
"Martin A. Fink" <fink@mpe.mpg.de> wrote:

> If I understand the design of this chipset correctly, then I would have
> expected, that the CPU needs to do only few work, instead I found out, that
> writing to disk seems to be really hard work for the CPU.

It has some work to do - the amount in question depends upon the file
system and device drivers in use. For very high throughput read up on
the O_DIRECT feature.

> My final aim is to get around 140MB/s of data from 3 different Gigabit
> Ethernet cards and store it on 3 harddisk drives that perform 50MB/s.
> >From the SATA bus side there should be no problem. Each of the 4 SATAs on
> this ICH6 chipset are capable of 150MB/s.

I doubt an ICH6 has the total memory bandwidth to achieve that to be
honest, but with PCI-E maybe you can.
 
> So what makes my CPU that slow? Is it a hardware problem or a problem of
> SATA driver of my operating system?

You don't give anything like enough information to even guess this. What
controller, what disks, what driver, what kernel version ?

> By the way: I'm working with SuSE Linux 9.2 on a Dell Desktop PC, 1GB RAM

For vendor kernels, especially older ones it is probably best to ask the
vendor first.

Alan

