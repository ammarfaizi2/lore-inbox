Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265008AbSL3AqJ>; Sun, 29 Dec 2002 19:46:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265130AbSL3AqJ>; Sun, 29 Dec 2002 19:46:09 -0500
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:21888
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S265008AbSL3AqI>; Sun, 29 Dec 2002 19:46:08 -0500
Subject: Re: 2.4.21-pre2: CPU0 handles all interrupts
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Ron Cooper <rcooper@jamesconeyisland.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Hans Lambrechts <hans.lambrechts@skynet.be>
In-Reply-To: <200212281103.36973.rcooper@jamesconeyisland.com>
References: <200212281056.58419.hans.lambrechts@skynet.be> 
	<200212281103.36973.rcooper@jamesconeyisland.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 30 Dec 2002 01:35:42 +0000
Message-Id: <1041212142.1474.33.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2002-12-28 at 17:03, Ron Cooper wrote:
> Mine does this too.  2.4.20.  Iwill dp400 board running dual 2.4Ghz 
> Xeons with HT enabled.
> 
> I have to boot by passing "noapic" to the kernel, otherwise 
> /cat/proc/interrupts will show the interrupt numbers wrong,
> however. not doing this changes nothing.

"noapic" will deliver all IRQ's to IRQ0. Note btw - IRQ numbers *do*
change in APIC mode

