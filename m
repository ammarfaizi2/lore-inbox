Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265992AbTGAF6u (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Jul 2003 01:58:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265993AbTGAF6t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Jul 2003 01:58:49 -0400
Received: from anumail5.anu.edu.au ([150.203.2.45]:5025 "EHLO anu.edu.au")
	by vger.kernel.org with ESMTP id S265992AbTGAF6s (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Jul 2003 01:58:48 -0400
Message-ID: <3F012663.5040704@cyberone.com.au>
Date: Tue, 01 Jul 2003 16:12:51 +1000
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; SunOS sun4u; en-US; rv:1.2.1) Gecko/20021217
MIME-Version: 1.0
To: Peter Wong <wpeter@us.ibm.com>
CC: linux-kernel@vger.kernel.org, Andrew Morton <akpm@digeo.com>,
       Mike Sullivan <mksully@us.ibm.com>, Bill Hartner <bhartner@us.ibm.com>,
       Ray Venditti <venditti@us.ibm.com>
Subject: Re: Evaluation of three I/O schedulers
References: <OF9393D547.0D1D003C-ON85256D55.004DFAA4@pok.ibm.com>
In-Reply-To: <OF9393D547.0D1D003C-ON85256D55.004DFAA4@pok.ibm.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Sender-Domain: cyberone.com.au
X-Spam-Score: (-2.8)
X-Spam-Tests: DATE_IN_PAST_06_12,EMAIL_ATTRIBUTION,IN_REP_TO,REFERENCES,SPAM_PHRASE_00_01,USER_AGENT,USER_AGENT_MOZILLA_UA
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Peter Wong wrote:

>We used 2.5.72+mm1 to evaluate three I/O schedulers, namely
>anticipatory, deadline and complete fair queueing under a very heavy
>database workload on an 8-way Pentium 4 machine. The workload is a
>decision support system doing mostly sequential I/O and each run takes
>about one hour. All three runs finished completely without encountering
>functional problems, and achieved similar performance level.
>
>The 8-way machine has Pentium 4 2.0 GHz processors, 16 GB physical
>memory, 2MB L3 cache, 8 FC controllers with 80 disks. Hyperthreading
>was turned on for the three runs. The CPU utilization is similar for all
>three runs: 65% user, 7% system and 28% idle.
>

Hi Peter,
How many block devices are being used at once in your tests?
I would be interested to see profiles of AS and DL if possible.
Thanks.

Nick

