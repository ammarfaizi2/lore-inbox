Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129101AbRA2Rky>; Mon, 29 Jan 2001 12:40:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130147AbRA2Rko>; Mon, 29 Jan 2001 12:40:44 -0500
Received: from ns1.SuSE.com ([202.58.118.2]:2064 "HELO ns1.suse.com")
	by vger.kernel.org with SMTP id <S129101AbRA2Rkf>;
	Mon, 29 Jan 2001 12:40:35 -0500
Date: Mon, 29 Jan 2001 09:40:45 -0800 (PST)
From: James Simmons <jsimmons@suse.com>
To: Stefani Seibold <stefani@seibold.net>
Cc: Thunder from the hill <thunder@ngforever.de>, linux-kernel@vger.kernel.org
Subject: Re: patch for 2.4.0 disable printk
In-Reply-To: <01012711571400.01203@deepthought.seibold.net>
Message-ID: <Pine.LNX.4.21.0101290938560.6646-100000@euclid.oak.suse.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> You are right... this patch make no sense on a computer system with human 
> interactions. But think on tiny hidden computers, like in a dishwasher or a 
> traffic light. This computer are standalone, if it crash, then it will be 
> rebooted.
> Nobody will attach a terminal to this kind of computer, nobody is interessted 
> on a logfile. Nobody will see a oops, because nobdy is there. 

What do you suggest we do with /dev/console and stdin, stdout, stderr?
The kernel needs a /dev/console to boot with.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
