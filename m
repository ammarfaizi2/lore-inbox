Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136387AbRD2WG1>; Sun, 29 Apr 2001 18:06:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136386AbRD2WGR>; Sun, 29 Apr 2001 18:06:17 -0400
Received: from pc-25-211.mountaincable.net ([24.215.25.211]:2200 "HELO
	adrock.vbfx.com") by vger.kernel.org with SMTP id <S136390AbRD2WGF>;
	Sun, 29 Apr 2001 18:06:05 -0400
Message-ID: <3AEC9052.EA3ECBAC@vbfx.com>
Date: Sun, 29 Apr 2001 18:06:10 -0400
From: Adam <adam@vbfx.com>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.3 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: 8139too in 2.4.4 Hanging/Locking
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Please CC this back, as I'm not yet on the kernel-mailing-list

I'm currently running the following:

kernel 2.4.3
gcc 2.95.3
modutils 2.4.2
dhcpcd v.1.3.19-pl8

The problem is, after compiling the 2.4.4 kernel with the exact
configuration as I had used on the 2.4.3 kernel, my system hangs at:

8139too Fast Ethernet driver 0.9.16 loaded [the version number is
greater than 0.9.15c (which is used in 2.4.3) though I'm not exactly
sure if it's 0.9.16]
PCI: Found IRQ 9 for device 00:0b.0
eth0: RealTek RTL8139 Fast Ethernet at 0xd0814000, 00:50:ba:d2:45:21,
IRQ 9
eth0:  Identified 8139 chip type 'RTL-8139B'
eth0: Setting half-duplex based on auto-negotiated partner ability 0000.
[this is where it hangs, it requires me to reboot and load up a backup
kernel (2.4.3)]

If there is any other information you require to solve this problem, I'd
be happy to help.


-- 
Adam
adam@vbfx.com
Linux user #190288
