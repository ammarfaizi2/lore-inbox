Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263310AbTE3MMO (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 May 2003 08:12:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263594AbTE3MMO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 May 2003 08:12:14 -0400
Received: from [62.75.136.201] ([62.75.136.201]:46312 "EHLO mail.g-house.de")
	by vger.kernel.org with ESMTP id S263310AbTE3MMM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 May 2003 08:12:12 -0400
Message-ID: <3ED74DBA.7020402@g-house.de>
Date: Fri, 30 May 2003 14:25:30 +0200
From: Christian <evil@g-house.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; de-AT; rv:1.4b) Gecko/20030507
X-Accept-Language: de, en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: keyboard: repeating chars
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi,

i am running 2.5 kernels, 2.5.70 right now and i always have this
keyboard problem: when booting, usb kbd and a ps/2 kbd gets installed.
but when i first try to use them, one keypress gives me 5+ chars.
so would have to login with "rrrrrooooooootttttt" as user name.

when i unplug/replug say the usb kbd, the usb kbd is working right,
while the ps/2 kbd is still behaving this weird. i have to unplug/replug
the ps/2 kbd too.

i *think* i read this thing in a FAQ already but i couldn't remember.

kernelnewbies.org or the lk-ml FAQ gave nothin, a chat on #kernelnewbies 
made me believe something very strange is going on.

for clarification i want to repeat the problem in another way:

- one ps/2 keyboard *and* one usb keyboard is plugged into the PC (yes, 
i have _2_ kbds)
- ps/2 and usb kbd support is compile statically into the kernel:

CONFIG_SERIO
CONFIG_SERIO_I8042
CONFIG_INPUT_KEYBOARD
CONFIG_KEYBOARD_ATKBD
CONFIG_USB_UHCI_HCD
CONFIG_USB_KBD

- the computer boots up, the kbd driver get loaded, i sit in front of 
some login prompt (X or console)

- the usb kbd is only writing ttthhhiiiissss way.
- i try the ps/2 kbd, it is also writing only ttthhhhiiiisss way.
(i was able to write "root" in a sane way, but the password.....)
- i unplug the usb kbd and replug it --> i can use the usb kbd.
- the ps/2 is still behaving this weird, so i have to unplug/replug the 
ps/2 kbd to use it, too.


i noticed the problem once with 2.5.65(?) on linux/alpha, with a single 
ps/2 kbd connected. but the problem disappeared somehow.

Thank you for any hints,
Christian.

