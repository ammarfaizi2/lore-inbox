Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262179AbTFJT1p (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jun 2003 15:27:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262192AbTFJT0a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jun 2003 15:26:30 -0400
Received: from web0.speakeasy.net ([216.254.0.11]:48814 "EHLO
	imail.speakeasy.net") by vger.kernel.org with ESMTP id S262179AbTFJTZx
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jun 2003 15:25:53 -0400
Date: Tue, 10 Jun 2003 12:39:33 -0700 (PDT)
From: sydow@speakeasy.net
To: linux-kernel@vger.kernel.org
Subject: PROBLEM: Kernel Panic Promise driver
Message-ID: <Pine.LNX.4.44.0306101221370.1648-100000@web0.speakeasy.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

1. Kernel Panic with Supertrak SX6000 when Promise PDC20268-77 driver 
loads

2. With PROMISE PDC202{68|69|70|71|75|76|77} support from IDE, ATA and 
ATAPI Block devices is compiled in the kernel and a Promise Supertrak 
SX6000 present in the system a Kernel Panic will happen. The panic happens 
while the kernel is booting and immediately after the Promise PDC driver 
mentioned above loads. The Supertrak is running in I2O mode.

3. keywords PROMISE SUPERTRAK PDC202

4. Kernel Version 2.4.21-rc7

No current OS installed as this was from a boot disk to install.
This is in a Tyan S2462 THunder K7 board, with dual Athlon 1.2Mhz MPs and 
1GB of memory. I have removed the Promise PDC support and added i2o and 
the kernel boots fine. Expected behavior would be to use or have this 
promise support in kernel and not to have it panic the kernel by trying to 
initialize the SX6000 with the software raid drivers. This is a rare 
(expensive) peice of hardware so you can contact me for testing if need be.

-- 

Donovan Sydow
Information Systems Lead
SPEAKEASY.net

"One World, One Web, One Program" - Microsoft promotional ad.
"Ein Volk, Ein Reich, Ein Führer" (One People, One Kingdom, One Leader) 
- Adolph Hitler.



