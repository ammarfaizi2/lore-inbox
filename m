Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288833AbSAUWp4>; Mon, 21 Jan 2002 17:45:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288827AbSAUWpq>; Mon, 21 Jan 2002 17:45:46 -0500
Received: from postoffice.Princeton.EDU ([128.112.129.120]:16550 "EHLO
	Princeton.EDU") by vger.kernel.org with ESMTP id <S288811AbSAUWpg>;
	Mon, 21 Jan 2002 17:45:36 -0500
Subject: IDE patch + Taskfile
From: John Zedlewski <zedlwski@Princeton.EDU>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0 (Preview Release)
Date: 21 Jan 2002 17:46:13 -0500
Message-Id: <1011653173.1901.2.camel@zedlwski.student.princeton.edu>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Like everybody else, I wanted to chime in about my happiness with the
IDE patch (I'm using it via the 2.4.18-pre3-mjc patch collection). Works
beautifully on my laptop with an IBM Travelstar (DJSA-220) and an
IDE-interface IBM microdrive (via a compactflash adapter).

But I also wanted to REALLY thank Andre and friends for the new TASKFILE
ioctl. I'm doing a lot of low-level performance testing on the
Microdrive and the old ioctl interface was completely inadequate. For
instance, several of the CFA_* IDE commands were unusable from userspace
before taskfile came along and now they're a snap... 

Thanks again!
--JRZ

