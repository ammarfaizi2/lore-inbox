Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263963AbTL2TBt (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Dec 2003 14:01:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264126AbTL2TBt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Dec 2003 14:01:49 -0500
Received: from compunauta.com ([69.36.170.169]:9095 "EHLO compunauta.com")
	by vger.kernel.org with ESMTP id S263963AbTL2TAv convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Dec 2003 14:00:51 -0500
From: Gustavo Guillermo <gustavo@compunauta.com>
Date: Mon, 29 Dec 2003 12:03:05 GMT
Message-ID: <20031229.12030500.907603006@linux.local>
Subject: [OT] Experience with wheel mouse optical usb
To: Andreas Theofilu <andreas.theofilu@chello.at>,
       linux-kernel@vger.kernel.org, dju <dju.ml@elegiac.net>
In-Reply-To: <20031229165543.214021E000@chello062178157104.9.14.vie.surfer.at>
References: <1888o-1In-15@gated-at.bofh.it> <20031229165543.214021E000@chello062178157104.9.14.vie.surfer.at>
X-Mailer: Mozilla/3.0 (compatible; StarOffice/5.2;Linux)
X-Priority: 3 (Normal)
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO_8859-15
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, this is only for usb wheel mouse users, this is my experience with 
kernel 2.4.X and 2.6.0.

May be this help for someone.

If someone has something to tell me, thanks.

Asus MOBO kt266
2.4.X (21 - 23) Behavior
USB Wheel mouse should be unplugged and replugged to turn it on and get 
it to work, I try whit usbkbd activated and deactivated.
When power source is still available I can restart a lot of times without 
replugging my mouse. This happens only when power off/On.
A lot of USB cameras work incredible great (Fuji/Casio/Logitech). Every 
stuff pass into my hands, is going to be tested, and only weird Walkman 
or uncommon hardware doesn't work.

Asus MOBO kt266
2.6.0 (test9-11-F.R.) Behavior
USB Wheel mouse should be unplugged and replugged to turn it on. But in 
this weird case I need to restart Linux, Mouse just only works if kernel 
boot with mouse turned on.
I have hotplug, of course and new init-module-tools


Note: If you have mouse on one USB HUB, you should put other devices like 
usbscanner or mass-storage device on other USB HUB, to get it work fine. 
Generally, new MOBOS has 2 UBS 4 PORTS IN TOTAL, and OTHER HUB for front 
panel. Some USB devices can't share the same HUB. I test a QUE! CD Writer 
USB and a Fuji/Casio cameras (mass storage) and in both cases this 
devices doesn't like to share the same HUB with USB mouse. 

For nvidia users: Hey! If the wheel doesn't work with patched driver, try 
an older one, it works for me.

http://www.sh.nu/download/nvidia/

[4620]

Happy new Year
