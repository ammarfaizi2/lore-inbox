Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285589AbSALK0U>; Sat, 12 Jan 2002 05:26:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285666AbSALK0I>; Sat, 12 Jan 2002 05:26:08 -0500
Received: from xena.tvnetwork.hu ([80.95.64.68]:25288 "EHLO xena.tvnetwork.hu")
	by vger.kernel.org with ESMTP id <S285589AbSALKZy> convert rfc822-to-8bit;
	Sat, 12 Jan 2002 05:25:54 -0500
Content-Type: text/plain; charset=US-ASCII
From: "[joco]" <fejes@tvnetwork.hu>
To: linux-kernel@vger.kernel.org
Subject: opl3sa2 sound
Date: Sat, 12 Jan 2002 11:25:55 +0100
X-Mailer: KMail [version 1.2]
MIME-Version: 1.0
Message-Id: <02011211255503.00430@carma>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

I have a configured and sometimes working ISAPnP Yamaha OPL3SA2 sound card. 
With 2.2.x kernels, it always worked, but with 2.4.x (all versions), it has 
problems. I have this computer at home, and when I don't use it, I turn it 
off, or reboot to Windows. Generally after a long period, when it is turned 
off, it won't work. After reboots it does, but not everytime. I don't know 
what the problem can be, it seems very random, and has a chance of about 10%. 
When it's working, ad1848 module says:

ad1848: No ISAPnP cards found, trying standard ones...
opl3sa2: 1 PnP card(s) found.

And then I have sound. When not:

ad1848: Interrupt test failed (IRQ5)
opl3sa2: 1 PnP card(s) found.

But then I can't play sound. rmmod opl3sa2 ; modprobe opl3sa2 don't work, 
only after a reboot do I get the sound card working. Do you have ideas?

-- 
:|[ [joco] at IRCNet * fejes@tvnetwork.hu * http://jocoweb.fw.hu/ ]|:
:|[ fingerprint ABEF A08E 7F5A 38AC EA9B B614 BC9F 64DD EB6A 6818 ]|:
