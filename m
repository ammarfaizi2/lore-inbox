Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262126AbSJZNlu>; Sat, 26 Oct 2002 09:41:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262130AbSJZNlu>; Sat, 26 Oct 2002 09:41:50 -0400
Received: from noodles.codemonkey.org.uk ([213.152.47.19]:45217 "EHLO
	noodles.internal") by vger.kernel.org with ESMTP id <S262126AbSJZNlu>;
	Sat, 26 Oct 2002 09:41:50 -0400
Date: Sat, 26 Oct 2002 14:49:47 +0100
From: Dave Jones <davej@codemonkey.org.uk>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, alan@redhat.com
Subject: Re: [PATCH] Double x86 initialise fix.
Message-ID: <20021026134947.GA31349@suse.de>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	alan@redhat.com
References: <200210261242.g9QCgSqp030280@noodles.internal> <1035640580.13032.100.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1035640580.13032.100.camel@irongate.swansea.linux.org.uk>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 26, 2002 at 02:56:20PM +0100, Alan Cox wrote:
 > > For many moons, we've been executing identify_cpu()
 > > on the boot processor twice on SMP kernels.
 > > This is harmless, but has a few downsides..
 > > - Extra cruft in bootlog/dmesg
 > > - Spawns one too many timers for the mcheck handler
 > > - possibly other wasteful things..
 > > 
 > > This seems to do the right thing here..

Isn't this always the case on x86 ?
/me waits to hear gory details of some IBM monster.

		Dave

-- 
| Dave Jones.        http://www.codemonkey.org.uk
