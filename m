Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270262AbTGMQNW (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Jul 2003 12:13:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270263AbTGMQNW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Jul 2003 12:13:22 -0400
Received: from remt29.cluster1.charter.net ([209.225.8.39]:27827 "EHLO
	remt29.cluster1.charter.net") by vger.kernel.org with ESMTP
	id S270262AbTGMQNP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Jul 2003 12:13:15 -0400
From: Chris Morgan <cmorgan@alum.wpi.edu>
To: linux-kernel@vger.kernel.org
Subject: 2.5.XX very sluggish
Date: Sun, 13 Jul 2003 12:28:00 -0400
User-Agent: KMail/1.5.2
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200307131228.00155.cmorgan@alum.wpi.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

1.4Ghz Athlon via 82cxx chipset, software raid 1 scsi drives, currently 
running 2.4.21

With 2.5.73/74/75(the only ones I've tried thus far) the kernel boots fine 
until it tries to mount the reiserfs partition on the raid1 set.  Replaying 
the journal takes many times longer than with 2.4.  Once it gets past that 
point the whole machine appears to be quite sluggish.  Is this a known issue 
with reiserfs + software raid 1?  What information would be useful to aid in 
debugging?

I have smp disabled, preemption enabled, tried with generic x86 
disabled/enabled.

Thanks,
Chris


Please cc me on replies, I'm not on the list yet.

