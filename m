Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261573AbSJALSn>; Tue, 1 Oct 2002 07:18:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261581AbSJALSn>; Tue, 1 Oct 2002 07:18:43 -0400
Received: from pc1-cwma1-5-cust51.swa.cable.ntl.com ([80.5.120.51]:64249 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S261573AbSJALSm>; Tue, 1 Oct 2002 07:18:42 -0400
Subject: Re: v2.6 vs v3.0
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Mikael Pettersson <mikpe@csd.uu.se>
Cc: Jens Axboe <axboe@suse.de>,
       Linux-Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <15769.21706.618421.684462@kim.it.uu.se>
References: <20020929091229.GA1014@suse.de>
	<Pine.LNX.3.96.1020930151754.20863I-100000@gatekeeper.tmr.com>
	<20021001062630.GM3867@suse.de>  <15769.21706.618421.684462@kim.it.uu.se>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 01 Oct 2002 12:31:10 +0100
Message-Id: <1033471870.20103.4.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2002-10-01 at 08:54, Mikael Pettersson wrote:
> - I have several boxes with decent PCI chipsets (BX, HX) but old disks.
>   With 2.5.39, they tend to spew a couple of ..._intr errors on boot.
>   (Sorry, can't be more specific right now. I won't be near those
>   boxes until Saturday.)

Thats fine. Its issuing commands the drives reject. Right now we dont do
it quietly that is all.

> - Same ..._intr errors on my 486 with a qd6580 VLB controller.
>   It also has, in post-2.5.36 kernels, an instant-reboot problem which
>   occurs whenever I pass the ide0=qd65xx kernel option required to

Seems to be specific to the 2.5.x version of the new ide so I guess its
a port error (or just bad luck it now breaks and was iffy before)

> - My Intel AL440LX box (440LX chipset, 20G Quantum Fireball) worked
>   brilliantly up to 2.5.36, but hangs *hard* with 2.5.39 as soon
>   as I tar zxf the kernel source tarball.
>   (May or may not be IDE. I'll try a minimal 2.5.39 tonight.)

Thats PIIX, which should be the most boringly stable configuration of
the lot 8(

