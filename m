Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264628AbTIDDUw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Sep 2003 23:20:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264589AbTIDDUw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Sep 2003 23:20:52 -0400
Received: from anumail3.anu.edu.au ([150.203.2.43]:50820 "EHLO anu.edu.au")
	by vger.kernel.org with ESMTP id S264628AbTIDDUp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Sep 2003 23:20:45 -0400
Message-ID: <3F56AF70.7030009@cyberone.com.au>
Date: Thu, 04 Sep 2003 13:20:16 +1000
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021130
MIME-Version: 1.0
To: Steven Cole <elenstev@mesatop.com>
CC: William Lee Irwin III <wli@holomorphy.com>,
       Daniel Phillips <phillips@arcor.de>,
       Antonio Vargas <wind@cocodriloo.com>, Larry McVoy <lm@bitmover.com>,
       CaT <cat@zip.com.au>, Anton Blanchard <anton@samba.org>,
       linux-kernel@vger.kernel.org
Subject: Re: Scaling noise
References: <20030903040327.GA10257@work.bitmover.com>	 <20030903124716.GE2359@wind.cocodriloo.com>	 <1062603063.1723.91.camel@spc9.esa.lanl.gov>	 <200309040350.31949.phillips@arcor.de> <1062641965.3483.78.camel@spc>	 <20030904023501.GE4306@holomorphy.com> <1062643242.3483.85.camel@spc>
In-Reply-To: <1062643242.3483.85.camel@spc>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Sender-Domain: cyberone.com.au
X-Spam-Score: (-7.4)
X-Spam-Tests: BAYES_01,EMAIL_ATTRIBUTION,IN_REP_TO,REFERENCES,REPLY_WITH_QUOTES,USER_AGENT_MOZILLA_UA
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Steven Cole wrote:

>On Wed, 2003-09-03 at 20:35, William Lee Irwin III wrote:
>
>>On Wed, Sep 03, 2003 at 08:19:26PM -0600, Steven Cole wrote:
>>
>>>I would never call the SMP locking pathetic, but it could be improved.
>>>Looking at Figure 6 (Star-CD, 1-64 processors on Altix) and Figure 7
>>>(Gaussian 1-32 processors on Altix) on page 13 of "Linux Scalability for
>>>Large NUMA Systems", available for download here:
>>>http://archive.linuxsymposium.org/ols2003/Proceedings/
>>>it appears that for those applications, the curves begin to flatten
>>>rather alarmingly.  This may have little to do with locking overhead.
>>>
>>Those numbers are 2.4.x
>>
>
>Yes, I saw that.  It would be interesting to see results for recent
>2.6.0-textX kernels.  Judging from other recent numbers out of osdl, the
>results for 2.6 should be quite a bit better.  But won't the curves
>still begin to flatten, but at a higher CPU count?  Or has the miracle
>goodness of RCU pushed those limits to insanely high numbers?
>

They fixed some big 2.4 scalability problems, so it wouldn't be as
impressive as plain 2.4 -> 2.6. However there are obviously hardware
scalability limits as well as software ones. So a more interesting
comparison would of course be 2.6 vs LM's SSI clusters.


