Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269494AbUINV6l@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269494AbUINV6l (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Sep 2004 17:58:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269673AbUINVtz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Sep 2004 17:49:55 -0400
Received: from pop.gmx.de ([213.165.64.20]:32428 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S269038AbUINVoL convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Sep 2004 17:44:11 -0400
X-Authenticated: #1700068
From: r2 <torsten.foertsch@gmx.net>
To: linux-kernel@vger.kernel.org
Subject: Mouse Problems with 2.6
Date: Tue, 14 Sep 2004 23:43:46 +0200
User-Agent: KMail/1.6.2
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Message-Id: <200409142344.00646.r2@opi.home>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hi,

since I have recently updated to kernel 2.6 (Suse 2.6.5-7.108-default) my 
mouse is going crazy from time to time and I am seeing such messages in my 
logfile:

kernel: psmouse.c: Mouse at isa0060/serio2/input0 lost synchronization, 
throwing 2 bytes away.

How can this be avoided?

My notebook has a touchpad built in and I have additional connected an old 
Logitech 3 Button PS/2 mouse:

<6>input: PS/2 Logitech Mouse on isa0060/serio2
<6>serio: i8042 AUX2 port at 0x60,0x64 irq 12
<6>serio: i8042 AUX3 port at 0x60,0x64 irq 12
<6>Synaptics Touchpad, model: 1
<6> Firmware: 5.6
<6> 180 degree mounted touchpad
<6> Sensor: 18
<6> new absolute packet format
<6> Touchpad has extended capability bits
<6> -> four buttons
<6> -> multifinger detection
<6> -> palm detection
<6>input: SynPS/2 Synaptics TouchPad on isa0060/serio4

I'd also like to get the old kernel 2.4 touchpad behaviour. With 2.4 the it 
had sent a Button1 event by simply touching it. Now I have to press the 
appropriate button.

I have seen the module parameter "proto" in the source. Is it worth to play 
with it?

Thanks,
Torsten
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFBR2YWwicyCTir8T4RAjCfAKCmHnMSqXUOYmimEB1HhneZjOsVPACeIU0U
zYaC0HEupjEHsJTreBF0NQM=
=aYmG
-----END PGP SIGNATURE-----
