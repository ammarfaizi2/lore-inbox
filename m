Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131142AbQLNIpf>; Thu, 14 Dec 2000 03:45:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131502AbQLNIpQ>; Thu, 14 Dec 2000 03:45:16 -0500
Received: from [213.8.185.216] ([213.8.185.216]:6404 "EHLO callisto.yi.org")
	by vger.kernel.org with ESMTP id <S131142AbQLNIpG>;
	Thu, 14 Dec 2000 03:45:06 -0500
Date: Thu, 14 Dec 2000 10:09:40 +0200 (IST)
From: Dan Aloni <karrde@callisto.yi.org>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: More on the test12 lockups [Or: test12's arch/i386 changes)
Message-ID: <Pine.LNX.4.21.0012140955500.2808-100000@callisto.yi.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I've also been experiencing lockups and oopses since upgrading to
test12 from test11. 

These were very lengthy oops messages during the init script, following
immediate lockups (or shortly after running X), which printed "Aiee,
killing interrupt handler" at the end.

test11 doesn't show these symptoms here.

I've tried to isolate the changes that were made between test11 and
test12 and I've discovered that if I drop all the arch/i386/* changes, the
test12 kernel turns stable again! I'm using it right now, so if it
doesn't lockup in the next 24 hours, then it's probably right.

-- 
Dan Aloni 
dax@karrde.org

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
