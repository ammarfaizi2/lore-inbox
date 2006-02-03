Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751317AbWBCSZL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751317AbWBCSZL (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Feb 2006 13:25:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751328AbWBCSZK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Feb 2006 13:25:10 -0500
Received: from mtiwmhc12.worldnet.att.net ([204.127.131.116]:30417 "EHLO
	mtiwmhc12.worldnet.att.net") by vger.kernel.org with ESMTP
	id S1751317AbWBCSZJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Feb 2006 13:25:09 -0500
Message-ID: <43E3A001.7080309@lwfinger.net>
Date: Fri, 03 Feb 2006 12:25:05 -0600
From: Larry Finger <Larry.Finger@lwfinger.net>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20050923)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: Linux v2.6.16-c2
References: <43E39932.4000001@lwfinger.net> <Pine.LNX.4.64.0602031007420.4630@g5.osdl.org>
In-Reply-To: <Pine.LNX.4.64.0602031007420.4630@g5.osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> On Fri, 3 Feb 2006, Larry Finger wrote:
> 
>>I know you must have a good reason to switch to the 'pack' form in the git
>>tree, but I'm curious. I did a git pull late yesterday, which was "normal",
>>and another this morning when I saw that 2.6.16-rc2 was posted. I was quite
>>surprised to download 110 MB of data to get roughly 150 changed lines.
> 
> 
> Don't use rsync (or http) access unless you have to.
> 
> Try using "git://git.kernel.org/" instead. 
> 
> Now, it may be that if we have lots of people using it, the CPU usage of 
> the server-side effort will go through the roof, and we'll have to come up 
> with something else (most likely meaning having some mirrors also run 
> git-daemon, so that the CPU overhead can be pushed out too).
> 
> The point being that you shouldn't see the packing as even an issue (it 
> should be a per-repository decision). The fact that it shows up is because 
> of using non-git-aware protocols.
> 
> 		Linus
> 

Thanks for the explanation. I have to admit that git is pretty much a black box to me. I use the 
guide at http://linux.yyz.us/git-howto.html and it recommends using rsync. I'll have to figure out 
how to change to git protocol.

Larry

