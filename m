Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261206AbTCTApJ>; Wed, 19 Mar 2003 19:45:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261264AbTCTApJ>; Wed, 19 Mar 2003 19:45:09 -0500
Received: from anumail4.anu.edu.au ([150.203.2.44]:23234 "EHLO anu.edu.au")
	by vger.kernel.org with ESMTP id <S261206AbTCTApJ>;
	Wed, 19 Mar 2003 19:45:09 -0500
Message-ID: <3E791181.4070001@cyberone.com.au>
Date: Thu, 20 Mar 2003 11:55:29 +1100
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; SunOS sun4u; en-US; rv:1.2.1) Gecko/20021217
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Joel Becker <Joel.Becker@oracle.com>
CC: Andrew Morton <akpm@digeo.com>, linux-kernel@vger.kernel.org
Subject: Re: WimMark I report for 2.5.65-mm2
References: <20030319232812.GJ2835@ca-server1.us.oracle.com> <20030319175726.59d08fba.akpm@digeo.com> <20030320003858.GM2835@ca-server1.us.oracle.com>
In-Reply-To: <20030320003858.GM2835@ca-server1.us.oracle.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Sender-Domain: cyberone.com.au
X-Spam-Score: (-3.4)
X-Spam-Tests: EMAIL_ATTRIBUTION,IN_REP_TO,REFERENCES,SPAM_PHRASE_00_01,USER_AGENT,USER_AGENT_MOZILLA_UA,X_ACCEPT_LANG
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Joel Becker wrote:

>On Wed, Mar 19, 2003 at 05:57:26PM -0800, Andrew Morton wrote:
>
>>Joel Becker <Joel.Becker@oracle.com> wrote:
>>
>>>WimMark I report for 2.5.65-mm2
>>>
>>>Runs:  1374.22 1487.19 1437.26
>>>
>>>
>>That is with elevator=as?
>>
>
>	Yes, it is as.  On Nick's recommendation I didn't consider a
>deadline run a priority.  The regular deadline runs have been 1550-1590,
>which is indeed statistically significant.
>
Well this is getting better which is good. I think we could make sync
writes in the stream even less favourable for anticipation, however
it might be doing bad things to contest dbench. Needs investigation.

