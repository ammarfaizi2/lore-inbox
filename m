Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267659AbTBXSim>; Mon, 24 Feb 2003 13:38:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267322AbTBXSVo>; Mon, 24 Feb 2003 13:21:44 -0500
Received: from e31.co.us.ibm.com ([32.97.110.129]:29912 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S265773AbTBXSKr>; Mon, 24 Feb 2003 13:10:47 -0500
To: yodaiken@fsmlabs.com
cc: Benjamin LaHaise <bcrl@redhat.com>, Larry McVoy <lm@work.bitmover.com>,
       William Lee Irwin III <wli@holomorphy.com>,
       "Martin J. Bligh" <mbligh@aracnet.com>, Larry McVoy <lm@bitmover.com>,
       linux-kernel@vger.kernel.org
Reply-To: Gerrit Huizenga <gh@us.ibm.com>
From: Gerrit Huizenga <gh@us.ibm.com>
Subject: Re: Minutes from Feb 21 LSE Call 
In-reply-to: Your message of Mon, 24 Feb 2003 09:25:33 MST.
             <20030224092533.B11805@hq.fsmlabs.com> 
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <11849.1046110837.1@us.ibm.com>
Date: Mon, 24 Feb 2003 10:20:37 -0800
Message-Id: <E18nNDR-00035B-00@w-gerrit2>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 24 Feb 2003 09:25:33 MST, yodaiken@fsmlabs.com wrote:
> It's interesting to me that the people supporting the scale up do not 
> carefully do such benchmarks and indeed have a rather cavilier attitude
> to testing and benchmarking: or perhaps they don't think it's worth 
> publishing. 

I'm afraid it is the latter half that is closer to correct.  Within
IBM's Linux Technology Center, we have a good sized performance team
and a tightly coupled set of developers who can internally share a
lot of real benchmark data.  Unfortunately, the rules of SPEC and TPC
don't allow us to release data unless it is carefully (and time-
consumingly) audited, and IBM has a history of not dumping the output
of a few hundred runs of benchmarks out in the open and then claiming
that it is all valid, without doing a lot of internal validation first.

I'm sure other large companies doing Linux stuff have similar hurdles.
In some cases, ours are probably higher than average (IBM as an
entity has zero interest in pissing of the TPC or SPEC).

We do have a few papers out there, check OLS for the large database
workload one that steps through 2.4 performance changes (stock
2.4 vs. a set of patches we pushed to UL & RHAT) that increase
database performance about, oh, I forget, 5-fold...  And there
is occasional other data sent out on web server stuff, some
microbenchmark data (see the continuing stream of data from mbligh,
for instance).  Also, the contest data, OSDL data, etc. etc.
shows comparisons and trends for anyone who cares to pay attention.

It *would* be nice if someone could publish a compedium of performance
data, but that would be asking a lot...

gerrit
