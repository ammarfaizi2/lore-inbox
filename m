Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267362AbRGKRIw>; Wed, 11 Jul 2001 13:08:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267363AbRGKRIm>; Wed, 11 Jul 2001 13:08:42 -0400
Received: from lysithea.xerox.com ([208.140.33.22]:60052 "EHLO
	lysithea.eastgw.xerox.com") by vger.kernel.org with ESMTP
	id <S267362AbRGKRIg>; Wed, 11 Jul 2001 13:08:36 -0400
Message-Id: <200107111708.NAA28600@mailhost.eng.mc.xerox.com>
To: linux-kernel@vger.kernel.org
Subject: PCI_REGION_FLAG_MASK -- what is its meaning?
Date: Wed, 11 Jul 2001 13:08:34 -0400
From: "Marty Leisner" <mleisner@eng.mc.xerox.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I looked at the PCI flags... I wonder where I get
information about the "bus specific bits"

I'm writing a driver for a proprietary PCI device and I'm
seeing:
region 0: address = e0000000, len = 4000000, use = 120c
region 1: address = 0, len = 0, use = 0
region 2: address = df800000, len = 100000, use = 1208
region 3: address = d8000000, len = 4000000, use = 1208
region 4: address = 0, len = 0, use = 0
region 5: address = 0, len = 0, use = 0


(I understand the upper bytes, what is the lower byte's meaning?)


marty		mleisner@eng.mc.xerox.com   
Don't  confuse education with schooling.
	Milton Friedman to Yogi Berra
