Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261348AbUJZRVq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261348AbUJZRVq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Oct 2004 13:21:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261354AbUJZRVq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Oct 2004 13:21:46 -0400
Received: from tron.kn.vutbr.cz ([147.229.191.152]:25105 "EHLO
	tron.kn.vutbr.cz") by vger.kernel.org with ESMTP id S261348AbUJZRVn
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Oct 2004 13:21:43 -0400
Message-ID: <417E8794.9040102@stud.feec.vutbr.cz>
Date: Tue, 26 Oct 2004 19:21:24 +0200
From: Michal Schmidt <xschmi00@stud.feec.vutbr.cz>
User-Agent: Mozilla Thunderbird 0.8 (X11/20041005)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
CC: Florian Schmidt <mista.tapas@gmx.net>, Michael Geithe <warpy@gmx.de>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.10-rc1-bk4 and kernel/futex.c:542
References: <200410261135.51035.warpy@gmx.de> <20041026133126.1b44fb38@mango.fruits.de> <20041026112415.GA21015@elte.hu>
In-Reply-To: <20041026112415.GA21015@elte.hu>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Flag: NO
X-Spam-Report: Spam detection software, running on the system "tron.kn.vutbr.cz", has
  identified this incoming email as possible spam.  The original message
  has been attached to this so you can view it (if it isn't spam) or block
  similar future email.  If you have any questions, see
  the administrator of that system for details.
  ____
  Content analysis details:   (-4.2 points, 6.0 required)
  ____
   pts rule name              description
  ---- ---------------------- --------------------------------------------
   0.7 FROM_ENDS_IN_NUMS      From: ends in numbers
  -4.9 BAYES_00               BODY: Bayesian spam probability is 0 to 1%
                              [score: 0.0000]
  ____
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar wrote:
> yeah, it definitely looks like there is some futex race that the
> PREEMPT_REALTIME kernel triggers in no time. (this is because the
> locking in the PREEMPT_REALTIME kernel is equivalent to an SMP system
> with an infinite number of CPUs and will trigger the same races.)
> 
> 	Ingo

That's an interesting claim. I don't understand why it is equivalent. 
Could you please explain it?

Michal
