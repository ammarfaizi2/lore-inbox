Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267214AbTAKNe0>; Sat, 11 Jan 2003 08:34:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267216AbTAKNe0>; Sat, 11 Jan 2003 08:34:26 -0500
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:19348
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S267214AbTAKNeZ>; Sat, 11 Jan 2003 08:34:25 -0500
Subject: Re: [PATCH]Re: spin_locks without smp.
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Mikael Pettersson <mikpe@csd.uu.se>
Cc: manfred@colorfullife.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       solt@dns.toxicfilms.tv, wli@holomorphy.com
In-Reply-To: <200301111322.OAA26316@harpo.it.uu.se>
References: <200301111322.OAA26316@harpo.it.uu.se>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1042295370.2517.0.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 (1.2.1-2) 
Date: 11 Jan 2003 14:29:32 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2003-01-11 at 13:22, Mikael Pettersson wrote:
> On 10 Jan 2003 18:18:39 +0000, Alan Cox wrote:
> >On Fri, 2003-01-10 at 17:19, Manfred Spraul wrote:
> >> 
> >>     disable_irq();
> >>     spin_lock(&np->lock);
> >> 
> >> That's what 8390.c uses, no need for an #ifdef.
> >
> >Does someone have a card they can test that on. If so then I agree
> >entirely it is the best way to go 
> 
> I have an ISA NE2000 available for testing, if someone feeds me patches.
> Only UP hardware, though.

Sorry I wasnt clear enough. The 8390 is done, the one that would need the 
testing is SMP etherexpress.c.


