Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262788AbTCJI4h>; Mon, 10 Mar 2003 03:56:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262791AbTCJI4h>; Mon, 10 Mar 2003 03:56:37 -0500
Received: from d12lmsgate-3.de.ibm.com ([194.196.100.236]:27882 "EHLO
	d12lmsgate-3.de.ibm.com") by vger.kernel.org with ESMTP
	id <S262788AbTCJI4g>; Mon, 10 Mar 2003 03:56:36 -0500
Importance: Normal
Sensitivity: 
Subject: Re: Fwd: [PATCH] s390 (1/7): s390 arch fixes.
To: Pete Zaitcev <zaitcev@redhat.com>
Cc: linux-kernel@vger.kernel.org
X-Mailer: Lotus Notes Release 5.0.8  June 18, 2001
Message-ID: <OF4904DE89.B60C22D4-ONC1256CE5.00311D21@de.ibm.com>
From: "Martin Schwidefsky" <schwidefsky@de.ibm.com>
Date: Mon, 10 Mar 2003 10:05:41 +0100
X-MIMETrack: Serialize by Router on D12ML016/12/M/IBM(Release 5.0.9a |January 7, 2002) at
 10/03/2003 10:06:58
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> This is a good fix, I confirm it fixing my booting problem ...
> on 2.4! Seriously, I can't believe it worked before.
> Please send it to Marcelo, too.

Well, the POP states under "Initial CPU Reset":
2. The contents of the current PSW, prefix, CPU
   timer, clock comparator, and TOD programmable
   register are set to zero.

The fix should be necessary but it fixed some boot
problems for me as well ...

This fix is already in patch-2.4.21-pre5.

blue skies,
   Martin


