Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270350AbTG1SMl (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Jul 2003 14:12:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270380AbTG1SMl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Jul 2003 14:12:41 -0400
Received: from iwoars.net ([217.160.110.113]:49676 "HELO iwoars.net")
	by vger.kernel.org with SMTP id S270350AbTG1SMk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Jul 2003 14:12:40 -0400
Date: Mon, 28 Jul 2003 20:28:22 +0200
From: Thomas Themel <themel-lkml@iwoars.net>
To: linux-kernel@vger.kernel.org
Subject: rivafb still broken in 2.6.0-test2?
Message-ID: <20030728182822.GG391@iwoars.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
X-Jabber-ID: themel0r@jabber.at
X-ICQ-UIN: 8774749
X-Postal: Hauptplatz 8/4, 9500 Villach, Austria
X-Phone: +43 676 846623 13
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I'm trying to get rivafb working with a GeForce 4 MX 440 and
2.6.0-test2. The penguin logo and the cursor are displayed correctly,
but the rest of the screen is garbage (I assume I can find a more
verbose graphical description for the garbage if it is helpful :)).

The original problem was encountered on a UP kernel running ACPI, local
APIC and MTRR support, but removing these features didn't help.

This is what rivafb has to say:

rivafb: nVidia device/chipset 10DE0171
rivafb: Detected CRTC controller 0 being used
rivafb: PCI nVidia NV20 framebuffer ver 0.9.5b (nVidiaGeForce4-M, 64MB @ 0xD0000000)
Console: switching to colour frame buffer device 80x30

with MTRR enabled, it's:

rivafb: nVidia device/chipset 10DE0171
rivafb: Detected CRTC controller 0 being used
rivafb: RIVA MTRR set to ON
rivafb: PCI nVidia NV20 framebuffer ver 0.9.5b (nVidiaGeForce4-M, 64MB @ 0xD0000000)
Console: switching to colour frame buffer device 80x30

but gives the same result. Is this supposed to work? 

ciao,
-- 
[*Thomas  Themel*] "That doesn't make it bad, but it's also not
[extended contact]  spectacular nerd porn."
[info provided in] 	- ExtremeTech review of IA-64
[*message header*]	
