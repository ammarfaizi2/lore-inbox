Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261330AbSLHNku>; Sun, 8 Dec 2002 08:40:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261353AbSLHNkt>; Sun, 8 Dec 2002 08:40:49 -0500
Received: from pc1-cwma1-5-cust42.swan.cable.ntl.com ([80.5.120.42]:42423 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S261330AbSLHNkt>; Sun, 8 Dec 2002 08:40:49 -0500
Subject: Re: PROBLEM: Oops.. NULL pointer reference in 2.4.20-ac1
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Simon Ward <simon.ward@cs.man.ac.uk>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andre Hedrick <andre@linux-ide.org>
In-Reply-To: <Pine.LNX.4.44.0212081222370.22353-100000@tl009.cs.man.ac.uk>
References: <Pine.LNX.4.44.0212081222370.22353-100000@tl009.cs.man.ac.uk>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 08 Dec 2002 14:19:33 +0000
Message-Id: <1039357173.6912.4.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2002-12-08 at 12:35, Simon Ward wrote:
> 
> The kernel 2.4.20 with the -ac1 patch results in a kernel panic. I have
> tried kernel 2.4.19 and a vanilla 2.4.20 and these both worked fine.
> 
> The problem appears to be after (or while) the IDE interfaces are
> probed. The IDE chipset is (I think) ALI M1543. It's part of the ALI
> Aladdin V chipset on an Asus P5A-B motherboard anyway, if that means
> anything to you.

Looks like your system returned a totally bogus IRQ for the interface.
Are you enabling ACPI by any chance ?

