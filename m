Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267834AbUHUVGu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267834AbUHUVGu (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Aug 2004 17:06:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267870AbUHUVFu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Aug 2004 17:05:50 -0400
Received: from dennis.enea.se ([192.36.1.67]:13256 "EHLO dennis.enea.se")
	by vger.kernel.org with ESMTP id S267906AbUHUVAu convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Aug 2004 17:00:50 -0400
From: =?iso-8859-1?Q?M=E5rten_Berggren?= <berg@enea.se>
To: <linux-kernel@vger.kernel.org>
Subject: 2.4.20, Asus A7V333  PDC20276 and device naming?
Date: Sat, 21 Aug 2004 23:01:00 +0200
Organization: Enea Open Systems
Message-ID: <000001c487c1$f7098290$820113ac@enea.se>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.3416
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1409
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

my computer has a PDC20276 on the motherboard (Asus K7V333, i e VIA
KT333) 
and I have been running Linux on it (Suse 8.2, i e 2.4.20 with initrd
to boot reiserfs from /dev/hda2; lilo does the booting). When I have
the PDC20276 disabled using a jumper, it does not show up in /proc/pci.

Recently, I added two drives to the controller and enabled it.
This caused booting to fail with a panic saying hda cannot be mounted.
But if I boot the rescue cd, I can mount the root from /dev/hda2.
Using grub from a diskette, I can almost complete a boot from the first 
bios disc (i e 0), but I have to set root=/dev/hde2. The whole things
ends by telling me to fsck my disc, which is mounted as hda2 even if
I've changed fstab to mount root from hde2.

Now I am stuck. To me it seems like the kernel behaves inconsistently,
sometimes calling my disc hda, sometimes hde. (The BIOS apparently plays
some games (with Int13?) to make booting from RAID possible?) Any
pointer 
or information would be very appreciated! I can provide more details if
needed. 
Please Cc me since I do not subscibe to the list. (If I should ask
somewhere else, 
please tell me.)

Regards

Mårten B

