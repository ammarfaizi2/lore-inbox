Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272320AbTG3XbQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Jul 2003 19:31:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272331AbTG3XbQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Jul 2003 19:31:16 -0400
Received: from mail.kroah.org ([65.200.24.183]:14987 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S272320AbTG3XbP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Jul 2003 19:31:15 -0400
Date: Wed, 30 Jul 2003 16:17:53 -0700
From: Greg KH <greg@kroah.com>
To: Grant Miner <mine0057@mrs.umn.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Zio! compactflash doesn't work
Message-ID: <20030730231753.GB5491@kroah.com>
References: <3F26F009.4090608@mrs.umn.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3F26F009.4090608@mrs.umn.edu>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 29, 2003 at 05:07:05PM -0500, Grant Miner wrote:
> I have a Microtech CompactFlash ZiO! USB
> 
> cat /proc/bus/usb/devices
> T:  Bus=02 Lev=02 Prnt=02 Port=03 Cnt=03 Dev#=  8 Spd=12  MxCh= 0
> D:  Ver= 1.00 Cls=00(>ifc ) Sub=00 Prot=00 MxPS=16 #Cfgs=  1
> P:  Vendor=04e6 ProdID=1010 Rev= 0.05
> S:  Manufacturer=SHUTTLE
> S:  Product=SCM Micro USBAT-02
> C:* #Ifs= 1 Cfg#= 1 Atr=80 MxPwr=100mA
> I:  If#= 0 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=01 Prot=ff Driver=(none)
> E:  Ad=81(I) Atr=03(Int.) MxPS=   4 Ivl=5ms
> E:  Ad=82(I) Atr=02(Bulk) MxPS=  64 Ivl=0ms
> E:  Ad=03(O) Atr=02(Bulk) MxPS=  64 Ivl=0ms
> 
> but it does not show up in /dev; this is in 2.6.0-pre1.  (It never 
> worked in 2.4 either.)  config is attached.  Any ideas?

Linux doesn't currently support this device, sorry.

greg k-h
