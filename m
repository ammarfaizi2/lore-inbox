Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263020AbVCXJdz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263020AbVCXJdz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Mar 2005 04:33:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263079AbVCXJdz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Mar 2005 04:33:55 -0500
Received: from web53307.mail.yahoo.com ([206.190.39.236]:38746 "HELO
	web53307.mail.yahoo.com") by vger.kernel.org with SMTP
	id S263020AbVCXJdw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Mar 2005 04:33:52 -0500
Message-ID: <20050324093352.43916.qmail@web53307.mail.yahoo.com>
Date: Thu, 24 Mar 2005 09:33:51 +0000 (GMT)
From: sounak chakraborty <sounakrin@yahoo.co.in>
Subject: Re: sched.c  function
To: Oliver Neukum <oliver@neukum.org>,
       linux kernel <linux-kernel@vger.kernel.org>
In-Reply-To: 6667
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



> What exactly do you want to know about the
> scheduler?
> 
I had a wild idea  to process one function that
repeatedly checks the task list and find out which
process is in which state 

At first i retrieve the information from fork.c in
do_fork() and exit.x in do_exit()
but the problem it showed me is that the information
of the task at the beginnig and at the
end(termination)

but the process may be in different states at
different moment in between these two extremes(start
-- end)

So how to know that .

I can  run for_each process after certain interval of
time , but rather than using timer i thought to set a
value or call the function (for_each_process) whenever
sheduling occurs(that is some process is going to
sleep and some are awakening) that is i am getting
some changes in the task list after that..

is my approch is correct ?
or should i implement timer ?
plz help me 

i am sorry if some of my concepts are wrong as i am
new to kernel and would be obliged if you correct me
thank for your help 
sounak  

________________________________________________________________________
Yahoo! India Matrimony: Find your partner online. http://yahoo.shaadi.com/india-matrimony/
