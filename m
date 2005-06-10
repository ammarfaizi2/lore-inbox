Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261411AbVFJX2g@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261411AbVFJX2g (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Jun 2005 19:28:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261399AbVFJX2f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Jun 2005 19:28:35 -0400
Received: from reserv6.univ-lille1.fr ([193.49.225.20]:14748 "EHLO
	reserv6.univ-lille1.fr") by vger.kernel.org with ESMTP
	id S261411AbVFJXY3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Jun 2005 19:24:29 -0400
Message-ID: <42AA20F6.9030606@lifl.fr>
Date: Sat, 11 Jun 2005 01:23:34 +0200
From: Eric Piel <Eric.Piel@lifl.fr>
User-Agent: Mozilla Thunderbird 1.0.2-3mdk (X11/20050322)
X-Accept-Language: fr, en
MIME-Version: 1.0
To: paulmck@us.ibm.com
CC: Chris Friesen <cfriesen@nortel.com>, linux-kernel@vger.kernel.org,
       bhuey@lnxw.com, andrea@suse.de, tglx@linutronix.de, karim@opersys.com,
       mingo@elte.hu, pmarques@grupopie.com, bruce@andrew.cmu.edu,
       nickpiggin@yahoo.com.au, ak@muc.de, sdietrich@mvista.com,
       dwalker@mvista.com, hch@infradead.org, akpm@osdl.org
Subject: Re: Attempted summary of "RT patch acceptance" thread
References: <20050608022646.GA3158@us.ibm.com> <42A73D15.6080201@nortel.com> <20050608192853.GE1295@us.ibm.com> <42AA133D.1050102@lifl.fr> <20050610230433.GI1300@us.ibm.com>
In-Reply-To: <20050610230433.GI1300@us.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-USTL-MailScanner-Information: Please contact the ISP for more information
X-USTL-MailScanner: Found to be clean
X-MailScanner-From: eric.piel@lifl.fr
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

06/11/2005 01:04 AM, Paul E. McKenney wrote/a écrit:
>>Just a small change to "1 - QoS":
>>
>>
>>>b.	For each service:
>>>
>>>	i.	Probability of missing a deadline due to software,
>>>		ranging from 0 to 1, with the value of 1 corresponding
>>>		to the hardest possible hard realtime.
>>
>>I think it should be (by reference to how you define probability at the 
>>beginning of the section):
>>Probability of not missing any deadline due to software
> 
> 
> Good catch!  How about the following?
> 
> 	i.      Probability of meeting a deadline due to software,
> 		ranging from 0 to 1, with the value of 1 corresponding
> 		to the hardest possible hard realtime.
> 
> Changing "missing" in the original to "meeting".

It sounds strange to me (but english is not my mother tongue), it's like 
hardware was not so good but software helped to recover the situation 
and, eventually, the deadline was met ;-)

What about using the way you wrote it at the beginning of the section:
"Probability of missing a deadline only because of a hardware failure"

Eric
