Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id <S129624AbRC1OjM>; Wed, 28 Mar 2001 09:39:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id <S131286AbRC1OjC>; Wed, 28 Mar 2001 09:39:02 -0500
Received: from 216.41.5.host170 ([216.41.5.170]:16859 "EHLO habitrail.home.fools-errant.com") by vger.kernel.org with ESMTP id <S129624AbRC1Oir>; Wed, 28 Mar 2001 09:38:47 -0500
Message-Id: <200103281438.f2SEc4Q03910@habitrail.home.fools-errant.com>
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.3
To: james <jdickens@ameritech.net>
cc: linux-kernel@vger.kernel.org
Subject: Re: Ideas for the oom problem 
In-reply-to: Your message of "Tue, 27 Mar 2001 18:53:18 CST." <01032718343500.32154@friz.themagicbus.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Wed, 28 Mar 2001 09:38:04 -0500
From: Hacksaw <hacksaw@hacksaw.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> a. don't kill any task with a uid < 100 
>     
> b. if uid between 100 to 500 or CAP-SYS equivalent enabled 
> 	set it too a lower priority, so if it is at fault it will happen slower 		   
>             giving more time before the system collapses

Deciding what not to kill based on who started it seems like a bad idea. Root 
can start netscape just as easily as any user, but if the choice of processes 
to kill is root's netscape or a user's experimental database, I'd want the 
netscape to go away.



