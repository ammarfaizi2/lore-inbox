Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267315AbTBKQuq>; Tue, 11 Feb 2003 11:50:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267342AbTBKQuq>; Tue, 11 Feb 2003 11:50:46 -0500
Received: from ma-northadams1b-38.bur.adelphia.net ([24.52.166.38]:6529 "EHLO
	ma-northadams1b-38.bur.adelphia.net") by vger.kernel.org with ESMTP
	id <S267315AbTBKQup>; Tue, 11 Feb 2003 11:50:45 -0500
Date: Tue, 11 Feb 2003 12:00:33 -0500
From: Eric Buddington <eric@ma-northadams1b-418bur.adelphia.net>
To: linux-kernel@vger.kernel.org
Subject: 2.5.60-i386 freezes after decompress on Athlon
Message-ID: <20030211120033.B27012@ma-northadams1b-418bur.adelphia.net>
Reply-To: ebuddington@wesleyan.edu
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Organization: ECS Labs
X-Eric-Conspiracy: there is no conspiracy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

2.5.60, compiled for i386 but running on an Athlon, darn near
everything as modules.

I get the standard "Uncompressing linux... booting" on boot, then a
hard freeze; no keyboard LED response, no SysRq reboot.

I tried with acpi=off, same result.

I initially assumed that console traffic was directed elsewhere, but
VGA console is compiled in and vga=6 specified on the GRUB boot line.

2.4.20 works fine on this system, 2.5.58 at least boots.

I have no idea what to try next.

-Eric
