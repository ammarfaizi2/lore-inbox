Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317366AbSGJEpn>; Wed, 10 Jul 2002 00:45:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317377AbSGJEpm>; Wed, 10 Jul 2002 00:45:42 -0400
Received: from mta11.srv.hcvlny.cv.net ([167.206.5.46]:61126 "EHLO
	mta11.srv.hcvlny.cv.net") by vger.kernel.org with ESMTP
	id <S317366AbSGJEpm>; Wed, 10 Jul 2002 00:45:42 -0400
Date: Tue, 09 Jul 2002 20:37:46 -0400
From: Bill Darrow <bdarrow@optonline.net>
Subject: SIS645DX/SIS5513
To: linux-kernel@vger.kernel.org
Message-id: <20020709203746.49198f6a.bdarrow@optonline.net>
MIME-version: 1.0
X-Mailer: Sylpheed version 0.7.8 (GTK+ 1.2.10; i386-debian-linux-gnu)
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I recently aquired a motherboard with a SIS645DX northbridge and a SIS961B southbridge which has an IDE controller in the SIS5513 family...

    IDE interface: Silicon Integrated Systems [SiS] 5513 [IDE] (rev 208).

There appears to be support for the SiS ide controllers in sis5513.c however there only appears to be support for the 645 and not the 645dx.  I can still use my IDE controller but device read timings on ATA133 harddrives show that they can only put out about 3M/sec which isn't acceptable.  Does anyone know of any support for the 645dx/5513 combo (961B)?  Or does anyone know a way I can make a quick hack on sis5513.c so that I can support my controller, even if its not to its fullest potential?  

Thankyou in advance,
Bill
