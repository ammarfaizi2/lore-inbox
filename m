Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263416AbRF0PzW>; Wed, 27 Jun 2001 11:55:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263428AbRF0PzN>; Wed, 27 Jun 2001 11:55:13 -0400
Received: from ams8uucp0.ams.ops.eu.uu.net ([212.153.111.69]:54261 "EHLO
	ams8uucp0.ams.ops.eu.uu.net") by vger.kernel.org with ESMTP
	id <S263416AbRF0PzF>; Wed, 27 Jun 2001 11:55:05 -0400
Date: Wed, 27 Jun 2001 17:44:35 +0200 (CEST)
From: kees <kees@schoen.nl>
To: Andrew Morton <andrewm@uow.edu.au>
cc: Tim Timmerman <Tim.Timmerman@asml.com>, linux-kernel@vger.kernel.org
Subject: Re: NETDEV WATCHDOG with 2.4.5
In-Reply-To: <3B397659.816CF0A3@uow.edu.au>
Message-ID: <Pine.LNX.4.21.0106271743530.19407-100000@schoen3.schoen.nl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew,

But why does it work with 2.2.19??

Kees



On Wed, 27 Jun 2001, Andrew Morton wrote:

> Tim Timmerman wrote:
> > 
> > >>>>> "kees" == kees  <kees@schoen.nl> writes:
> > 
> > kees> Hi,
> > 
> > kees> I tried 2.4.5 but after a couple of hours I lost all network
> > kees> connectivety.  The log shows:
> > <snip>
> >         Can I just add a me too here ?
> > 
> >         System: Abit BP6, Dual Celeron, Ne2k-pci, usb ohci and
> >         scanner; 128 Mb Ram, Nvidia TNT2 graphics. Kernel 2.4.5
> 
> ne2k and, to a lesser extent, 3c59x do not work correctly on many
> x86 SMP machines because of a problem with the APIC interrupt
> controller.
> 
> Probable fixes include booting with the `noapic' option,
> running -ac kernels or applying Maciej's APIC workaround
> patch.  There's a copy at http://www.uow.edu.au/~andrewm/linux/apic.txt
> 

