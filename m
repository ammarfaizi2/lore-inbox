Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129044AbQKEGoQ>; Sun, 5 Nov 2000 01:44:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129098AbQKEGoF>; Sun, 5 Nov 2000 01:44:05 -0500
Received: from vega.services.brown.edu ([128.148.19.202]:34303 "EHLO
	vega.brown.edu") by vger.kernel.org with ESMTP id <S129044AbQKEGn5>;
	Sun, 5 Nov 2000 01:43:57 -0500
Message-Id: <4.3.2.7.2.20001105014402.00adee30@postoffice.brown.edu>
X-Mailer: QUALCOMM Windows Eudora Version 4.3.2
Date: Sun, 05 Nov 2000 01:46:19 -0500
To: linux-kernel@vger.kernel.org
From: David Feuer <David_Feuer@brown.edu>
Subject: Select
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In the discussion on "select bug", some people noted that select does not 
wake up a process until the buffer is half full (or all full, or 
whatever).  Does this mean that if a small amount is written to the 
device/pipe the process may never be woken?  Or is there a time limit that 
wakes up the process after a certain amount of time if there are _any_ 
bytes in the pipe/dev?

--
This message has been brought to you by the letter alpha and the number pi.
David Feuer
David_Feuer@brown.edu

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
