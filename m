Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261399AbSJ1Rrt>; Mon, 28 Oct 2002 12:47:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261430AbSJ1Rrh>; Mon, 28 Oct 2002 12:47:37 -0500
Received: from e2.ny.us.ibm.com ([32.97.182.102]:25835 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S261399AbSJ1Rfm>;
	Mon, 28 Oct 2002 12:35:42 -0500
Date: Mon, 28 Oct 2002 09:36:45 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Erich Focht <efocht@ess.nec.de>
cc: Michael Hohnbaum <hohnbaum@us.ibm.com>, mingo@redhat.com,
       habanero@us.ibm.com, linux-kernel@vger.kernel.org,
       lse-tech@lists.sourceforge.net
Subject: Re: NUMA scheduler  (was: 2.5 merge candidate list 1.5)
Message-ID: <536200000.1035826605@flay>
In-Reply-To: <200210281838.44556.efocht@ess.nec.de>
References: <200210280132.33624.efocht@ess.nec.de> <3129290732.1035737182@[10.10.2.3]> <200210281838.44556.efocht@ess.nec.de>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> Schedbench 4:
>>                              Elapsed   TotalUser    TotalSys     AvgUser
>>               2.5.44-mm4       32.45       49.47      129.86        0.82
>>       2.5.44-mm4-focht-1       38.61       45.15      154.48        1.06
>>       2.5.44-mm4-hbaum-1       37.81       46.44      151.26        0.78
>>      2.5.44-mm4-focht-12       23.23       38.87       92.99        0.85
>>      2.5.44-mm4-hbaum-12       22.26       34.70       89.09        0.70
>>         2.5.44-mm4-f1-h2       21.39       35.97       85.57        0.81
> 
> One more remarks:
> You seem to have made the numa_test shorter. That reduces it to beeing
> simply a check for the initial load balancing as the hackbench running in
> the background (and aimed to disturb the initial load balancing) might
> start too late. You will most probably not see the impact of node affinity
> with such short running tests. But we weren't talking about node affinity,
> yet...

I didn't modify what you sent me at all ... perhaps my machine is
just faster than yours?

/me ducks & runs ;-)

M.

