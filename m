Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268132AbTAKTqs>; Sat, 11 Jan 2003 14:46:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268131AbTAKTqs>; Sat, 11 Jan 2003 14:46:48 -0500
Received: from smtp02.wxs.nl ([195.121.6.54]:38335 "EHLO smtp02.wxs.nl")
	by vger.kernel.org with ESMTP id <S268132AbTAKTqr>;
	Sat, 11 Jan 2003 14:46:47 -0500
Message-ID: <006201c2b9ab$668e1950$1400a8c0@Freaky>
From: "freaky" <freaky@bananateam.nl>
To: <linux-kernel@vger.kernel.org>
Subject: 2.4.20 Promise IDE RAID Locks up (gcc 3.2.1!)
Date: Sat, 11 Jan 2003 20:55:32 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2600.0000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hey there,

I compiled 2.4.20 on gentoo 1.4rc2 (gcc 3.2.1). When emerging (compiling) X
my system often gives compile errors which I don't get on the second go, I
either get others or my system locks up. When the system locks up, and
rebooting with reset the IDE RAID controller where the disc I'm using under
linux is on is messed up. (In my case the disc is on the secondary IDE
controller). The controller will not find any disks on that controller on
reboot, the other one works fine. I have to power down before it will find
them again.

Also, probably unrelevant but I'd like to see if some other people have
experience with it and this might be a good place to look :-), I tried
compiling the module promise releases (it's sort of like the nVidia NVdriver
module) but it locks up my system after the banner (this was against
2.4.20xfs_pre2, the kernel used with the gentoo 1.4rc2). If anyone has any
experience with their module I'd like to hear their experiences with it.

Kind regards,

Ferry van Steen

Oh, the controller is a MBFastTrak133 Lite onboard on a MSI KT3 Ultra2-R.


