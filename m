Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262175AbVAOC73@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262175AbVAOC73 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Jan 2005 21:59:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262112AbVAOC72
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Jan 2005 21:59:28 -0500
Received: from sccrmhc12.comcast.net ([204.127.202.56]:37306 "EHLO
	sccrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S262175AbVAOC6W (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Jan 2005 21:58:22 -0500
Date: Fri, 14 Jan 2005 21:58:18 -0500
To: Dmitry Torokhov <dtor_core@ameritech.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.9 & 2.6.10 unresponsive to keyboard upon bootup
Message-ID: <20050115025818.GA28422@bittwiddlers.com>
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
	  <mharrell-dated-1106189901.f84b08@bittwiddlers.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

: Also, there is a patch my Alan Cox dealing with legacy emulation (but note
: that first part (udelay(50)) has already been applied:
: 
: http://marc.theaimsgroup.com/?l=linux-kernel&m=109096903809223&q=raw

Well acpipnp didn't have any effect.

I tried the patch above but there's an undefined function, pci_find_class,
in i8042_spank_usb.  Did it change names?

-- 
  Matthew Harrell                          All science is either physics or
  Bit Twiddlers, Inc.                       stamp collecting.
  mharrell@bittwiddlers.com     
