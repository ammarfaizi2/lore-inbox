Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262155AbVAOC2b@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262155AbVAOC2b (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Jan 2005 21:28:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262156AbVAOC2a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Jan 2005 21:28:30 -0500
Received: from sccrmhc13.comcast.net ([204.127.202.64]:32384 "EHLO
	sccrmhc13.comcast.net") by vger.kernel.org with ESMTP
	id S262155AbVAOC2V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Jan 2005 21:28:21 -0500
Date: Fri, 14 Jan 2005 21:28:15 -0500
To: Dmitry Torokhov <dtor_core@ameritech.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.9 & 2.6.10 unresponsive to keyboard upon bootup
Message-ID: <20050115022815.GA25880@bittwiddlers.com>
References: <Pine.NEB.4.61.0501010814490.26191@sdf.lonestar.org>
	<200501122242.51686.dtor_core@ameritech.net>
	<20050114230637.GA32061@bittwiddlers.com>
	<200501142031.10119.dtor_core@ameritech.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200501142031.10119.dtor_core@ameritech.net>
User-Agent: Mutt/1.5.6+20040907i
X-Delivery-Agent: TMDA/1.0.3 (Seattle Slew)
From: Matthew Harrell <lists-sender-14a37a@bittwiddlers.com>
X-Primary-Address: mharrell@bittwiddlers.com
Reply-To: Matthew Harrell 
	  <mharrell-dated-1106188098.da706b@bittwiddlers.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

: Could you try booting with acpi=off and without PNP compiled in? And maybe
: with pci=routeirq

Ok, I tried all them individually (hope you didn't mean all at once).  pnp
and pci=routeirq had no effect.  acpi got it to work again but sacrificed 
my second HT cpu and battery monitoring.  I'm going to try to turn acpi on
and pnpacpi off in the kernel and see if that helps.  I'll then try Alan's
patch and see what happens there

-- 
  Matthew Harrell                          I don't suffer from insanity - 
  Bit Twiddlers, Inc.                       I enjoy every minute of it.
  mharrell@bittwiddlers.com     
