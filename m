Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263234AbTCSWWR>; Wed, 19 Mar 2003 17:22:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263208AbTCSWUg>; Wed, 19 Mar 2003 17:20:36 -0500
Received: from kura.mail.jippii.net ([195.197.172.113]:64655 "HELO
	kura.mail.jippii.net") by vger.kernel.org with SMTP
	id <S263202AbTCSWSj>; Wed, 19 Mar 2003 17:18:39 -0500
Message-ID: <3617283.1048112940351.JavaMail.flexy@nic.fi>
Date: Thu, 20 Mar 2003 00:29:00 +0200 (EET)
From: flexy@nic.fi
To: linux-kernel@vger.kernel.org
Subject: 2.4.21-pre5 kernel Oops, USB related (and some other problems)
Cc: flexy@nic.fi
Mime-Version: 1.0
Content-Type: text/plain; Charset=utf-8; Format=Flowed
Content-Transfer-Encoding: 7bit
X-Mailer: Saunalahti webmail - http://www.saunalahti.fi
X-Originating-IP: 213.139.183.246
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

First, this seems to be a reproducible oops. Second, the kernel oops 
messages, ksymoops outputs and some other stuff I thought might be of 
use, can be found at

http://stekt.oulu.fi/~flexy/Oops.tar

Then, about my hardware,

Epox M762A SMP board with AMD-760MPX chipset
2*MP1600+, NOT overclocked
512MB Crucial ECC memory, Correct+Scrub set on@bios
Intel PRO/1000MT 1Gb NIC
Intel build in 100Mb NIC
S3 PCI display adapter
Adaptec ATA RAID 2400A, with 4 disks at raid5
HP PSC750 (USB)

In the Oops.tar, there is two directories, 1 and 2. In directory 1, 
there is a Oops with this hardware and in 2, there is Oops with onboard 
USB hub disabled from bios and PCI USB adapter in use. I don't know the 
exact type of the adapter, but it came with MSI K7 Master-L motherboard, 
allmost the same motherboard as this Epox. And it seems to use the same 
driver.

OK, this was the main thing.

Then I have two issues, that I can't get logs, or alike of. First, I 
have a 4x4 cd changer, which kernel reports as: ALPS ELECTRIC CO.,LTD. 
DC544C, ATAPI CD/DVD-ROM drive. I use ide-scsi on it. Almost every time 
I use it, the kernel hangs totally, nothing on the logs, no ssh 
connections etc, Magic SysReQ does not work. This worked fine with old 
P150 machine, but has not worked with this new hardware... Second, on 
boot, sometimes the boot starts over from the bios screen. I can see it 
when it is gonna happen, cause does not go fast to the Adaptec raid card 
recognision, but stops for a moment at something about processors... I 
know this is a bit vague, but if somebody has had the same problem, or 
would like to examine it more, I could try to capture it with 
camcorder... And finally, these both things happen with both Epox and 
MSI motherboards.


Thanks in advance,
Flexy

P.S. I am much more of a HW person, so I propably missed something... 
I'm happy to provide any more information to help to solve any of these 
problems. Just let me know what. :)

P.P.S. When responding to this mail in any way, please don't drop me out 
of the loop, put flexy@nic.fi to CC: list :)

