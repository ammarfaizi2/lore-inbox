Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262380AbSJ0Mr7>; Sun, 27 Oct 2002 07:47:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262381AbSJ0Mr7>; Sun, 27 Oct 2002 07:47:59 -0500
Received: from pc1-cwma1-5-cust42.swa.cable.ntl.com ([80.5.120.42]:62669 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S262380AbSJ0Mr6>; Sun, 27 Oct 2002 07:47:58 -0500
Subject: Re: Swap doesn't work
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Alexander.Riesen@synopsys.com
Cc: Vladim?r T?ebick? <guru@cimice.yo.cz>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20021027125021.GA1578@riesen-pc.gr05.synopsys.com>
References: <002501c27da9$2524d0f0$4500a8c0@cybernet.cz> 
	<20021027125021.GA1578@riesen-pc.gr05.synopsys.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 27 Oct 2002 13:12:28 +0000
Message-Id: <1035724348.30403.15.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2002-10-27 at 12:50, Alex Riesen wrote:
> On Sun, Oct 27, 2002 at 12:07:44PM +0100, Vladim?r T?ebick? wrote:
> > > Wow. Any of the errors above prevents swap partition from being used.
> > > How did you manage to see anything in /proc/swaps?
> > > I suggest you do:
> > >  swapoff /dev/hda6
> > >  badblocks /dev/hda6
> > Badblocks finds each time ONE bad block at the end of the partition no
> > matter where I create it or how large the partition is. Syslog shows this
> > message:
> > Oct 27 10:57:45 shunka kernel: attempt to access beyond end of device
> > Oct 27 10:57:45 shunka kernel: 03:06: rw=0, want=594376, limit=594373
> 
> That's not a badblock. That's an kernel IDE bug. Andre Hedrick and Alan
> Cox will love to see this.

Not on a kernel built with an untrusted hand built tool chain

