Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267300AbTGOL77 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Jul 2003 07:59:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267303AbTGOL77
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Jul 2003 07:59:59 -0400
Received: from Mail1.kontent.de ([81.88.34.36]:27882 "EHLO Mail1.KONTENT.De")
	by vger.kernel.org with ESMTP id S267300AbTGOL76 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Jul 2003 07:59:58 -0400
From: Oliver Neukum <oliver@neukum.org>
To: Joerg Stephan <joerg@jstephan.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.0-test1 some Problems (modules & touchpad)
Date: Tue, 15 Jul 2003 14:14:06 +0200
User-Agent: KMail/1.5.1
References: <3F13CF33.7040706@jstephan.org>
In-Reply-To: <3F13CF33.7040706@jstephan.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200307151414.06869.oliver@neukum.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 
> The second is, the touchpad of my notebook doesnt work.

Hi,

a similar problem here on a Targa XP.

The wheel of the touchpad is on /dev/input/event0 and /dev/psaux
The touchpad and the regular buttons are on /dev/input/event1
This is kind of strange.

dmesg:
mice: PS/2 mouse device common for all mice
input: PC Speaker
i8042.c: Detected active multiplexing controller, rev 1.0.
serio: i8042 AUX0 port at 0x60,0x64 irq 12
Synaptics Touchpad, model: 1
 Firware: 4.1
 Sensor: 8
 new absolute packet format
input: Synaptics Synaptics TouchPad on isa0060/serio2
serio: i8042 AUX1 port at 0x60,0x64 irq 12
serio: i8042 AUX2 port at 0x60,0x64 irq 12
serio: i8042 AUX3 port at 0x60,0x64 irq 12
input: AT Set 2 keyboard on isa0060/serio0
serio: i8042 KBD port at 0x60,0x64 irq 1

and later on:

Synaptics driver lost sync at 1st byte
Synaptics driver lost sync at 1st byte
Synaptics driver lost sync at 1st byte
Synaptics driver lost sync at 1st byte
Synaptics driver resynced.

	Regards
		Oliver

