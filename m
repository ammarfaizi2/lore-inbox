Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932287AbWEWVOb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932287AbWEWVOb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 May 2006 17:14:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932286AbWEWVOb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 May 2006 17:14:31 -0400
Received: from www.hutor.net ([62.16.86.209]:13580 "EHLO hutor.localdomain")
	by vger.kernel.org with ESMTP id S932274AbWEWVOa convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 May 2006 17:14:30 -0400
Date: Wed, 24 May 2006 01:15:00 +0400
From: =?windows-1251?Q?=C0=EB=E5=EA=F1=E0=ED=E4=F0_=D1=E0=E4=EA=EE=E2?= 
	<saalan@hutor.net>
X-Mailer: The Bat! (v3.60.07) Professional
Reply-To: =?windows-1251?Q?=C0=EB=E5=EA=F1=E0=ED=E4=F0_=D1=E0=E4=EA=EE=E2?= 
	  <saalan@hutor.net>
Organization: =?windows-1251?Q?=CE=CE=CE_=22=C6=E8=EB-=D2=E5=EB=E5=EA=EE=EC=22?=
X-Priority: 3 (Normal)
Message-ID: <1426349061.20060524011500@hutor.net>
To: linux-kernel@vger.kernel.org
Subject: problem of module SX8
MIME-Version: 1.0
Content-Type: text/plain; charset=windows-1251
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello.
I wish to inform on a problem of module SX8 in kernels 2.6.15SMP and 2.6.16SMP.

Hardware:
SuperMicro 370DLE, 2xIntel PIII800EB
Promise SATAII150 SX8 (latest firmware 1.00.0.37, Command Query – Disabled)
System HDD - Western Digital WD1500ADFD (SATA)
Data HDD – 4 x Seagate Barracuda 7200.9 ST3500641AS (SATA)

The equipment was tested under Windows XP in various modes.
All perfectly worked except that it Windows...

In Linux FC5 (all updates) kernel 2.6.15SMP or  2.6.16SMP the system behaved as follows:

If to connect only system HDD Western Digital that all works, but I periodically receive messages of type:
cell kernel: end_request: I/O error, dev sx8/0, sector 220064
cell kernel: Buffer I/O error on device sx8/0, logical block 27508

If to connect all HDD it quickly enough leads to lag of one, several or all HDD connected to SX8.
The system does not give out any mistakes, any command leads to freezing of the console, helps only reset.

Following recommendations, I have tried to transfer module SX8 parameter max_queue = 30. 
During loading the system has destroyed root file system. 

Having restored with Backup, I tried to establish max_queue = 2, that also have destroyed root file system.

I am sorry for bad English.


