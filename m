Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932485AbWA0Tey@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932485AbWA0Tey (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Jan 2006 14:34:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932488AbWA0Tey
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Jan 2006 14:34:54 -0500
Received: from smtpout.mac.com ([17.250.248.45]:37098 "EHLO smtpout.mac.com")
	by vger.kernel.org with ESMTP id S932485AbWA0Tey (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Jan 2006 14:34:54 -0500
In-Reply-To: <000601c62370$db00cd50$1701a8c0@gerold>
References: <000601c62370$db00cd50$1701a8c0@gerold>
Mime-Version: 1.0 (Apple Message framework v746.2)
X-Priority: 3
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <E2075277-A24B-452F-BAF8-F88BC9C5E353@mac.com>
Cc: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
From: Kyle Moffett <mrmacman_g4@mac.com>
Subject: Re: traceroute bug ?
Date: Fri, 27 Jan 2006 14:34:41 -0500
To: Gerold van Dijk <gerold@sicon-sr.com>
X-Mailer: Apple Mail (2.746.2)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Jan 27, 2006, at 13:38, Gerold van Dijk wrote:
> Why can I NOT do a traceroute specifically within my own (sub)network
> 207.253.5.64/27

What part of "trace" "route" do you not understand?  If you are  
talking to your own subnet, there are no routers in between, so  
clearly there is nothing to trace.  A packet with TTL 0 is invalid,  
and a packet with TTL 1 will get to the host.

Cheers,
Kyle Moffett

--
Somone asked me why I work on this free (http://www.fsf.org/ 
philosophy/) software stuff and not get a real job. Charles Schulz  
had the best answer:

"Why do musicians compose symphonies and poets write poems? They do  
it because life wouldn't have any meaning for them if they didn't.  
That's why I draw cartoons. It's my life."
   -- Charles Schulz


