Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270640AbRIAMlP>; Sat, 1 Sep 2001 08:41:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270649AbRIAMlH>; Sat, 1 Sep 2001 08:41:07 -0400
Received: from gecius-0.dsl.speakeasy.net ([216.254.67.146]:3314 "EHLO
	maniac.gecius.de") by vger.kernel.org with ESMTP id <S270640AbRIAMky>;
	Sat, 1 Sep 2001 08:40:54 -0400
To: linux-kernel@vger.kernel.org
Subject: ide problem on 2.2.17?
From: Jens Gecius <jens@gecius.de>
Date: 01 Sep 2001 08:41:13 -0400
Message-ID: <874rqnf5hy.fsf@maniac.gecius.de>
User-Agent: Gnus/5.090003 (Oort Gnus v0.03) XEmacs/21.4 (Artificial Intelligence)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi folks!

Recently, my stock debian potato system (2.2.17) sent me a whole bunch
of messages. I don't really get the meaning of them, so might be one
of you guys has an idea:

Sep  1 02:07:46 torriac kernel: attempt to access beyond end of device
Sep  1 02:07:46 torriac kernel: 03:02: rw=0, want=8421508, limit=779152
Sep  1 02:07:46 torriac kernel: dev 03:02 blksize=4096 blocknr=538976288 sector=16843008 size=4096 count=1
Sep  1 02:07:46 torriac kernel: attempt to access beyond end of device
Sep  1 02:07:46 torriac kernel: 03:02: rw=0, want=1283506308, limit=779152
Sep  1 02:07:46 torriac kernel: dev 03:02 blksize=4096 blocknr=1394618400 sector=-1727954688 size=4096 count=1
Sep  1 02:07:46 torriac kernel: attempt to access beyond end of device
Sep  1 02:07:46 torriac kernel: 03:02: rw=0, want=75616648, limit=779152
Sep  1 02:07:46 torriac kernel: dev 03:02 blksize=4096 blocknr=1092645985 sector=151233288 size=4096 count=1
Sep  1 02:07:46 torriac kernel: attempt to access beyond end of device
Sep  1 02:07:46 torriac kernel: 03:02: rw=0, want=1149356484, limit=779152
Sep  1 02:07:46 torriac kernel: dev 03:02 blksize=4096 blocknr=824210032 sector=-1996254336 size=4096 count=1

What is going on?? I found something for older 2.2 kernels (broken ide
driver), but 2.2.17?

Does this cause problems accessing certain files (because my apache
doesn't find any htpasswd-files for limited access on certain pages)?

-- 
Tschoe,                    Get my gpg-public-key here
 Jens                     http://gecius.de/gpg-key.txt
