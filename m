Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129635AbRCAPN2>; Thu, 1 Mar 2001 10:13:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129636AbRCAPNI>; Thu, 1 Mar 2001 10:13:08 -0500
Received: from mailout06.sul.t-online.com ([194.25.134.19]:9221 "EHLO
	mailout06.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S129635AbRCAPM7>; Thu, 1 Mar 2001 10:12:59 -0500
Message-ID: <3A9E66BB.70FB0C75@eikon.tum.de>
Date: Thu, 01 Mar 2001 16:11:55 +0100
From: Mario Hermann <ario@eikon.tum.de>
X-Mailer: Mozilla 4.76 [de] (X11; U; Linux 2.2.18 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: report bug: System reboots when accessing a loop-device over a second 
 loop-device with 2.4.2-ac7
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

I tried the following commands with 2.4.2-ac7:

losetup /dev/loop0 test.dat
losetup /dev/loop1 /dev/loop0
mke2fs /dev/loop1

My System reboots immediatly. I tried it with 2.4.2-ac4,ac5 too -> same
effect.

With 2.4.2 it hangs immediatly.

Hope that helps.


Thanks


Mario
