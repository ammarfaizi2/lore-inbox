Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751637AbWHTWOq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751637AbWHTWOq (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Aug 2006 18:14:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751640AbWHTWOq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Aug 2006 18:14:46 -0400
Received: from mailer.gwdg.de ([134.76.10.26]:63926 "EHLO mailer.gwdg.de")
	by vger.kernel.org with ESMTP id S1751630AbWHTWOp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Aug 2006 18:14:45 -0400
Date: Mon, 21 Aug 2006 00:06:51 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Alan Stern <stern@rowland.harvard.edu>
cc: Ingo Molnar <mingo@redhat.com>, Alexey Dobriyan <adobriyan@gmail.com>,
       Jeff Garzik <jeff@garzik.org>,
       Kernel development list <linux-kernel@vger.kernel.org>,
       David Woodhouse <dwmw2@infradead.org>, Andrew Morton <akpm@osdl.org>,
       "Theodore Ts'o" <tytso@mit.edu>
Subject: Re: Complaint about return code convention in queue_work() etc.
In-Reply-To: <Pine.LNX.4.44L0.0608201246310.17959-100000@netrider.rowland.org>
Message-ID: <Pine.LNX.4.61.0608210005090.32565@yvahk01.tjqt.qr>
References: <Pine.LNX.4.44L0.0608201246310.17959-100000@netrider.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Report: Content analysis: 0.0 points, 6.0 required
	_SUMMARY_
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> >Mixing up these two sorts of representations is a fertile source of
>> >difficult-to-find bugs.  If the C language included a strong distinction
>> >between integers and booleans then the compiler would find these mistakes
>> >for us... but it doesn't.
>> 
>> Recently introduced "bool".
>
>I haven't seen the new definition of "bool", but it can't possibly provide 
>a strong distinction between integers and booleans.  That is, if x is 
>declared as an integer rather than as a bool, the compiler won't complain 
>about "if (x) ...".

Only Java will get you this distinction. I would be comfortable with a 
feature where conditionals (like if() and ?:) enforce a bool showing 
up in C/C++, but it's not easy to get into the mainline gcc.


Jan Engelhardt
-- 
