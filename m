Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289597AbSBEPps>; Tue, 5 Feb 2002 10:45:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289600AbSBEPpi>; Tue, 5 Feb 2002 10:45:38 -0500
Received: from gold.he.net ([216.218.149.2]:34308 "EHLO gold.he.net")
	by vger.kernel.org with ESMTP id <S289597AbSBEPpT>;
	Tue, 5 Feb 2002 10:45:19 -0500
Reply-To: <jss@pacbell.net>
From: "J.S.Souza" <jss@pacbell.net>
To: <linux-kernel@vger.kernel.org>
Subject: Kernel compile problem after reboot
Date: Tue, 19 Feb 2002 07:47:54 -0800
Message-ID: <PGEMINDOPMDNMJINCKBNMECBCAAA.jss@pacbell.net>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2910.0)
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4522.1200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I am using Slack 8 with 2.2.19 and trying to install 2.4.17.  The whole
compile process goes as planned until I reboot.  After reconfiguring
lilo.conf and running lilo to update changes, I reboot and when I select the
new kernel all I get is

Loading Linux........................

Then my computer reboots and this continues to do the same until I select
the old kernel and it reboots fine.
Did I do something wrong in lilo?  I merely made a duplicate entry with a
different image= and label= entry:

image = /boot/vzlinuz-2.4.17
root = /dev/hda5
label = Linux_2.4.17
read-only

I perform the standard:
make mrproper
make menuconfig
make dep && make bzImage && make modules &&
make modules_install
cp System.map to /boot
cp bzImage to /boot
edit lilo.conf
run lilo
reboot
swear at the computer.

The compile is clean from what I can see - no error messages.
The menuconfig part is all defaults (just trying to get it to reboot at this
point).

Any advice would be better than what i've got and would be much appreciated.


			J.S.Souza

