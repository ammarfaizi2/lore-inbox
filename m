Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264490AbTIDBmQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Sep 2003 21:42:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264492AbTIDBmQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Sep 2003 21:42:16 -0400
Received: from bartek.tu.kielce.pl ([81.26.6.5]:42403 "EHLO
	bartek.tu.kielce.pl") by vger.kernel.org with ESMTP id S264490AbTIDBmO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Sep 2003 21:42:14 -0400
From: Tomasz =?ISO-8859-1?Q?=20B=B1tor?= <tomba@bartek.tu.kielce.pl>
Date: Thu, 4 Sep 2003 03:42:07 +0200
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: What is the SiI 0680 chipset status?
Message-ID: <20030904014207.GA8579@bartek.tu.kielce.pl>
References: <20030902165537.GA1830@bartek.tu.kielce.pl> <1062589779.19059.8.camel@dhcp23.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1062589779.19059.8.camel@dhcp23.swansea.linux.org.uk>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Witam,
Dnia Wed, Sep 03, 2003 at 12:49:40PM +0100 Alan Cox napisal(a):

> On Maw, 2003-09-02 at 17:55, Tomasz B??tor wrote:
> > I recently got MiNt PCI IDE ATA/133 RAID controller based on SiI 0680
> > chipset. I browsed through the archives and I know that the driver is
> > known to be broken and simply doesn't work.
> 
> It just works. You do want 2.4.22 ideally, and you want 2.4.22-ac to use
> hotplug.

It doesn't for me. I have no idea what could I possibly do wrong, but
I've tried dozens of possibilities without any luck. Compiling in
siimage.c = drive errors, ide2 reset and infinite loop of "lost
interrupt" messages at boot time. Without siimage.c compiled and with
ide2=xxx ide3=xxx parameters in lilo, disks are visible, but of course
there is no DMA.

Any ideas?

t.

ps. yes, I use 2.4.22, without hotplug.

-- 
  Tomasz B±tor  e-mail: tomba@bartek.tu.kielce.pl  ICQ: 101194886
 ------ ---- -- - -  -    -   -  -  -   -    -  - - -- ---- ------
"The most important job is not to be governor, or first lady in my case."
                        -- George W. Bush
