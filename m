Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268133AbUHQHwV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268133AbUHQHwV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Aug 2004 03:52:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268138AbUHQHwV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Aug 2004 03:52:21 -0400
Received: from smtp100.rog.mail.re2.yahoo.com ([206.190.36.78]:64360 "HELO
	smtp100.rog.mail.re2.yahoo.com") by vger.kernel.org with SMTP
	id S268133AbUHQHwO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Aug 2004 03:52:14 -0400
From: Shawn Starr <shawn.starr@rogers.com>
Organization: sh0n.net
To: linux-kernel@vger.kernel.org
Subject: Re: [2.6.8.1-mm1][input] - IBM TouchPad support added? Which patch is this? - Found it ignore
Date: Tue, 17 Aug 2004 03:52:12 -0400
User-Agent: KMail/1.6.2
Cc: akpm@osdl.org
References: <200408170349.44626.shawn.starr@rogers.com>
In-Reply-To: <200408170349.44626.shawn.starr@rogers.com>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200408170352.12016.shawn.starr@rogers.com>
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On August 17, 2004 03:49, Shawn Starr wrote:
>  mice: PS/2 mouse device common for all mice
> input: IBM PC110 TouchPad at 0x15e0 irq 10 <-----------------------------
> This is new input: AT Translated Set 2 keyboard on isa0060/serio0
> Synaptics Touchpad, model: 1
> Firmware: 5.9
> Sensor: 44
> new absolute packet format
> Touchpad has extended capability bits
>   -> multifinger detection
>   -> palm detection
>   -> pass-through port
>  input: SynPS/2 Synaptics TouchPad on isa0060/serio1
>  serio: Synaptics pass-through port atisa0060/serio1/input0
>
> Which patch is this? its nice but I don't see any ability (yet) to control
> its sensitivity (especially in KDE!). Upon using 2.6.8-rc4-bk2 there was no
> such device (you could not touch the pad as a button).
>
> Shawn.


  new device driver to enable the IBM Multiport Serial Adapter

I found it, its  a serial device.

Shawn.
