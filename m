Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272682AbRIVD6H>; Fri, 21 Sep 2001 23:58:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273345AbRIVD55>; Fri, 21 Sep 2001 23:57:57 -0400
Received: from co3000407-a.belrs1.nsw.optushome.com.au ([203.164.252.88]:38578
	"EHLO bozar") by vger.kernel.org with ESMTP id <S272682AbRIVD5s>;
	Fri, 21 Sep 2001 23:57:48 -0400
Date: Sat, 22 Sep 2001 13:57:16 +1000
From: Andre Pang <ozone@algorithm.com.au>
To: Robert Love <rml@tech9.net>
Cc: linux-kernel@vger.kernel.org, safemode@speakeasy.net,
        Dieter.Nuetzel@hamburg.de, iafilius@xs4all.nl, ilsensine@inwind.it,
        george@mvista.com
Subject: Re: [PATCH] Preemption Latency Measurement Tool
Mail-Followup-To: Robert Love <rml@tech9.net>, linux-kernel@vger.kernel.org,
	safemode@speakeasy.net, Dieter.Nuetzel@hamburg.de,
	iafilius@xs4all.nl, ilsensine@inwind.it, george@mvista.com
In-Reply-To: <1000939458.3853.17.camel@phantasy>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1000939458.3853.17.camel@phantasy>
User-Agent: Mutt/1.3.20i
Message-Id: <1001131036.557760.4340.nullmailer@bozar.algorithm.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 19, 2001 at 06:44:09PM -0400, Robert Love wrote:

> Available at:
> http://tech9.net/rml/linux/patch-rml-2.4.9-ac12-preempt-stats-1 and
> http://tech9.net/rml/linux/patch-rml-2.4.10-pre12-preempt-stats-1
> for 2.4.9-ac12 and 2.4.10-pre12, respectively.

hi Robert, thanks for producing the stats patches!

i did a test of it on linux-2.4.10-pre13 with Benno Senoner's
lowlatency program, which i hacked up a bit to output
/proc/latencytimes after each of the graphs.  test results are at

    http://www.algorithm.com.au/hacking/linux-lowlatency/2.4.10-pre13-pes/

and since i stared at the results in disbelief, i won't even try
to guess what's going on :).  maybe you can make some sense of
it?

i'm prety sure his latencytest program runs at real-time
priority, but i'll run another test just with the getrt and rt
programs just posted to the list to make sure.  that's the only
reason i can think why the graph is so bizarre compared to the
/proc/latencytimes results.


-- 
#ozone/algorithm <ozone@algorithm.com.au>          - trust.in.love.to.save
