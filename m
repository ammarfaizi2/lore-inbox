Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318189AbSGQBt5>; Tue, 16 Jul 2002 21:49:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318191AbSGQBt4>; Tue, 16 Jul 2002 21:49:56 -0400
Received: from ns2.rotanovs.com ([213.182.202.72]:59144 "HELO
	lemon.rotanovs.com") by vger.kernel.org with SMTP
	id <S318189AbSGQBt4>; Tue, 16 Jul 2002 21:49:56 -0400
Date: Wed, 17 Jul 2002 04:52:36 +0300
From: Viktors Rotanovs <Viktors@Rotanovs.com>
X-Mailer: The Bat! (v1.60m) Personal
Reply-To: Viktors Rotanovs <Viktors@Rotanovs.com>
X-Priority: 3 (Normal)
Message-ID: <9016512704.20020717045236@Rotanovs.com>
To: linux-kernel@vger.kernel.org
Subject: 2.4.18-2.4.19-rc1-ac4 + Promise SX6000 + i2o
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I've found numerious reports that Promise SX6000 works fine with
2.4.18+ kernels, and tried it with 2.4.18 and 2.4.19-rc1-ac4 kernels
with i2o support.

Here are the results:

2.4.18: finds controller, but doesn't find disk device on it.
2.4.19-rc1-ac4: loads i2o_block and i2o_core fine and doesn't load
i2o_pci. When I try to load i2o_pci manually, it shows a lot of
timeouts.

I seem to have PDC20276 chip (if i'm not mistaken) marked as new
by Alan Cox.

OS type on the RAID is set to Other.

When I try to run original driver Promise's driver instead of i2o on
2.4.18, it starts showing SCSI timeouts after some time when working
under heavy load.

I use RAID with ReiserFS.

Thanks for any help and have a nice day!

Best Wishes,
Viktors

