Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262566AbTKRLKd (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Nov 2003 06:10:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262581AbTKRLKd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Nov 2003 06:10:33 -0500
Received: from main.gmane.org ([80.91.224.249]:1943 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S262566AbTKRLK1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Nov 2003 06:10:27 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: "Patrick Beard" <patrick@scotcomms.co.uk>
Subject: Smartmedia 2.6.0-test9 problem.
Date: Tue, 18 Nov 2003 11:11:26 -0000
Message-ID: <bpcumv$v22$1@sea.gmane.org>
X-Complaints-To: usenet@sea.gmane.org
X-MSMail-Priority: Normal
X-Newsreader: Microsoft Outlook Express 6.00.2800.1158
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
I have two smartmedia cards 16mb and 64mb. I have recently compiled the
Debian source for Kernel 2.6.0-test9.
I normally only use my 64mb card together with a usb reader. The problem I
have led me to the wrong conclusion which I reported to this group. For this
I apologise.

I have now clearly identified the problem and have repeated it and doubled
checked to ensure that this post is accurate.
The problem is;
I can mount both the 16mb and 64mb cards if I use my camera. If I use my
reader, the 16mb card mounts ok but, the 64mb card returns no media found.
When I used the 2.4.19 kernel the 64mb card worked fine with the reader. A
new addition to my setup (apart from 2.6-test) is a usb to serial adapter. I
connect all these to a usb hub running in passive mode. In case the addition
of the usb/serial adapter was not leaving enough power for the larger
capacity SM card I attached the power adapter to the hub and switched it to
'powered'. This made not difference to the problem.
my fstab entry is;
/dev/sda1    /mnt/smedia    vfat    rw,user,noauto    0,0

when the 64mb card is mounted in the camera fdisk -l returns;

/dev/sda1 * 1 500 63972+ 1 FAT12

Any help on this would be appreciated.

__
Patrick



