Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274725AbRIUAzp>; Thu, 20 Sep 2001 20:55:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274726AbRIUAz0>; Thu, 20 Sep 2001 20:55:26 -0400
Received: from nobugconsulting.ro ([213.157.160.38]:25615 "EHLO
	nobugconsulting.ro") by vger.kernel.org with ESMTP
	id <S274725AbRIUAzP>; Thu, 20 Sep 2001 20:55:15 -0400
Message-ID: <3BAA9008.9837EA52@nobugconsulting.ro>
Date: Fri, 21 Sep 2001 03:55:36 +0300
From: lonely wolf <wolfy@nobugconsulting.ro>
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.8-ac12 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: probable hardware bug: clock timer configuration lost
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-RAVMilter-Version: 8.2(snapshot 20010817) (mail)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi there

I've got a small problem. Just installed kernel-2.4.9-ac12 on 5
identical boxes. They all use Asus A7A266 motherboards, with Tbirds
running  at 1.2 GHz. A lspci gives:

00:00.0 Host bridge: Acer Laboratories Inc. [ALi]: Unknown device 1647
(rev 04)
00:01.0 PCI bridge: Acer Laboratories Inc. [ALi] M5247
00:02.0 USB Controller: Acer Laboratories Inc. [ALi] M5237 USB (rev 03)
00:04.0 IDE interface: Acer Laboratories Inc. [ALi] M5229 IDE (rev c4)
00:06.0 USB Controller: Acer Laboratories Inc. [ALi] M5237 USB (rev 03)
00:07.0 ISA bridge: Acer Laboratories Inc. [ALi] M1533 PCI to ISA Bridge
[Aladdin IV]
00:09.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8139
(rev 10)
00:0d.0 Multimedia audio controller: C-Media Electronics Inc CM8738 (rev
10)
00:11.0 Bridge: Acer Laboratories Inc. [ALi] M7101 PMU
01:00.0 VGA compatible controller: nVidia Corporation Vanta [NV6] (rev
15)

The problem: especially when copying from a disk to another one (I have
cloned /dev/hda to /dev/hdc, testing both dd if=/dev/hda of=/dev/hdc and
cp -a /dev/hdaN /devc/hdcN) a get _a_lot_ of messages like this one:

probable hardware bug: clock timer configuration lost - probably a
VIA686a motherboard.
probable hardware bug: restoring chip configuration.

Is it dangerous ? Any way to get rid of this phenomemon (maintaining the
hardware...)?


--
      Manuel Wolfshant       linux registered user #131416
       network administrator    NoBug Consulting Romania
The degree of technical confidence is inversely proportional to the
level of management.



