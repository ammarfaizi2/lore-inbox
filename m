Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751203AbVJ2UQd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751203AbVJ2UQd (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Oct 2005 16:16:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751233AbVJ2UQc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Oct 2005 16:16:32 -0400
Received: from mail.dvmed.net ([216.237.124.58]:9094 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1751203AbVJ2UQb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Oct 2005 16:16:31 -0400
Message-ID: <4363D89A.9080007@pobox.com>
Date: Sat, 29 Oct 2005 16:16:26 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
CC: Andrew Morton <akpm@osdl.org>, linux-ide@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [git patches] 2.6.x libata updates
References: <20051029182228.GA14495@havoc.gtf.org> <20051029121454.5d27aecb.akpm@osdl.org> <4363CB60.2000201@pobox.com> <Pine.LNX.4.64.0510291229330.3348@g5.osdl.org>
In-Reply-To: <Pine.LNX.4.64.0510291229330.3348@g5.osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> Side note: one of the downsides of the new "merge lots of stuff early in 
> the development series" approach is that the first few daily snapshots end 
> up being _huge_. 

Yeah.  Back when I did the BK snapshots, I would occasionally do a 
middle-of-the-day snapshot if there were a ton of incoming merges in a 
24-hour span.

If this "huge -git1" becomes a real problem, we could always

* give you a manual "do snapshot" button

* ask the maintainers to spread out their submits across multiple days, 
as I am doing now

* sell you on capping the daily push-to-kernel.org limit.  merge stuff 
into "day1", "day2", etc. branches when the main branch "fills up" for 
the day.

None of these are terribly painful, but none are terribly appealing either.

	Jeff


