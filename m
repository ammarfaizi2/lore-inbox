Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287676AbSAMACq>; Sat, 12 Jan 2002 19:02:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287875AbSAMACj>; Sat, 12 Jan 2002 19:02:39 -0500
Received: from flrtn-4-m1-156.vnnyca.adelphia.net ([24.55.69.156]:24960 "EHLO
	jyro.mirai.cx") by vger.kernel.org with ESMTP id <S287868AbSAMACc>;
	Sat, 12 Jan 2002 19:02:32 -0500
Message-ID: <3C40CE82.4030301@pobox.com>
Date: Sat, 12 Jan 2002 16:02:10 -0800
From: J Sloan <jjs@pobox.com>
Organization: J S Concepts
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.7) Gecko/20011221
X-Accept-Language: en-us
MIME-Version: 1.0
To: Robert Love <rml@tech9.net>
CC: Kenneth Johansson <ken@canit.se>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        arjan@fenrus.demon.nl, Rob Landley <landley@trommello.org>,
        linux-kernel@vger.kernel.org, Andrew Morton <akpm@zip.com.au>
Subject: Re: [2.4.17/18pre] VM and swap - it's really unusable
In-Reply-To: <E16PURC-000321-00@the-village.bc.nu> 	<3C409E3C.A4968CE@canit.se> <1010876470.3560.0.camel@phantasy>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Robert Love wrote:

>Agreed.  Further, you can't put _any_ upper bound on the number of interrupts that could occur, preempt or not.  Sure, preempt can make it worse, but I don't see it. I have no bug reports to correlate.
>

OTOH we do have a pile of user reports which
say the low latency patches give better results.

 From my view here, low latency provides a more
silky feel when e.g. playing RtCW or Q3A -

BTW I have checked out 2.4.18pre2-aa2 and
am now running 2.4.18-pre3 + mini low latency.

* -aa absolutely kicks major booty in benchmarks.

* -mini-low-latency seems to do no worse than
stock kernel benchmark-wise, but seems to be
somehow smoother. I played some mp3s while
running dbench 16 and heard no hitches. Also
the RtCW test was successful, e.g. movement
was fluid and I was victorious in most skirmishes
with win32 opponents.

Regards,

jjs



