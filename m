Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131383AbRAPNLw>; Tue, 16 Jan 2001 08:11:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130552AbRAPNLm>; Tue, 16 Jan 2001 08:11:42 -0500
Received: from rcum.uni-mb.si ([164.8.2.10]:9741 "EHLO rcum.uni-mb.si")
	by vger.kernel.org with ESMTP id <S131383AbRAPNLW>;
	Tue, 16 Jan 2001 08:11:22 -0500
Date: Tue, 16 Jan 2001 14:10:32 +0100
From: David Balazic <david.balazic@uni-mb.si>
Subject: devices.txt missing some info about OSS devices
To: "H. Peter Anvin" <device@lanana.org>
Cc: linux-kernel@vger.kernel.org
Message-id: <3A644848.A546FD3A@uni-mb.si>
MIME-version: 1.0
X-Mailer: Mozilla 4.75 [en] (WinNT; U)
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7bit
X-Accept-Language: en
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

The devices.txt file included in recent 2.4.x kernels
and the one at
http://www.lanana.org/docs/device-list/devices.txt

lacks infos about /dev/dspX and /dev/audioX , where
X is 2 or more.

I had to dig into the audio driver sources to figure
out that the minor number is
X * 16 + 3 for /dev/dspX and
X * 16 + 4 for /dev/audioX

-- 
David Balazic
--------------
"Be excellent to each other." - Bill & Ted
- - - - - - - - - - - - - - - - - - - - - -
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
