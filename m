Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132964AbRAFVKY>; Sat, 6 Jan 2001 16:10:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132975AbRAFVKP>; Sat, 6 Jan 2001 16:10:15 -0500
Received: from senf.hammerschmid.com ([195.70.243.25]:64516 "EHLO
	hammerschmid.com") by vger.kernel.org with ESMTP id <S132964AbRAFVJ6>;
	Sat, 6 Jan 2001 16:09:58 -0500
Message-ID: <3A5789A1.34526AD1@hammerschmid.com>
Date: Sat, 06 Jan 2001 22:09:53 +0100
From: Martin Hammerschmid <martin@hammerschmid.com>
X-Mailer: Mozilla 4.74 [en] (X11; U; Linux 2.2.17 i686)
X-Accept-Language: en, de
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: neither 2.2.18 nor 2.4.0 boot on my Cyrix III
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm not subscribed to the list but I want to report this problem:

I found this in the kernel mailing list archive :

> The cyrixIII chips by via have the centaur vendor id which causes the 
> identify_cpu call in arch/i386/kernel/setup.c to fail. It is probably 
> reasonable for it to have the centaur id as via owns centaur as well. I 
> just replaced the centaur_model call with the cyrix_model one, but I 
> know that I am using a cyrix chip. 
> 
> A test probably needs to be added in the centaur_model section to test 
> for the cyrixIII in disguise. 
> 
> The error is a general protection fault. 

I had the same problem as described above with 2.2.18 and 2.4.0 
(2.2.17 boots without any problems)
I changed setup.c as suggested in this post and was able to boot both
(2.2.18 and 2.4.0).
I don't have any kernel knowledge but I'm willing to test something on
my box if 
anyone is interested in solving this problem.

(via Cyrix III on a Aopen mx3s board (i815))

TIA

Martin Hammerschmid
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
