Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263192AbTC1XFO>; Fri, 28 Mar 2003 18:05:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263194AbTC1XFO>; Fri, 28 Mar 2003 18:05:14 -0500
Received: from [12.47.58.223] ([12.47.58.223]:17540 "EHLO
	pao-ex01.pao.digeo.com") by vger.kernel.org with ESMTP
	id <S263192AbTC1XFN>; Fri, 28 Mar 2003 18:05:13 -0500
Date: Fri, 28 Mar 2003 15:16:24 -0800
From: Andrew Morton <akpm@digeo.com>
To: "J.A. Magallon" <jamagallon@able.es>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 3c59x gives HWaddr FF:FF:...
Message-Id: <20030328151624.67a3c8c5.akpm@digeo.com>
In-Reply-To: <20030328230510.GA5124@werewolf.able.es>
References: <20030328145159.GA4265@werewolf.able.es>
	<20030328124832.44243f83.akpm@digeo.com>
	<20030328230510.GA5124@werewolf.able.es>
X-Mailer: Sylpheed version 0.8.10 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 28 Mar 2003 23:16:25.0284 (UTC) FILETIME=[0D9D8040:01C2F580]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"J.A. Magallon" <jamagallon@able.es> wrote:
>
> > Please take the 2.4.20 3c59x.c and place that into the 2.5 tree and confirm
> > that it does the same thing (it will).
> > 
> 
> Hum, I suppose you want to say take the _2.5_ one and put into my _2.4_ tree ?

No, I didn't mean that.  But you can do that too.

> Some previous answer also talked about a more recent version in -ac.
> (btw, can 2.5 be useful for something ? does not the driver depend on a new
> arch of, for example, the PCI layer ? )

The netdevice interface hasn't been broken yet ;) 2.4 drivers (or at least
3c59x.c) still work OK in the 2.5 tree.


> > Then try disabling APCI and/or otherwise fiddling with your power management
> > options (maybe in BIOS too).
> > 
> 
> I don't build ACPI, just APM power-off (SMP box).

Oh, OK.

As I say, it it probably power-management related.  Try enabling ACPI.  Try
disabling APM.  Try altering the BIOS settings.

