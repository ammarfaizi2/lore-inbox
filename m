Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263638AbUC3NOx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Mar 2004 08:14:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263643AbUC3NOx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Mar 2004 08:14:53 -0500
Received: from chaos.analogic.com ([204.178.40.224]:12419 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S263638AbUC3NOw
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Mar 2004 08:14:52 -0500
Date: Tue, 30 Mar 2004 08:15:46 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
X-X-Sender: root@chaos
Reply-To: root@chaos.analogic.com
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Len Brown <len.brown@intel.com>, Willy Tarreau <willy@w.ods.org>,
       Arkadiusz Miskiewicz <arekm@pld-linux.org>,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       ACPI Developers <acpi-devel@lists.sourceforge.net>
Subject: Re: [ACPI] Re: Linux 2.4.26-rc1 (cmpxchg vs 80386 build)
In-Reply-To: <1080651370.25228.1.camel@dhcp23.swansea.linux.org.uk>
Message-ID: <Pine.LNX.4.53.0403300814350.5311@chaos>
References: <A6974D8E5F98D511BB910002A50A6647615F6939@hdsmsx402.hd.intel.com>
  <1080535754.16221.188.camel@dhcppc4>  <20040329052238.GD1276@alpha.home.local>
  <1080598062.983.3.camel@dhcppc4> <1080651370.25228.1.camel@dhcp23.swansea.linux.org.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 30 Mar 2004, Alan Cox wrote:

> On Llu, 2004-03-29 at 23:07, Len Brown wrote:
> > Linux uses this locking mechanism to coordinate shared access
> > to hardware registers with embedded controllers,
> > which is true also on uniprocessors too.
>
> If the ACPI layer simply refuses to run on a CPU without cmpxchg
> then I can't see there being a problem, there don't appear to be
> any 386 processors with ACPI
>

Yep, but to get to use cmpxchg, you need to compile as a '486 or
higher. This breaks i386.

Cheers,
Dick Johnson
Penguin : Linux version 2.4.24 on an i686 machine (797.90 BogoMips).
            Note 96.31% of all statistics are fiction.


