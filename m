Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261868AbSKHNBe>; Fri, 8 Nov 2002 08:01:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261872AbSKHNBe>; Fri, 8 Nov 2002 08:01:34 -0500
Received: from modemcable191.130-200-24.mtl.mc.videotron.ca ([24.200.130.191]:36105
	"EHLO montezuma.mastecende.com") by vger.kernel.org with ESMTP
	id <S261868AbSKHNBe>; Fri, 8 Nov 2002 08:01:34 -0500
Date: Fri, 8 Nov 2002 08:05:14 -0500 (EST)
From: Zwane Mwaikambo <zwane@holomorphy.com>
X-X-Sender: zwane@montezuma.mastecende.com
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
cc: Mikael Pettersson <mikpe@csd.uu.se>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH][2.5-AC] Forced enable/disable local APIC
In-Reply-To: <Pine.GSO.3.96.1021108131625.3217B-100000@delta.ds2.pg.gda.pl>
Message-ID: <Pine.LNX.4.44.0211080804280.27141-100000@montezuma.mastecende.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 8 Nov 2002, Maciej W. Rozycki wrote:

>  Well, the "lapic" option should override the DMI setting, not the
> APICBASE availability check.  Anyway, I don't insist on this that much --
> while I think consistency is good, none of the "*apic" options are
> actually a necessity for me.  If one needs the option, one may still cook
> an appropriate patch oneself. 

I think the nolapic is definitely needed because i've come across a number 
of bug reports where the simplest solution would be to just disable the 
local apic.

	Zwane
-- 
function.linuxpower.ca

