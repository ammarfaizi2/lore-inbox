Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261867AbVC3LUy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261867AbVC3LUy (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Mar 2005 06:20:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261869AbVC3LUy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Mar 2005 06:20:54 -0500
Received: from sccrmhc14.comcast.net ([204.127.202.59]:54407 "EHLO
	sccrmhc14.comcast.net") by vger.kernel.org with ESMTP
	id S261867AbVC3LUn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Mar 2005 06:20:43 -0500
From: Ron Gage <ron@rongage.org>
To: Magnus Damm <magnus.damm@gmail.com>
Subject: Re: Continuing woes - Yenta PCMCIA and USB 2.0 Cardbus Card
Date: Wed, 30 Mar 2005 06:15:41 -0500
User-Agent: KMail/1.6.1
Cc: linux-kernel@vger.kernel.org, daniel.ritz@gmx.ch, jonas.oreland@mysql.com
References: <200503291906.19890.ron@rongage.org> <aec7e5c30503300202446ac0e1@mail.gmail.com>
In-Reply-To: <aec7e5c30503300202446ac0e1@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200503300615.42003.ron@rongage.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Magnus:

On Wednesday 30 March 2005 05:02, Magnus Damm wrote:
> Hello,
>
> On Tue, 29 Mar 2005 19:06:19 -0500, Ron Gage <ron@rongage.org> wrote:
> > Laptop is an HP Pavilion N5150, Intel USB chipset (UHCI).  Cardbus card
> > is generic ALI based USB chipset (EHCI/OHCI).  USB drive is a Sony VAIO
> > external case for a 2.5" drive.  The chip in the usb drive has no
> > manufacturer markings on it, just the following character sequences:
> > CS881BAG, 0451B0C104, 107
>
> I've got an external 2.5" VAIO case (VAIO original yeah, right)  that
> works ok what I can tell with USB2 on my laptop. Are the id:s below
> the same as yours?
>
Here are the ID's of mine...

T:  Bus=01 Lev=01 Prnt=01 Port=00 Cnt=01 Dev#=  3 Spd=12  MxCh= 0
D:  Ver= 2.00 Cls=00(>ifc ) Sub=00 Prot=00 MxPS=64 #Cfgs=  1
P:  Vendor=04cf ProdID=8818 Rev=b0.07
S:  Manufacturer=Myson Century, Inc.
S:  Product=USB Mass Storage Device
S:  SerialNumber=100
C:* #Ifs= 1 Cfg#= 1 Atr=c0 MxPwr= 10mA
I:  If#= 0 Alt= 0 #EPs= 2 Cls=08(stor.) Sub=05 Prot=50 Driver=usb-storage
E:  Ad=03(O) Atr=02(Bulk) MxPS=  64 Ivl=0ms
E:  Ad=84(I) Atr=02(Bulk) MxPS=  64 Ivl=0ms


> T:  Bus=04 Lev=01 Prnt=01 Port=02 Cnt=01 Dev#=  8 Spd=480 MxCh= 0
> D:  Ver= 2.00 Cls=00(>ifc ) Sub=00 Prot=00 MxPS=64 #Cfgs=  1
> P:  Vendor=04cf ProdID=8818 Rev=b0.07
> S:  Manufacturer=Myson Century, Inc.
> S:  Product=USB Mass Storage Device
> S:  SerialNumber=100
> C:* #Ifs= 1 Cfg#= 1 Atr=c0 MxPwr= 10mA
> I:  If#= 0 Alt= 0 #EPs= 2 Cls=08(stor.) Sub=05 Prot=50 Driver=usb-storage
> E:  Ad=03(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> E:  Ad=84(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms

Looks like we have basically the same device.

> on pccard? Maybe you need an external ac adapter?

This would be remotely possible but I would discount it being probable.  You 
see, a drive requires the most power at spin up.  This thing spins up just 
fine regardless of what port I have it plugged into.  On top of that, the USB 
card has a power adaptor already (plugs into the laptop's USB port) that I 
always use.

Besides, how would I connect an external power supply to this?  No connector 
on the drive assembly...

-- 
Ron Gage - Pontiac, Michigan
(MCP, LPIC1, A+, Net+)
