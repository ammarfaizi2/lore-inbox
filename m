Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281077AbRLLQYO>; Wed, 12 Dec 2001 11:24:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281116AbRLLQXy>; Wed, 12 Dec 2001 11:23:54 -0500
Received: from zeus.hjc.edu.sg ([203.127.28.34]:60360 "HELO zeus.hjc.edu.sg")
	by vger.kernel.org with SMTP id <S281077AbRLLQXm>;
	Wed, 12 Dec 2001 11:23:42 -0500
To: linux-kernel@vger.kernel.org
Subject: Kernel-2.4.17pre8 & invalidate: busy buffer
Message-ID: <1008174218.3c17848ab4b69@home.hjc.edu.sg>
Date: Thu, 13 Dec 2001 00:23:38 +0800 (SGT)
From: Chen Shiyuan <csy@hjc.edu.sg>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
User-Agent: Hwa Chong Junior College Mail System (CMS)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Currently while running on a RedHat Linux 7.2 box with kernel-
2.4.17pre8, whenever I run the "hdparm -t /dev/sda3" command, the 
following error message will appear around 33+ times 
in /var/log/messages as well as "dmesg" .

invalidate: busy buffer

The machine in question is a Dell PowerEdge 2550 with an AACRAID 
controller and 2 x 18GB HDs in RAID-1 configuration and /dev/sda3 being 
mount as / .

Is this a bug in the kernel or is it caused by some hardware faults?

Does anyone have any solution or workaround to this problem?

Many thanks in advance for any assistance!

(Please CC: replies to me as I am not subscribed to the list.)
