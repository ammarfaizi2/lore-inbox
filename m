Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262009AbTKOV7x (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 15 Nov 2003 16:59:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262110AbTKOV7x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 15 Nov 2003 16:59:53 -0500
Received: from smtp-send.myrealbox.com ([192.108.102.143]:14928 "EHLO
	smtp-send.myrealbox.com") by vger.kernel.org with ESMTP
	id S262009AbTKOV7v (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 15 Nov 2003 16:59:51 -0500
Subject: PROBLEM: 2.6.0-test9 won't boot on HP ze5395 Laptop
From: "Christopher S. Case" <macguyvok@myrealbox.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Message-Id: <1068933591.25799.32.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Sat, 15 Nov 2003 16:59:51 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

PROBLEM: 2.6.0-test9 won't boot on HP ze5395 Laptop.

I run Fedora Core 1, and I wanted to get suspend/resume, so I figured
I'd give the new 2.6.0 kernel a try, and see how it works. I compiled
the kernel, and everything without a hitch. I installed it, and my
laptop brings up grub just fine. I select the entry for the 2.6.0test9
kernel, and the system reboot. I've used the pause key to see that it
reboots right after it finishes uncompressing the kernel. I've tried
different processor settings, and nothing works. It doesn't get beyond
this point. Any Ideas?

ver_linux output:

Linux TurboKat.G33X-Nexus 2.4.22-1.2115.nptl #1 Wed Oct 29 15:42:51 EST
2003 i686 i686 i386 GNU/Linux

Gnu C                  3.3.2
Gnu make               3.79.1
util-linux             2.11y
mount                  2.11y
module-init-tools      writing
e2fsprogs              1.34
jfsutils               1.1.3
reiserfsprogs          3.6.8
pcmcia-cs              3.1.31
quota-tools            3.06.
PPP                    2.4.1
nfs-utils              1.0.6
Linux C Library        2.3.2
Dynamic linker (ldd)   2.3.2
Procps                 2.0.17
Net-tools              1.60
Kbd                    1.08
Sh-utils               5.0
Modules Loaded         udf floppy sr_mod trident ac97_codec pcigame
gameport soundcore binfmt_misc parport_pc lp parport autofs rfcomm l2cap
bluez ds yenta_socket pcmcia_core orinoco_pci orinoco hermes natsemi
ipt_REJECT ipt_state ip_conntrack iptable_filter ip_tables microcode
ide-scsi scsi_mod ide-cd cdrom nls_iso8859-1 nls_cp437 vfat fat keybdev
hid ehci-hcd usb-uhci usbcore thermal processor fan button battery
asus_acpi ac mousedev input ext3 jbd

cat /proc/cpuinfo: 
processor       : 0
vendor_id       : GenuineIntel
cpu family      : 15
model           : 2
model name      : Intel(R) Pentium(R) 4 CPU 2.66GHz
stepping        : 7
cpu MHz         : 2658.243
cache size      : 512 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 sep mtrr pge mca
cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe cid
bogomips        : 5295.30

Let me know if there's anything else important.

--Chris

