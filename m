Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266908AbTAZOa3>; Sun, 26 Jan 2003 09:30:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266926AbTAZOa3>; Sun, 26 Jan 2003 09:30:29 -0500
Received: from harpo.it.uu.se ([130.238.12.34]:3499 "EHLO harpo.it.uu.se")
	by vger.kernel.org with ESMTP id <S266908AbTAZOa2>;
	Sun, 26 Jan 2003 09:30:28 -0500
Date: Sun, 26 Jan 2003 15:39:44 +0100 (MET)
From: Mikael Pettersson <mikpe@csd.uu.se>
Message-Id: <200301261439.PAA08423@harpo.it.uu.se>
To: vojtech@suse.cz
Subject: Re: Dell Latitude CPi keyboard problems since 2.5.42
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 25 Jan 2003 15:02:16 +0100, Vojtech Pavlik wrote:
>Do the symptoms persist when you disable AT keyboard support completely?
>(You'll need a different way to control the machine - USB or Ethernet
>for the test.)

Disabling CONFIG_KEYBOARD_ATKBD (but keeping SERIO_I8042 and
MOUSE_PS2 enabled) eliminates the BIOS keyboard error on my
Latitude when rebooting after running 2.5.59.

/Mikael
