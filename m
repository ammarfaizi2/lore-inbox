Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285474AbRLGT3j>; Fri, 7 Dec 2001 14:29:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285479AbRLGT3c>; Fri, 7 Dec 2001 14:29:32 -0500
Received: from bitmover.com ([192.132.92.2]:64145 "EHLO bitmover.bitmover.com")
	by vger.kernel.org with ESMTP id <S285474AbRLGT2i>;
	Fri, 7 Dec 2001 14:28:38 -0500
Date: Fri, 7 Dec 2001 11:28:37 -0800
From: Larry McVoy <lm@bitmover.com>
To: Dana Lacoste <dana.lacoste@peregrine.com>
Cc: "'Larry McVoy'" <lm@bitmover.com>,
        "Martin J. Bligh" <Martin.Bligh@us.ibm.com>,
        linux-kernel@vger.kernel.org
Subject: Re: SMP/cc Cluster description
Message-ID: <20011207112837.R27589@work.bitmover.com>
Mail-Followup-To: Dana Lacoste <dana.lacoste@peregrine.com>,
	'Larry McVoy' <lm@bitmover.com>,
	"Martin J. Bligh" <Martin.Bligh@us.ibm.com>,
	linux-kernel@vger.kernel.org
In-Reply-To: <B51F07F0080AD511AC4A0002A52CAB445B29B8@OTTONEXC1>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <B51F07F0080AD511AC4A0002A52CAB445B29B8@OTTONEXC1>; from dana.lacoste@peregrine.com on Fri, Dec 07, 2001 at 11:14:13AM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 07, 2001 at 11:14:13AM -0800, Dana Lacoste wrote:
> Man you guys are NUTS.

I resemble that remark :-)

> > Did you even consider that this is virtually identical to the problem
> > that a network of workstations or servers has?  Did it occur 
> > to you that
> > people have solved this problem in many different ways?  Or 
> > did you just
> > want to piss into the wind and enjoy the spray?
> 
> I may be a total tool here, but this question is really bugging me :
> 
> What, if any, advantages does your proposal have over (say) a Beowulf
> cluster?  Why does having the cluster in one box seem a better solution
> than having a Beowulf type cluster with a shared Network filesystem?

Because I can mmap the same data across cluster nodes and get at it using
hardware, so a cache miss is a cache miss regardless of which node I'm
on, and it takes ~200 nanoseconds.  With a network based cluster, those
times go up about a factor of 10,000 or so.
-- 
---
Larry McVoy            	 lm at bitmover.com           http://www.bitmover.com/lm 
