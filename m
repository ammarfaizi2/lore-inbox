Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268693AbRGZUgl>; Thu, 26 Jul 2001 16:36:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268692AbRGZUga>; Thu, 26 Jul 2001 16:36:30 -0400
Received: from [129.219.88.140] ([129.219.88.140]:61879 "EHLO
	exchange01.ncacasi.org") by vger.kernel.org with ESMTP
	id <S268693AbRGZUgP> convert rfc822-to-8bit; Thu, 26 Jul 2001 16:36:15 -0400
Subject: Proliant ML530, Megaraid 493 (Elite 1600), 2.4.7, timeout & abort
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 8BIT
Date: Thu, 26 Jul 2001 13:35:27 -0700
Message-ID: <F540EC7334CFED478994B370191C960957E1@exchange01.ncacasi.org>
X-MimeOLE: Produced By Microsoft Exchange V6.0.4712.0
content-class: urn:content-classes:message
Thread-Topic: Proliant ML530, Megaraid 493 (Elite 1600), 2.4.7, timeout & abort
Thread-Index: AcEWEWre3+A7MpyzR/6SMBVEO/pLWw==
From: "C. R. Oldham" <cro@ncacasi.org>
To: <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

Greetings,

We have acquired a couple of Proliant ML530 servers without the Compaq
RAID controllers, so I put AMI Megaraid 493 controllers (also known as
the Elite 1600) in them. I am able to get them to boot with 2.2.19, but
not 2.4.7.   Under 2.4.7 the relevant message is

megaraid: v1.17a (Release Date: Fri Jul 13 18:44:01 EDT 2001)
megaraid: found 0x101e:0x1960:idx 0:bus7:slot 0:func 0
scsi2 : Found a MegaRAID controller at 0xf880c000, IRQ: 15
scsi2: Enabling 64 bit support
megaraid: [A159:3.11] detected 1 logical drives
megaraid: channel [1] is raid.
megaraid: channel [2] is raid.
scsi2 : AMI MegaRAID A159 254 commands 16 targs 2 chans 40 luns
scsi2: scanning channel 1 for devices.
scsi : aborting command due to timeout : pid 0, scsi2, channel 0, id 0,
lun 0 Inquiry 00 00 00 ff 00

and the box stops there, though magic-SysRq still works.  I've tried
both 2.4.7 and 2.4.7ac1.  Does anyone have any suggestions?

Please cc:me on responses.  TIA.

-- 
  / C. R. (Charles) Oldham | NCA-CASI                     \
 / Director of Technology  | Arizona State University      \
/ cro@nca.asu.edu          | V:480-965-8703  F:480-965-9423 \
