Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284361AbRLHTRP>; Sat, 8 Dec 2001 14:17:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284369AbRLHTRG>; Sat, 8 Dec 2001 14:17:06 -0500
Received: from hera.cwi.nl ([192.16.191.8]:745 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id <S284371AbRLHTQy>;
	Sat, 8 Dec 2001 14:16:54 -0500
From: Andries.Brouwer@cwi.nl
Date: Sat, 8 Dec 2001 19:16:50 GMT
Message-Id: <UTC200112081916.TAA258137.aeb@cwi.nl>
To: linux-kernel@vger.kernel.org, zaitcev@redhat.com
Subject: Re: Would the father of init_mem_lth please stand up
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    From: Pete Zaitcev <zaitcev@redhat.com>

    Really someone needs slapping across. What kind of code is that
    (in 2.5.1-pre6):

    drivers/scsi/sd.c:sd_init()

...
    The code is buggy. Scenario:


Yes, you are right, the code is buggy.
It looks like part of something I did a few months ago
for 2.4.6 or so. I tend to give the guarantee "correctness
preserved". So, the conclusion must be that before this
change was applied the code had precisely the same bug.

Andries
