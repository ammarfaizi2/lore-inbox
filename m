Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292917AbSCJJO5>; Sun, 10 Mar 2002 04:14:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292924AbSCJJOh>; Sun, 10 Mar 2002 04:14:37 -0500
Received: from 99dyn73.com21.casema.net ([62.234.30.73]:57768 "EHLO
	abraracourcix.bitwizard.nl") by vger.kernel.org with ESMTP
	id <S292917AbSCJJOc>; Sun, 10 Mar 2002 04:14:32 -0500
Message-Id: <200203100914.KAA14394@cave.bitwizard.nl>
Subject: RAID magics gone... 
To: linux-kernel@vger.kernel.org
Date: Sun, 10 Mar 2002 10:14:30 +0100 (MET)
From: R.E.Wolff@BitWizard.nl (Rogier Wolff)
X-notice1: This Email contains my Email address. This grants you the right
X-notice2: to communicate with me using this address, related to the subject
X-notice3: in this message. Unsollicitated mass-mailings are explictly 
X-notice4: forbidden here, and by Dutch law. 
X-Mailer: ELM [version 2.4ME+ PL60 (25)]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

I have a machine with 4 160G disks in a raid-0 configuration. Now
after upgrading the hardware, all of a sudden raidstart can't find the
raid-superblocks anymore. Invalid magic. 

I'm suspecting that it might be that the superblock was overwritten
with data or something like that. Does anybody know of a bug like
this?

We're running kernel-2.4.16 with andre's IDE patches for the large
disks.

I'll see if I can find the "magic" anywhere on the disk....

				Roger. 
-- 
** R.E.Wolff@BitWizard.nl ** http://www.BitWizard.nl/ ** +31-15-2137555 **
*-- BitWizard writes Linux device drivers for any device you may have! --*
* There are old pilots, and there are bold pilots. 
* There are also old, bald pilots. 
