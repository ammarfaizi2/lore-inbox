Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268965AbRHCMHe>; Fri, 3 Aug 2001 08:07:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268996AbRHCMHY>; Fri, 3 Aug 2001 08:07:24 -0400
Received: from gw.framfab.dk ([194.239.251.2]:60169 "HELO [194.239.251.2]")
	by vger.kernel.org with SMTP id <S268965AbRHCMHJ>;
	Fri, 3 Aug 2001 08:07:09 -0400
Message-ID: <3B6A935B.8000004@fugmann.dhs.org>
Date: Fri, 03 Aug 2001 14:04:43 +0200
From: Anders Peter Fugmann <afu@fugmann.dhs.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.2) Gecko/20010628
X-Accept-Language: en-us
MIME-Version: 1.0
CC: linux-kernel@vger.kernel.org
Subject: Re: Ongoing 2.4 VM suckage
In-Reply-To: <Pine.LNX.4.33.0108021122400.21298-100000@heat.gghcwest.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
To: unlisted-recipients:; (no To-header on input)@localhost.localdomain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

While reading this thread, there is something that I do not quite 
understand, and I hope that some of you could please explain it to me.

Why is the machine going dead (soft-deadlock as someone called it)? If 
there is not enough avaiable memory for a process in running state to 
actually run, other processes would be swapped out right, but this 
"simple" operation should not bring the machine down should it.

If the reason for the machine going bad is because when the running 
process eventually (or even before) gets all it memory to actually run, 
it is rescheduled, I see a simple solution.

Stop rescheduling too often when memory is low. Rescheduling is very 
memory demanding (in terms of swapping and stuff), and that is not 
helping the situation.

Any thought on this, or am I compleatly mistaken?

Regards
Anders Fugmann

