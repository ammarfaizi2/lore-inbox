Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262389AbSJVJrx>; Tue, 22 Oct 2002 05:47:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262395AbSJVJrx>; Tue, 22 Oct 2002 05:47:53 -0400
Received: from pc1-cwma1-5-cust42.swa.cable.ntl.com ([80.5.120.42]:52151 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S262389AbSJVJrw>; Tue, 22 Oct 2002 05:47:52 -0400
Subject: Re: PCI: Failed to allocate resource in 2.4.20pre10 and 11 - broken
	IRQ-router?
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Andreas Hartmann <andreas.hartmann@fiducia.de>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <OF4ECECA8D.86071157-ON41256C5A.0022B0DA@fag.fiducia.de>
References: <OF4ECECA8D.86071157-ON41256C5A.0022B0DA@fag.fiducia.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 22 Oct 2002 11:10:03 +0100
Message-Id: <1035281403.31873.37.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2002-10-22 at 07:28, Andreas Hartmann wrote:
> Hello all,
> 
> I'm using an IBM Thinkpad T21 with a dockingstation, which has an own additional
> ide-controller. At this controller, one more ATA-IDE hd is connected (/dev/hde).
> dmesg with kernel 2.4.19 looks like this (correct version):

Please send me an lspci -v. Im curious about this one because the dock
on my TP600 the IDE does work, although we dont yet support hot plugging
IDE. Also try 2.4.19 with the config you had in the working kernel - you
have explicit CMD64x in one but not the other

