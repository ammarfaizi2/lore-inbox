Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262471AbTH3Awm (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Aug 2003 20:52:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262512AbTH3Awm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Aug 2003 20:52:42 -0400
Received: from pix-525-pool.redhat.com ([66.187.233.200]:55588 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id S262471AbTH3Awk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Aug 2003 20:52:40 -0400
Date: Sat, 30 Aug 2003 01:51:15 +0100
From: Dave Jones <davej@redhat.com>
To: Jurgen Kramer <gtm.kramer@inter.nl.net>
Cc: Alan Cox <alan@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.22-ac1 - VIA C3 cpufreq probs
Message-ID: <20030830005115.GA14101@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Jurgen Kramer <gtm.kramer@inter.nl.net>, Alan Cox <alan@redhat.com>,
	linux-kernel@vger.kernel.org
References: <200308291237.h7TCbYc12849@devserv.devel.redhat.com> <1062185134.1488.9.camel@paragon.slim>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1062185134.1488.9.camel@paragon.slim>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 29, 2003 at 09:25:34PM +0200, Jurgen Kramer wrote:

 > I have just tried 2.4.22-ac1 on my VIA C3 EPIA 800 system. Cpufreq
 > (longhaul) fails both while compiled as a module and compiled in.
 > 
 > I first tried to build it as a module but somehow the module isn't build
 > at all. Next thing I tried was building it straight in the
 > kernel....with a direct oops when booting as a result.
 > 
 > The system doesn't have a keyboard or monitor..it did cost me some
 > fiddling to get it back up running...that's life for a tester...
 > 
 > There also seems to be some problem with the longhaul detection. Normaly
 > it would print something like:
 > longhaul: VIA CPU detected. Longhaul version 2 supported
 > longhaul: CPU currently at 798MHz (133 x 6.0)
 > longhaul: MinMult(x10)=30 MaxMult(x10)=60
 > longhaul: Lowestspeed=399000 Highestspeed=798000
 > 
 > But 2.4.22-ac1 printed MinMult and MaxMult to be 0.

Yeah, I screwed up. Looking into this is on my TODO.

		Dave

-- 
 Dave Jones     http://www.codemonkey.org.uk
