Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129742AbRAHSj7>; Mon, 8 Jan 2001 13:39:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130070AbRAHSjt>; Mon, 8 Jan 2001 13:39:49 -0500
Received: from sls.lcs.mit.edu ([18.27.0.167]:34554 "EHLO sls.lcs.mit.edu")
	by vger.kernel.org with ESMTP id <S129742AbRAHSjo>;
	Mon, 8 Jan 2001 13:39:44 -0500
Message-ID: <3A5A0969.886898AA@sls.lcs.mit.edu>
Date: Mon, 08 Jan 2001 13:39:37 -0500
From: I Lee Hetherington <ilh@sls.lcs.mit.edu>
Organization: MIT Laboratory for Computer Science
X-Mailer: Mozilla 4.73 [en] (X11; U; Linux 2.2.18-pre25.1.smp i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Jason Perlow <perlow@hotmail.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Adaptec 19160 Problems
In-Reply-To: <F4USqo3X17UvgB7grec0001145c@hotmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I had the exact same problem.  I ended up getting around it by
installing a Linux image from another machine.  2.2.18 works fine on the
machine, but Red Hat 6.2's install would not reliably get past the
infinite reset stage.

So, there is hope that once you get something new enough on the machine
you'll be in business.  You ought to be able to copy your working
IDE disk image to the SCSI disk, and with a new enough kernel boot the
SCSI disk.

--Lee Hetherington


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
