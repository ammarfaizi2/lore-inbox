Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264380AbTGBSj7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Jul 2003 14:39:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264389AbTGBSj7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Jul 2003 14:39:59 -0400
Received: from outpost.ds9a.nl ([213.244.168.210]:16786 "EHLO outpost.ds9a.nl")
	by vger.kernel.org with ESMTP id S264380AbTGBSj5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Jul 2003 14:39:57 -0400
Date: Wed, 2 Jul 2003 20:54:12 +0200
From: bert hubert <ahu@ds9a.nl>
To: petero2@telia.com
Cc: linux-kernel@vger.kernel.org
Subject: Synaptics trouble in 2.5.73
Message-ID: <20030702185412.GA24350@outpost.ds9a.nl>
Mail-Followup-To: bert hubert <ahu@ds9a.nl>, petero2@telia.com,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Petero, List,

Up to 2.5.68 my laptop had no problems with its touchpad but since upgrading
to 2.5.73, neither gpm nor X see my mouse anymore. 

>From dmesg:

Jul  2 20:17:38 snapcount kernel: mice: PS/2 mouse device common for all mice
Jul  2 20:17:38 snapcount kernel: inport.c: Didn't find InPort mouse at 0x23c
Jul  2 20:17:38 snapcount kernel: logibm.c: Didn't find Logitech busmouse at 0x23c
Jul  2 20:17:38 snapcount kernel: pc110pad: I/O area 0x15e0-0x15e4 in use.
Jul  2 20:17:38 snapcount kernel: input: PC Speaker
Jul  2 20:17:38 snapcount kernel: i8042.c: Detected active multiplexing controller, rev 1.0.
Jul  2 20:17:38 snapcount kernel: serio: i8042 AUX0 port at 0x60,0x64 irq 12
Jul  2 20:17:38 snapcount kernel: Synaptics Touchpad, model: 1
Jul  2 20:17:38 snapcount kernel:  Firware: 4.1
Jul  2 20:17:38 snapcount kernel:  Sensor: 8
Jul  2 20:17:38 snapcount kernel:  new absolute packet format
Jul  2 20:17:38 snapcount kernel: input: Synaptics Synaptics TouchPad on isa0060/serio2

Later on, I get this:
Synaptics driver lost sync at 1st byte
Synaptics driver lost sync at 4th byte
Synaptics driver resynced.

But the mouse still does not work. This is a 'Gericom' laptop, which
contains mostly SiS parts. Anything I can do to help debug this, just let me
know.

I saw mention of special X drivers for this, but the kernel messages appear
to indicate that the kernel itself is not succeeding in communicating with
the touchpad.

Thanks!


-- 
http://www.PowerDNS.com      Open source, database driven DNS Software 
http://lartc.org           Linux Advanced Routing & Traffic Control HOWTO
