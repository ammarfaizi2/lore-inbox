Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266810AbSKRXaA>; Mon, 18 Nov 2002 18:30:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266948AbSKRX3U>; Mon, 18 Nov 2002 18:29:20 -0500
Received: from guru.webcon.net ([66.11.168.140]:65184 "EHLO guru.webcon.net")
	by vger.kernel.org with ESMTP id <S266810AbSKRX3E>;
	Mon, 18 Nov 2002 18:29:04 -0500
Date: Mon, 18 Nov 2002 18:35:59 -0500 (EST)
From: Ian Morgan <imorgan@webcon.net>
To: Zwane Mwaikambo <zwane@holomorphy.com>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH][2.4-AC] sync 2.4 asm-i386/cpufeature.h to 2.5.47
In-Reply-To: <Pine.LNX.4.44.0211181831031.1538-100000@montezuma.mastecende.com>
Message-ID: <Pine.LNX.4.44.0211181835470.6121-100000@light.webcon.net>
Organization: "Webcon, Inc."
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 18 Nov 2002, Zwane Mwaikambo wrote:

> On Mon, 18 Nov 2002, Ian Morgan wrote:
> 
> > On Sun, 17 Nov 2002, Zwane Mwaikambo wrote:
> > 
> > > Ian this should fix your compilation problem.
> > > Alan, Dave this applies clean to 2.4.19 vanilla too.
> > 
> > Close. Really close. It compiles, but now has an unresolvable symbol?
> > 
> > depmod: *** Unresolved symbols in
> > /lib/modules/2.4.20-rc1-ac4/kernel/arch/i386/kernel/p4-clockmod.o
> > depmod:         smp_num_siblings
> > 
> > This is baffling me, because 'smp_num_siblings' is indeed listed in
> > System.map as:
> > 
> > c0292e28 D smp_num_siblings
> > 
> > Any clues?
> 
> Is CONFIG_SMP set?

Yup.

Regards,
Ian Morgan

-- 
-------------------------------------------------------------------
 Ian E. Morgan          Vice President & C.O.O.       Webcon, Inc.
 imorgan@webcon.ca          PGP: #2DA40D07           www.webcon.ca
    *  Customized Linux network solutions for your business  *
-------------------------------------------------------------------

