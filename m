Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263788AbTIDKyy (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Sep 2003 06:54:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264906AbTIDKyx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Sep 2003 06:54:53 -0400
Received: from zeus.kernel.org ([204.152.189.113]:10931 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S263788AbTIDKyw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Sep 2003 06:54:52 -0400
From: Tomasz =?ISO-8859-1?Q?=20B=B1tor?= <tomba@bartek.tu.kielce.pl>
Date: Thu, 4 Sep 2003 12:53:44 +0200
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: What is the SiI 0680 chipset status?
Message-ID: <20030904105344.GA14315@bartek.tu.kielce.pl>
References: <20030902165537.GA1830@bartek.tu.kielce.pl> <1062589779.19059.8.camel@dhcp23.swansea.linux.org.uk> <20030904014207.GA8579@bartek.tu.kielce.pl> <1062669964.21777.1.camel@dhcp23.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
In-Reply-To: <1062669964.21777.1.camel@dhcp23.swansea.linux.org.uk>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Witam,
Dnia Thu, Sep 04, 2003 at 11:06:06AM +0100 Alan Cox napisal(a):

> On Iau, 2003-09-04 at 02:42, Tomasz B??tor wrote:
> > It doesn't for me. I have no idea what could I possibly do wrong, but
> > I've tried dozens of possibilities without any luck. Compiling in
> > siimage.c = drive errors, ide2 reset and infinite loop of "lost
> > interrupt" messages at boot time. Without siimage.c compiled and with
> > ide2=xxx ide3=xxx parameters in lilo, disks are visible, but of course
> > there is no DMA.
> > 
> > Any ideas?
> 
> If you disable both APIC and ACPI support is it any happier ?

Now it's:

CONFIG_X86_GOOD_APIC=y
# CONFIG_X86_UP_APIC is not set
# CONFIG_X86_UP_IOAPIC is not set
# CONFIG_ACPI is not set

At night I'll try turning APIC on (I've never used this before) and disable
it in cmos like Bob said. We'll see.

t.

-- 
  Tomasz Bator  e-mail: tomba@bartek.tu.kielce.pl  ICQ: 101194886
 ------ ---- -- - -  -    -   -  -  -   -    -  - - -- ---- ------
"Today it's a race between programmers making better idiot proof software,
and the universe making better idiots. So far the universe is winning"
