Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129904AbRAHSqk>; Mon, 8 Jan 2001 13:46:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130164AbRAHSqa>; Mon, 8 Jan 2001 13:46:30 -0500
Received: from f183.law8.hotmail.com ([216.33.241.183]:45323 "EHLO hotmail.com")
	by vger.kernel.org with ESMTP id <S129904AbRAHSqL>;
	Mon, 8 Jan 2001 13:46:11 -0500
X-Originating-IP: [170.148.65.7]
From: "Jason Perlow" <perlow@hotmail.com>
To: ilh@sls.lcs.mit.edu
Cc: linux-kernel@vger.kernel.org
Subject: Re: Adaptec 19160 Problems
Date: Mon, 08 Jan 2001 18:46:05 
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
Message-ID: <F183mdkSNZaayx7vd8Z00011efe@hotmail.com>
X-OriginalArrivalTime: 08 Jan 2001 18:46:05.0597 (UTC) FILETIME=[41BDECD0:01C079A3]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ouch, thats an ugly solution.

But why would it be the installer routine as opposed to some wackyness in 
the adaptec module? The kernel used in the installer routines for most of 
these distros is the same kernel used to boot the installed OS, right?

How would you go about copying the IDE disk image anyways? With ghost?


From: I Lee Hetherington <ilh@sls.lcs.mit.edu>
To: Jason Perlow <perlow@hotmail.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Adaptec 19160 Problems
Date: Mon, 08 Jan 2001 13:39:37 -0500

I had the exact same problem.  I ended up getting around it by
installing a Linux image from another machine.  2.2.18 works fine on the
machine, but Red Hat 6.2's install would not reliably get past the
infinite reset stage.

So, there is hope that once you get something new enough on the machine
you'll be in business.  You ought to be able to copy your working
IDE disk image to the SCSI disk, and with a new enough kernel boot the
SCSI disk.

--Lee Hetherington



_________________________________________________________________
Get your FREE download of MSN Explorer at http://explorer.msn.com

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
