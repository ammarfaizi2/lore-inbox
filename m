Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269086AbTBXCWn>; Sun, 23 Feb 2003 21:22:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269087AbTBXCWn>; Sun, 23 Feb 2003 21:22:43 -0500
Received: from palrel12.hp.com ([156.153.255.237]:12268 "EHLO palrel12.hp.com")
	by vger.kernel.org with ESMTP id <S269086AbTBXCWl>;
	Sun, 23 Feb 2003 21:22:41 -0500
From: David Mosberger <davidm@napali.hpl.hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15961.33856.876529.568807@napali.hpl.hp.com>
Date: Sun, 23 Feb 2003 18:32:32 -0800
To: Linus Torvalds <torvalds@transmeta.com>
Cc: davidm@hpl.hp.com, David Lang <david.lang@digitalinsight.com>,
       <linux-kernel@vger.kernel.org>
Subject: Re: Minutes from Feb 21 LSE Call
In-Reply-To: <Pine.LNX.4.44.0302231634150.1690-100000@home.transmeta.com>
References: <15961.20756.474745.44896@napali.hpl.hp.com>
	<Pine.LNX.4.44.0302231634150.1690-100000@home.transmeta.com>
X-Mailer: VM 7.07 under Emacs 21.2.1
Reply-To: davidm@hpl.hp.com
X-URL: http://www.hpl.hp.com/personal/David_Mosberger/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> On Sun, 23 Feb 2003 16:40:40 -0800 (PST), Linus Torvalds <torvalds@transmeta.com> said:

  Linus> On Sun, 23 Feb 2003, David Mosberger wrote:

  >> 2 GHz Xeon:	701 SPECint
  >> 1 GHz Itanium 2:	810 SPECint

  >> That is, Itanium 2 is 15% faster.

  Linus> Ehh, and this is with how much cache?

  Linus> Last I saw, the Itanium 2 machines came with 3MB of
  Linus> integrated L3 caches, and I suspect that whatever 0.13
  Linus> Itanium numbers you're looking at are with the new 6MB
  Linus> caches.

Unfortunately, HP doesn't sell 1.5MB/1GHz Itanium 2 workstations, but
we can do some educated guessing:

  1GHz Itanium 2, 3MB cache:		810 SPECint
  900MHz Itanium 2, 1.5MB cache:	674 SPECint

Assuming pure frequency scaling, a 1GHz/1.5MB Itanium 2 would get
around 750 SPECint.  In reality, it would get slightly less, but most
likely substantially more than 701.

  Linus> So your "apples to apples" comparison isn't exactly that.

I never claimed it's an apples to apples comparison.  But comparing
same-process chips from the same manufacturer does make for a fairer
"architectural" comparison because it factors out at least some of the
effects caused by volume (there is no reason other than (a) volume and
(b) being designed as a server chip for Itanium chips to come out on
the same process later than the corresponding x86 chips).

  Linus> The only thing that is meaningful is "performace at the same
  Linus> time of general availability".

You claimed that x86 is inherently superior.  I provided data that
shows that much of this apparent superiority is simply an effect of
the larger volume that x86 achieves today.  Please don't claim that
x86 wins on technical grounds when it really wins on economic grounds.

	--david
