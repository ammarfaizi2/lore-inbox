Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261573AbVANXKo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261573AbVANXKo (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Jan 2005 18:10:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261372AbVANXIz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Jan 2005 18:08:55 -0500
Received: from rwcrmhc12.comcast.net ([216.148.227.85]:47528 "EHLO
	rwcrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S261888AbVANXGl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Jan 2005 18:06:41 -0500
Date: Fri, 14 Jan 2005 18:06:37 -0500
To: Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.9 & 2.6.10 unresponsive to keyboard upon bootup
Message-ID: <20050114230637.GA32061@bittwiddlers.com>
References: <Pine.NEB.4.61.0501010814490.26191@sdf.lonestar.org>
	<200501110239.33260.dtor_core@ameritech.net>
	<Pine.NEB.4.61.0501130315500.11711@sdf.lonestar.org>
	<200501122242.51686.dtor_core@ameritech.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200501122242.51686.dtor_core@ameritech.net>
User-Agent: Mutt/1.5.6+20040907i
From: Matthew Harrell <lists-sender-14a37a@bittwiddlers.com>
X-Delivery-Agent: TMDA/1.0.3 (Seattle Slew)
X-Primary-Address: mharrell@bittwiddlers.com
Reply-To: Matthew Harrell 
	  <mharrell-dated-1106175998.ed30bc@bittwiddlers.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

:
: And what if you do not compile PS/2 mouse support in? Is keyboard still
: dead?
:

I also have an inresponsive keyboard and mouse on my laptop with later kernels.
To qualify that more, the same setup used to compile 2.6.10, 2.6.10-mm2,
2.6.10-mm3, 2.6.11-rc1 only gives me a working keyboard and mouse on the
2.6.10 kernel.  I can plug in a USB keyboard and mouse and they work fine.
Not sure if it's the same problem as the original author.  I just compiled
2.6.11-rc1 with the ps/2 mouse as a module (hoping that forcing it to load
later would help) but that didn't seem to make a difference even though it
looks like the mouse was loaded (by hotplug) after the keyboard should have
been setup.  If you want I'll try another in a few minutes without the
mouse entirely.  It looks like acpi does detect both keyboard and mouse
controllers.  For those interested kernel bootup messages and kernel config
are available here

        http://alecto.bittwiddlers.com/files/linux/boot-2.6.11rc1.log
        http://alecto.bittwiddlers.com/files/linux/defconfig-2.6.11rc1

-- 
  Matthew Harrell                          Failure is not an option. It comes
  Bit Twiddlers, Inc.                       bundled with your Microsoft
  mharrell@bittwiddlers.com                 product.
