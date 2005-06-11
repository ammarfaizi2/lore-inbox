Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261509AbVFKBiR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261509AbVFKBiR (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Jun 2005 21:38:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261510AbVFKBiR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Jun 2005 21:38:17 -0400
Received: from mf00.sitadelle.com ([212.94.174.79]:44153 "EHLO
	smtp.cegetel.net") by vger.kernel.org with ESMTP id S261509AbVFKBiL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Jun 2005 21:38:11 -0400
Message-ID: <42AA407C.2070104@lifl.fr>
Date: Sat, 11 Jun 2005 03:38:04 +0200
From: Eric Piel <Eric.Piel@lifl.fr>
Organization: LIFL
User-Agent: Mozilla Thunderbird 1.0.2-3mdk (X11/20050322)
X-Accept-Language: en, fr, ja, es
MIME-Version: 1.0
To: paulmck@us.ibm.com
Cc: Chris Friesen <cfriesen@nortel.com>, linux-kernel@vger.kernel.org,
       bhuey@lnxw.com, andrea@suse.de, tglx@linutronix.de, karim@opersys.com,
       mingo@elte.hu, pmarques@grupopie.com, bruce@andrew.cmu.edu,
       nickpiggin@yahoo.com.au, ak@muc.de, sdietrich@mvista.com,
       dwalker@mvista.com, hch@infradead.org, akpm@osdl.org
Subject: Re: Attempted summary of "RT patch acceptance" thread
References: <20050608022646.GA3158@us.ibm.com> <42A73D15.6080201@nortel.com> <20050608192853.GE1295@us.ibm.com> <42AA133D.1050102@lifl.fr> <20050610230433.GI1300@us.ibm.com> <42AA20F6.9030606@lifl.fr> <20050611005934.GM1300@us.ibm.com>
In-Reply-To: <20050611005934.GM1300@us.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

11.06.2005 02:59, Paul E. McKenney wrote/a écrit:
> On Sat, Jun 11, 2005 at 01:23:34AM +0200, Eric Piel wrote:
>>What about using the way you wrote it at the beginning of the section:
>>"Probability of missing a deadline only because of a hardware failure"
> 
> 
> Good point, I may just need to invert the whole thing, so that it
> becomes something like:
> 
> 	i.	Probability of missing a deadline due to software,
> 		ranging from 0 to 1, with the value of 0 corresponding
> 		to the hardest possible hard realtime.
> 
> But then the "p^n" becomes "1-(1-p)^n".  Bleah.
Yes, it seems language doesn't fit well with mathematics ;-)

> 
> OK, how about the following?
> 
> 	i.	Probability of meeting a deadline in absence of hardware
> 		failure, ranging from 0 to 1, with the value of 1
> 		corresponding to the hardest possible hard realtime.
> 
Sounds good!

Eric
