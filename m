Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261593AbSJYUo7>; Fri, 25 Oct 2002 16:44:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261596AbSJYUo7>; Fri, 25 Oct 2002 16:44:59 -0400
Received: from pc1-cwma1-5-cust42.swa.cable.ntl.com ([80.5.120.42]:21703 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S261593AbSJYUo7>; Fri, 25 Oct 2002 16:44:59 -0400
Subject: Re: [OT]AMD/Intel interrupt latency (jitter) differences?
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: markh@compro.net
Cc: root@chaos.analogic.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <3DB9AD6D.C96A5398@compro.net>
References: <Pine.LNX.3.95.1021025155330.3856A-100000@chaos.analogic.com> 
	<3DB9AD6D.C96A5398@compro.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 25 Oct 2002 22:08:28 +0100
Message-Id: <1035580108.13032.79.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2002-10-25 at 21:45, Mark Hounschell wrote:
> That makes sense. But, both these Intel and AMD boxes have pretty much the same
> config as far as pci cards and pci busses. They both have 1 or 2 66mhz and a 33
> mhz bus. 
> The Intel box used right now is a Super-micro p4dc6+ and only has our 2 33mhz
> cards in it. It has on board UW-scsi-2 controller using a 66MHz bus where as the
> AMD has no controllers on the 66mhz bus. It is using the onboard IDE controller.
> The intel has built in network card that IS active when running the emulation
> and the AMD has a 3c905 card that is also active. Other than that they are the
> same. I thought all recent pci cards were bus mastering capable these days??

Pretty much. IDE and graphics cards tend to be badly behaved at times
but the other stuff ought to behave better. The AMD does have some
tunables about fairness/performance etc in the chipset. I wonder which
way the vendor sets them

