Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750802AbVHUFUF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750802AbVHUFUF (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 Aug 2005 01:20:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750804AbVHUFUF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Aug 2005 01:20:05 -0400
Received: from smtp109.sbc.mail.mud.yahoo.com ([68.142.198.208]:26267 "HELO
	smtp109.sbc.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1750802AbVHUFUD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Aug 2005 01:20:03 -0400
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.6.12.5: psmouse mouse detection doesn't work
Date: Sun, 21 Aug 2005 00:19:55 -0500
User-Agent: KMail/1.8.2
Cc: Harald Dunkel <harald.dunkel@t-online.de>
References: <4308062F.7080208@t-online.de>
In-Reply-To: <4308062F.7080208@t-online.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200508210019.56034.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 20 August 2005 23:42, Harald Dunkel wrote:
> Hi folks,
> 
> At boot time my Logitech mouse is detected as
> 
> I: Bus=0011 Vendor=0002 Product=0001 Version=0000
> N: Name="PS/2 Generic Mouse"
> P: Phys=isa0060/serio1/input0
> H: Handlers=event1 ts0 mouse0
> B: EV=7
> B: KEY=70000 0 0 0 0
> B: REL=3
> 
> After manually reloading psmouse I get the expected
> 
> I: Bus=0011 Vendor=0002 Product=0002 Version=0049
> N: Name="PS2++ Logitech Mouse"
> P: Phys=isa0060/serio1/input0
> H: Handlers=event1 ts0 mouse0
> B: EV=7
> B: KEY=f0000 0 0 0 0
> B: REL=3
> 

Does booting with "usb-handoff" on the kernel boot line help?

-- 
Dmitry
