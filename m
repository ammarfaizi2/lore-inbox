Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131146AbQKDDEi>; Fri, 3 Nov 2000 22:04:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130370AbQKDDE2>; Fri, 3 Nov 2000 22:04:28 -0500
Received: from vega.services.brown.edu ([128.148.19.202]:18344 "EHLO
	vega.brown.edu") by vger.kernel.org with ESMTP id <S131146AbQKDDEP>;
	Fri, 3 Nov 2000 22:04:15 -0500
Message-Id: <4.3.2.7.2.20001103220425.00a813e0@postoffice.brown.edu>
X-Mailer: QUALCOMM Windows Eudora Version 4.3.2
Date: Fri, 03 Nov 2000 22:06:51 -0500
To: linux-kernel@vger.kernel.org
From: David Feuer <David_Feuer@brown.edu>
Subject: Re: Can EINTR be handled the way BSD handles it? -- a plea
  from a user-land programmer...
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I seem to recall when reading about sigaction in APUE, that while sigaction 
solves many of the races that can come up with various "signal" 
implementations, there were still some cases where there was no way to do 
what was desired without races.  Is there ANY way (in theory, at least) to 
create a race-free signalling system?

--
This message has been brought to you by the letter alpha and the number pi.
David Feuer
David_Feuer@brown.edu

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
