Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262790AbSKIWmd>; Sat, 9 Nov 2002 17:42:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262795AbSKIWmd>; Sat, 9 Nov 2002 17:42:33 -0500
Received: from h55p111.delphi.afb.lu.se ([130.235.187.184]:64943 "EHLO
	gagarin.0x63.nu") by vger.kernel.org with ESMTP id <S262790AbSKIWmd>;
	Sat, 9 Nov 2002 17:42:33 -0500
Date: Sat, 9 Nov 2002 23:49:06 +0100
To: linux-kernel@vger.kernel.org
Cc: vojtech@suse.cz
Subject: 2.5.46latest bk: psmouse.c: Lost synchronization
Message-ID: <20021109224906.GA30678@gagarin>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
From: Anders Gustafsson <andersg@0x63.nu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

in 2.5.46 my pointer jumps around on screen and these messages appears in
kernel log:
psmouse.c: Lost synchronization, throwing 1 bytes away.
psmouse.c: Lost synchronization, throwing 2 bytes away.

I'm accessing the mouse through /dev/psaux. The "mouse" is the trackpoint
on an ibm thinkpad x24.

-- 
Anders Gustafsson - andersg@0x63.nu - http://0x63.nu/
