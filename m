Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S129257AbQK3UoI>; Thu, 30 Nov 2000 15:44:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S129792AbQK3Un6>; Thu, 30 Nov 2000 15:43:58 -0500
Received: from node10dfe.a2000.nl ([24.132.13.254]:12296 "EHLO
        roswell.home.intercept.cx") by vger.kernel.org with ESMTP
        id <S129257AbQK3Uns>; Thu, 30 Nov 2000 15:43:48 -0500
From: "Jeroen Geusebroek" <Jeroen.Geusebroek@osc.nl>
To: <linux-kernel@vger.kernel.org>
Subject: 2.2.17 & Eepro(10)
Date: Thu, 30 Nov 2000 21:13:32 +0100
Message-ID: <NCBBJKHJIKHIFECNNOAMKEDLDLAA.Jeroen.Geusebroek@osc.nl>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2910.0)
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hello,

I'm having troubles with the eepro driver included in kernel 2.2.17.
It stops sometimes with no apparent reason. The one thing i noticed
is that it seems to have a lot of carrier problems(998!)

This is part of the result from ifconfig:

eth1      Link encap:Ethernet  HWaddr 00:AA:00:A6:05:01  
          inet addr:24.132.xx.xxx  Bcast:24.132.xx.xxx  Mask:255.255.254.0
          UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
          RX packets:248714 errors:0 dropped:0 overruns:0 frame:0
          TX packets:64711 errors:1925 dropped:0 overruns:0 carrier:998
          collisions:832 txqueuelen:100 
          Interrupt:10 Base address:0x230

Needless to say i didn't have this problem with previous kernels
(including 2.2.16).

Is there something changed in the driver for 2.2.17?

Thanks for the help.

Regards,

Jeroen Geusebroek

P.s. please CC me if you reply since i'm not subscribed to the list. 
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
