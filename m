Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262202AbSJKXun>; Fri, 11 Oct 2002 19:50:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262255AbSJKXun>; Fri, 11 Oct 2002 19:50:43 -0400
Received: from ithilien.qualcomm.com ([129.46.51.59]:30672 "EHLO
	ithilien.qualcomm.com") by vger.kernel.org with ESMTP
	id <S262202AbSJKXum>; Fri, 11 Oct 2002 19:50:42 -0400
Message-Id: <5.1.0.14.2.20021011165518.01bc8f80@mail1.qualcomm.com>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Fri, 11 Oct 2002 16:55:41 -0700
To: Linus Torvalds <torvalds@transmeta.com>
From: "Maksim (Max) Krasnyanskiy" <maxk@qualcomm.com>
Subject: [BK] More Bluetooth 2.5.x updates and fixes
Cc: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Here are some more Bluetooth updates.
         - Bluetooth core is initialized via subsys_initcall()
         - RFCOMM fixes.

Please do a

         bk pull bk://linux-bt.bkbits.net/bt-2.5

This will update the following files:

  include/net/bluetooth/rfcomm.h |    3 +
  net/bluetooth/af_bluetooth.c   |    2 -
  net/bluetooth/rfcomm/core.c    |   71 
+++++++++++++++++++++++++++++++++++++++++
  net/bluetooth/rfcomm/sock.c    |   62 ++++++++++-------------------------
  net/socket.c                   |    8 ----
  5 files changed, 93 insertions(+), 53 deletions(-)

through these ChangeSets:

<maxk@qualcomm.com> (02/10/10 1.740)
    RFCOMM core API extensions. Improved /proc/bluetooth/rfcomm format.
    RFCOMM socket locking fixes.
    Fix typo in rfcomm_pi() macro, no more oopses on socket destruction.

<maxk@qualcomm.com> (02/10/10 1.739)
    Initialize Bluetooth core using subsys_initcall().

Thanks

Max

http://bluez.sf.net
http://vtun.sf.net

