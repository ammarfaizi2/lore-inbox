Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267448AbTBDVjK>; Tue, 4 Feb 2003 16:39:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267454AbTBDVjK>; Tue, 4 Feb 2003 16:39:10 -0500
Received: from air-2.osdl.org ([65.172.181.6]:19075 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id <S267448AbTBDVjI>; Tue, 4 Feb 2003 16:39:08 -0500
Subject: Re: gcc 2.95 vs 3.21 performance
From: "Timothy D. Witham" <wookie@osdl.org>
To: Herman Oosthuysen <Herman@wirelessnetworksinc.com>
Cc: John Bradford <john@grabjohn.com>, Dave Jones <davej@codemonkey.org.uk>,
       vda@port.imtp.ilyichevsk.odessa.ua, root@chaos.analogic.com,
       mbligh@aracnet.com, linux-kernel@vger.kernel.org,
       lse-tech@lists.sourceforge.net
In-Reply-To: <3E40264C.5050302@WirelessNetworksInc.com>
References: <200302042011.h14KBuG6002791@darkstar.example.net>
	 <3E40264C.5050302@WirelessNetworksInc.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: Open Source Development Lab, Inc.
Message-Id: <1044395087.1864.72.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 
Date: 04 Feb 2003 13:44:48 -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 2003-02-04 at 12:45, Herman Oosthuysen wrote:
> Hi there,
> 
>  From my experience, the speed issue is caused by misalligned memory 
> accesses, causing inefficient SDRAM to Cache movement of data and 
> instructions.
> 
> I don't think that you necessarily need a modification to the compiler. 
>   What you can do is carefully place the ALLIGN switch in a few critical 
> places in the kernel code, to ensure that the code and data will be 
> properly alligned for whatever processor it is compiled for, be that a 
> Pentium, an ARM, a MIPS or whatever.
> 
 
  I guess I would like the compiler to do that without having to go
in and futz the code.  

> It would be nice if GCC can be suitably improved to do this correcly for 
> all architectures, but a little bit of human help can do wonders, 
> without having to fork the GCC project.
> 
> Cheers,
-- 
Timothy D. Witham - Lab Director - wookie@osdlab.org
Open Source Development Lab Inc - A non-profit corporation
15275 SW Koll Parkway - Suite H - Beaverton OR, 97006
(503)-626-2455 x11 (office)    (503)-702-2871     (cell)
(503)-626-2436     (fax)

