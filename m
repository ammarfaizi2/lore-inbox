Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264443AbTCXWD6>; Mon, 24 Mar 2003 17:03:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264447AbTCXWD6>; Mon, 24 Mar 2003 17:03:58 -0500
Received: from e32.co.us.ibm.com ([32.97.110.130]:23707 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S264443AbTCXWDY>; Mon, 24 Mar 2003 17:03:24 -0500
Date: Mon, 24 Mar 2003 14:04:30 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Larry McVoy <lm@bitmover.com>, Andrew Morton <akpm@digeo.com>
cc: venkatesh.pallipadi@intel.com, linux-kernel@vger.kernel.org,
       torvalds@transmeta.com
Subject: Re: lmbench results for 2.4 and 2.5 -- updated results
Message-ID: <546310000.1048543470@flay>
In-Reply-To: <20030324220435.GA11421@work.bitmover.com>
References: <C8C38546F90ABF408A5961FC01FDBF19010485F1@fmsmsx405.fm.intel.com> <20030324200105.GA5522@work.bitmover.com> <543480000.1048540161@flay> <20030324153602.28b44e23.akpm@digeo.com> <20030324220435.GA11421@work.bitmover.com>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> > I presume it does 100 iterations of a test (like fork latency?). Or does 
>> > it just do one? Can I make it do 1,000,000 iterations or something
>> > fairly easily ? ;-) I didn't really look closely, just apt-get install
>> > lmbench ... 
>> 
>> Yes, that is something I've wanted several times.  Just a way to say "run
>> this test for ever so I can profile the thing".
>> 
>> Even a sleazy environment string would suffice.
> 
> It's been there, I suppose you need to read the source to figure it out
> though the lmbench script also plays with this I believe.

Yay! Thank you.
 
> work ~/LMbench2/bin/i686-pc-linux-gnu ENOUGH=1000000 time bw_pipe
> Pipe bandwidth: 655.37 MB/sec
> real    0m23.411s
> user    0m0.480s
> sys     0m1.180s
> 
> work ~/LMbench2/bin/i686-pc-linux-gnu time bw_pipe
> Pipe bandwidth: 809.81 MB/sec
> 
> real    0m2.821s
> user    0m0.480s
> sys     0m1.180s

Mmmm. Any idea why the results are so dramtically different? 655 vs 809?
Looks odd ;-)

m.

