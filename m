Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271975AbRIDNuZ>; Tue, 4 Sep 2001 09:50:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271976AbRIDNuP>; Tue, 4 Sep 2001 09:50:15 -0400
Received: from hera.cwi.nl ([192.16.191.8]:50887 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id <S271975AbRIDNuB>;
	Tue, 4 Sep 2001 09:50:01 -0400
From: Andries.Brouwer@cwi.nl
Date: Tue, 4 Sep 2001 13:50:18 GMT
Message-Id: <200109041350.NAA56312@vlet.cwi.nl>
To: Andries.Brouwer@cwi.nl, bcrl@redhat.com
Subject: Re: [resend PATCH] reserve BLKGETSIZE64 ioctl
Cc: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> Soon we'll all need a BLKGETSIZE64 ioctl, that gives
>> the size of a block device in bytes.

> I'd accepted that suggestion

Then I am happy (as long as you don't take a reserved number).

Concerning policy, of course that is up to Linus -
for myself I would prefer adding a well-motivated ioctl
above reserving a number. After all, an ioctl is almost
always about transporting some small amount of information,
hence is implemented by a dozen lines of code or so,
clean, and without impact on the rest of the kernel,
so if it is going to be added eventually it might as well
be added immediately.

So, until Linus says otherwise, you might try once or twice
to submit the actual ioctl instead of just the reservation.

Andries

