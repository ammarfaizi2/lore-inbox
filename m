Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266622AbTGYCFs (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Jul 2003 22:05:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269354AbTGYCFs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Jul 2003 22:05:48 -0400
Received: from bgp01360964bgs.sandia01.nm.comcast.net ([68.35.68.128]:37249
	"EHLO orion.dwf.com") by vger.kernel.org with ESMTP id S266622AbTGYCFr
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Jul 2003 22:05:47 -0400
Message-Id: <200307250220.h6P2Ku33005334@orion.dwf.com>
X-Mailer: exmh version 2.6.3 04/04/2003 with nmh-1.0.4
To: linux-kernel@vger.kernel.org
Subject: 2.4.21, 2.6.0-test1 dont see disk controller.
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Thu, 24 Jul 2003 20:20:55 -0600
From: reg@dwf.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have one disk (containing the root partition) on the disk controller
on the motherboard, and a second disk on its own PCI (IDE) controller
  [ Promise Tech Chp, ATA 133 ]

Under 2.4.19 and 2.4.20 everything worked as soon as I plugged in the
card to the motherboard.

With either 2.4.21 or 2.6.0-test1, the OS doesnt seem to see the controller,
(no error messages), and you get down to a point where you are trying to
mount the disk partitions, and you get error messages saying /dev/hde does
not exist.

What changed?
Do I need an additional config line of some sort (Ive looked but dont see
anything?)
More details if necessary.
-- 
                                        Reg.Clemens
                                        reg@dwf.com


