Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262416AbSKISLl>; Sat, 9 Nov 2002 13:11:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262420AbSKISLl>; Sat, 9 Nov 2002 13:11:41 -0500
Received: from modemcable191.130-200-24.mtl.mc.videotron.ca ([24.200.130.191]:39172
	"EHLO montezuma.mastecende.com") by vger.kernel.org with ESMTP
	id <S262416AbSKISLk>; Sat, 9 Nov 2002 13:11:40 -0500
Date: Sat, 9 Nov 2002 13:09:39 -0500 (EST)
From: Zwane Mwaikambo <zwane@holomorphy.com>
X-X-Sender: zwane@montezuma.mastecende.com
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Mikael Pettersson <mikpe@csd.uu.se>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@transmeta.com>
Subject: Re: [PATCH][2.5] notsc option needs some attention/TLC
In-Reply-To: <1036847149.20313.2.camel@irongate.swansea.linux.org.uk>
Message-ID: <Pine.LNX.4.44.0211091308250.10475-100000@montezuma.mastecende.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 9 Nov 2002, Alan Cox wrote:

> On Sat, 2002-11-09 at 12:00, Mikael Pettersson wrote:
> > If we configure for "I have a TSC, period" you add the option
> > to disable it, which nullifies any benefit of the config option
> > in the first place since we can't assume TSC presence any more.
> > If we don't configure for TSC, you force tsc_disable, which means
> > that a generic kernel _can't_ use the TSC.
> 
> 2.4 was modified to printk a message that TSC was not disabled. This
> does confuse people

This is all very confusing, notsc isnn't supposed to work with cpus with 
TSCs?

	Zwane
-- 
function.linuxpower.ca

