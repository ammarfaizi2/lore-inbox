Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293076AbSCWN0d>; Sat, 23 Mar 2002 08:26:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293119AbSCWN0Y>; Sat, 23 Mar 2002 08:26:24 -0500
Received: from moutvdom00.kundenserver.de ([195.20.224.149]:64060 "EHLO
	moutvdom00.kundenserver.de") by vger.kernel.org with ESMTP
	id <S293076AbSCWN0M> convert rfc822-to-8bit; Sat, 23 Mar 2002 08:26:12 -0500
Content-Type: text/plain; charset=US-ASCII
From: Christian Asam <Christian.Asam@chasam.de>
To: linux-kernel@vger.kernel.org
Subject: [2.4.x] Writing to slow devices (MO, USB) blocks system
Date: Sat, 23 Mar 2002 14:26:09 +0100
X-Mailer: KMail [version 1.3.2]
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E16olX9-0005Xy-00@mrvdom03.kundenserver.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have had this problem for a while now and was wondering, if there is 
some workaround or patch for it:
If I write larger files (maybe >10M) to slow devices (I have a 
USB-1.1-HD and a SCSI-MO where this is a problem) the system freezes 
for a while: In X (4.1) the mouse only moves every couple of seconds, 
sometimes XMMS also is silent for a few seconds but not as often. After 
a while the freezes get more seldom but are still rather frequent.

System:
Duron 800 on KT133/686, IDE Disks, 768M Memory (but no high memory 
support >1G active), 2.4.13 (for some reason my serial digitizer (via 
gpm) dosn't work with newer kernels like 17 or 18).

cu
