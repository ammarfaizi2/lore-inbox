Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131412AbRCKMaG>; Sun, 11 Mar 2001 07:30:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131405AbRCKM3q>; Sun, 11 Mar 2001 07:29:46 -0500
Received: from atlante.atlas-iap.es ([194.224.1.3]:47367 "EHLO
	atlante.atlas-iap.es") by vger.kernel.org with ESMTP
	id <S131408AbRCKM3l>; Sun, 11 Mar 2001 07:29:41 -0500
From: "Ricardo Galli" <gallir@uib.es>
To: <linux-kernel@vger.kernel.org>
Subject: Kernel panic in 2.2.18 and SMP
Date: Sun, 11 Mar 2001 13:28:53 +0100
Message-ID: <LOEGIBFACGNBNCDJMJMOKEPECFAA.gallir@uib.es>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2911.0)
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4522.1200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I just upgraded from 2.2.16 to 2.2.18 in a production machine. The machine
dies after few minutes with the following error message (it's not complete,
the machine was rebooted by a colleague of mine):


Kernel panic
Exception.
Context corruption at bank 0

The motherboard is a RD440LX DP, with adapted 2940, 3com905, mtrr enabled,
ioapic enabled.
We've tried several times with the same kernel and we've got the same
problem after a couple of minutes. Sometimes the machine was completely
blocked, even ping didn't work, others ping was ok but everythng else was
down. Sysrq couldn't sync nor unmount disks.

We went down to 2.2.16 and everything it's ok.

Hope this helps.

Regards,

--ricardo
http://m3d.uib.es/~gallir/

