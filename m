Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131632AbQLNPpd>; Thu, 14 Dec 2000 10:45:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130396AbQLNPpY>; Thu, 14 Dec 2000 10:45:24 -0500
Received: from exit1.i-55.com ([204.27.97.1]:6080 "EHLO exit1.i-55.com")
	by vger.kernel.org with ESMTP id <S129802AbQLNPpL>;
	Thu, 14 Dec 2000 10:45:11 -0500
Message-ID: <3A38E509.1030402@i-55.com>
Date: Thu, 14 Dec 2000 09:19:37 -0600
From: Leslie Donaldson <donaldlf@i-55.com>
User-Agent: Mozilla/5.0 (Windows; U; Win98; en-US; m18) Gecko/20001010
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org, donaldlf@i-55.com
Subject: Major Failure  2.4.0-test12 Alpha
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,
  Just writing in to report a bug in 2.4.0-test12.
Hardware:
  PCI-Matrox_Mill
  PCI-Adaptec 39160 / 160M scsi card
  PCI-Generic TNT-2 card
  PCI-Sound blaster -128 (es1370)

CPU 21164a - Alpha

Problem:
  There is a race condition in the aic7xxxx driver that causes the 
kernel to lock up.
I don't have a kernel dump yet as the machine reported by it'self..
This problem has been easy to reproduce. ergo about 3 crashes a day.

Solution:
  Sync often and pray.

Misc:
  As soon as I get a real dump I will post a followup to this message.

Leslie Donaldson

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
