Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266582AbSKGVfc>; Thu, 7 Nov 2002 16:35:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266585AbSKGVfc>; Thu, 7 Nov 2002 16:35:32 -0500
Received: from modemcable191.130-200-24.mtl.mc.videotron.ca ([24.200.130.191]:9482
	"EHLO montezuma.mastecende.com") by vger.kernel.org with ESMTP
	id <S266582AbSKGVfb>; Thu, 7 Nov 2002 16:35:31 -0500
Date: Thu, 7 Nov 2002 16:40:22 -0500 (EST)
From: Zwane Mwaikambo <zwane@holomorphy.com>
X-X-Sender: zwane@montezuma.mastecende.com
To: Mikael Pettersson <mikpe@csd.uu.se>
cc: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH][2.5-AC] Forced enable/disable local APIC
In-Reply-To: <15818.39371.311141.742866@kim.it.uu.se>
Message-ID: <Pine.LNX.4.44.0211071639090.27141-100000@montezuma.mastecende.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 7 Nov 2002, Mikael Pettersson wrote:

> No. Read what I wrote: if cpu_has_apic is false, the code drops into
> the "try the hard way by messing with the APICBASE MSR". Your "force"
> goto bypasses the CPU checks, which are there to ensure that the CPU
> actually _has_ an APICBASE MSR.

My mistake, i misread.
 
> I still see no reason at all for the force.

I agree, in which case the first patch should make everyone happy. If Alan 
doesn't take it for his next release i'll resend.

	Zwane
-- 
function.linuxpower.ca

