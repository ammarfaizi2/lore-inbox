Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261381AbVCXNI1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261381AbVCXNI1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Mar 2005 08:08:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262449AbVCXNI1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Mar 2005 08:08:27 -0500
Received: from animx.eu.org ([216.98.75.249]:52665 "EHLO animx.eu.org")
	by vger.kernel.org with ESMTP id S261381AbVCXNIY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Mar 2005 08:08:24 -0500
Date: Thu, 24 Mar 2005 08:11:39 -0500
From: Wakko Warner <wakko@animx.eu.org>
To: linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       inux-input@atrey.karlin.mff.cuni.cz, vojtech@suse.cz
Subject: Extra keys not working with 2.6
Message-ID: <20050324131139.GB30623@animx.eu.org>
Mail-Followup-To: linux-usb-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org, inux-input@atrey.karlin.mff.cuni.cz,
	vojtech@suse.cz
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Please keep me CCd especially because I'm not on inux-input.
I'm emailing the USB list since this is a usb keyboard (wireless HP)

This keyboard has 8 extra keys on the top row.  Under 2.4, all the keys
worked fine.  Under 2.6 only 2 of those keys are recognised.

This is a partial dmesg when pressing the keys:
keyboard.c: can't emulate rawmode for keycode 242
keyboard.c: can't emulate rawmode for keycode 241
keyboard.c: can't emulate rawmode for keycode 241
keyboard.c: can't emulate rawmode for keycode 241
keyboard.c: can't emulate rawmode for keycode 241
keyboard.c: can't emulate rawmode for keycode 241
keyboard.c: can't emulate rawmode for keycode 241
keyboard.c: can't emulate rawmode for keycode 240
keyboard.c: can't emulate rawmode for keycode 240
keyboard.c: can't emulate rawmode for keycode 240
keyboard.c: can't emulate rawmode for keycode 240
keyboard.c: can't emulate rawmode for keycode 244
keyboard.c: can't emulate rawmode for keycode 244
keyboard.c: can't emulate rawmode for keycode 244

Under 2.4 and doing showkey -s I get these codes for the keys:
Key	Press	Release
1	46	c6
2	02	82
3	65	e5
4	6c	ec
5	45	c5
6	44	c4
7	4c	cc
8	4a	ca

(The keys aren't numbered)

How do I fix this so that it works again?  (I cannot test this on the PS/2
port.  the receiver doesn't support it)

-- 
 Lab tests show that use of micro$oft causes cancer in lab animals
