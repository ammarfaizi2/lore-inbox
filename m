Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266826AbSKRX1i>; Mon, 18 Nov 2002 18:27:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266810AbSKRX1B>; Mon, 18 Nov 2002 18:27:01 -0500
Received: from modemcable017.51-203-24.mtl.mc.videotron.ca ([24.203.51.17]:16598
	"EHLO montezuma.mastecende.com") by vger.kernel.org with ESMTP
	id <S266157AbSKRXZo>; Mon, 18 Nov 2002 18:25:44 -0500
Date: Mon, 18 Nov 2002 18:35:58 -0500 (EST)
From: Zwane Mwaikambo <zwane@holomorphy.com>
X-X-Sender: zwane@montezuma.mastecende.com
To: Ian Morgan <imorgan@webcon.net>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH][2.4-AC] sync 2.4 asm-i386/cpufeature.h to 2.5.47
In-Reply-To: <Pine.LNX.4.44.0211181128450.16963-100000@light.webcon.net>
Message-ID: <Pine.LNX.4.44.0211181831031.1538-100000@montezuma.mastecende.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 18 Nov 2002, Ian Morgan wrote:

> On Sun, 17 Nov 2002, Zwane Mwaikambo wrote:
> 
> > Ian this should fix your compilation problem.
> > Alan, Dave this applies clean to 2.4.19 vanilla too.
> 
> Close. Really close. It compiles, but now has an unresolvable symbol?
> 
> depmod: *** Unresolved symbols in
> /lib/modules/2.4.20-rc1-ac4/kernel/arch/i386/kernel/p4-clockmod.o
> depmod:         smp_num_siblings
> 
> This is baffling me, because 'smp_num_siblings' is indeed listed in
> System.map as:
> 
> c0292e28 D smp_num_siblings
> 
> Any clues?

Is CONFIG_SMP set?

	Zwane
-- 
function.linuxpower.ca


