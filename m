Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261382AbSJZNcP>; Sat, 26 Oct 2002 09:32:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262126AbSJZNcP>; Sat, 26 Oct 2002 09:32:15 -0400
Received: from pc1-cwma1-5-cust42.swa.cable.ntl.com ([80.5.120.42]:45514 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S261382AbSJZNcP>; Sat, 26 Oct 2002 09:32:15 -0400
Subject: Re: [PATCH] Double x86 initialise fix.
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: davej@codemonkey.org.uk
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, alan@redhat.com
In-Reply-To: <200210261242.g9QCgSqp030280@noodles.internal>
References: <200210261242.g9QCgSqp030280@noodles.internal>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 26 Oct 2002 14:56:20 +0100
Message-Id: <1035640580.13032.100.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2002-10-26 at 13:42, davej@codemonkey.org.uk wrote:
> For many moons, we've been executing identify_cpu()
> on the boot processor twice on SMP kernels.
> This is harmless, but has a few downsides..
> - Extra cruft in bootlog/dmesg
> - Spawns one too many timers for the mcheck handler
> - possibly other wasteful things..
> 
> This seems to do the right thing here..

How do you know the boot CPU is CPU#0

