Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274368AbRJaWM2>; Wed, 31 Oct 2001 17:12:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274248AbRJaWMT>; Wed, 31 Oct 2001 17:12:19 -0500
Received: from 216-239-45-7.google.com ([216.239.45.7]:10000 "EHLO
	corp.google.com") by vger.kernel.org with ESMTP id <S274299AbRJaWMC>;
	Wed, 31 Oct 2001 17:12:02 -0500
Message-ID: <3BE07730.60905@google.com>
Date: Wed, 31 Oct 2001 14:12:00 -0800
From: Ben Smith <ben@google.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.5) Gecko/20011012
X-Accept-Language: en-us
MIME-Version: 1.0
To: Daniel Phillips <phillips@bonn-fries.net>
CC: Andrea Arcangeli <andrea@suse.de>, linux-kernel@vger.kernel.org,
        Rik van Riel <riel@conectiva.com.br>
Subject: Re: Google's mm problem - not reproduced on 2.4.13
In-Reply-To: <E15yzlQ-00021P-00@starship.berlin> <E15z28m-0000vb-00@starship.berlin> <20011031214540.D1291@athlon.random> <E15z2WJ-0000wc-00@starship.berlin>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 > On October 31, 2001 09:45 pm, Andrea Arcangeli wrote:
 >
 >>On Wed, Oct 31, 2001 at 09:39:12PM +0100, Daniel Phillips wrote:
 >>
 >>>On October 31, 2001 07:06 pm, Daniel Phillips wrote:
 >>>
 >>>>I just tried your test program with 2.4.13, 2 Gig, and it ran
 >>>>without problems.  Could you try that over there and see if you
 >>>>get the same result?  If it does run, the next move would be to
 >>>>check with 3.5 Gig.
 >>>>
 >>>Ben reports that his test with 2 Gig memory runs fine, as it does
 >>>for me, but that it locks up tight with 3.5 Gig, requiring power
 >>>cycle.  Since I only have 2 Gig here I can't reproduce that (yet).
 >>>
 >>are you sure it isn't an oom condition. can you reproduce on
 >>2.4.14pre5aa1? mainline (at least before pre6) could deadlock with
 >>too much mlocked memory.
 >>
 >
 > I don't know, I can't reproduce it here, I don't have enough memory.
 > Ben?

My test application gets killed (I believe by the oom handler). dmesg
complains about a lot of 0-order allocation failures. For this test,
I'm running with 2.4.14pre5aa1, 3.5gb of RAM, 2 PIII 1Ghz.
  - Ben

Ben Smith
Google, Inc

