Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265200AbTLFPhR (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 6 Dec 2003 10:37:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265201AbTLFPhR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Dec 2003 10:37:17 -0500
Received: from legolas.restena.lu ([158.64.1.34]:31419 "EHLO smtp.restena.lu")
	by vger.kernel.org with ESMTP id S265200AbTLFPhL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Dec 2003 10:37:11 -0500
Subject: Re: [PATCH] Re: Catching NForce2 lockup with NMI watchdog - found
From: Craig Bradney <cbradney@zip.com.au>
To: linux-kernel@vger.kernel.org
In-Reply-To: <3FD1F172.2070601@gmx.de>
References: <DCB9B7AA2CAB7F418919D7B59EE45BAF49F87E@mail-sc-6.nvidia.com>
	 <20031206081848.GA4023@localnet> <3FD1CA81.9010708@gmx.de>
	 <200312061411.37795.bzolnier@elka.pw.edu.pl>  <3FD1F172.2070601@gmx.de>
Content-Type: text/plain
Message-Id: <1070725028.12998.21.camel@athlonxp.bradney.info>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Sat, 06 Dec 2003 16:37:08 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2003-12-06 at 16:10, Prakash K. Cheemplavam wrote:
> Bartlomiej Zolnierkiewicz wrote:
> > It is possible :-).  Here is a completly untested patch.
> > 
> > [PATCH] fix lockups with APIC support on nForce2
> 
> 
> I tried it (applied pacth and *enabled* CPU disconnect in bios) and it 
> works! Good work. Nevertheless, it is no real fix, just a work-around. 
> Perhaps somone from nvidia should comment on this...or some APIC guru 
> needs to take a look into the code.

So.. if you find long term stability with this.. then maybe it relates
to disconnect but perhaps is just a method of increasing the time
between crashes and the patch is a correct workaround? But why isnt it a
"real" fix if the timer IRQ is not set up correctly without?

I would also like an nvidia or apic opinion on this one.

Craig

