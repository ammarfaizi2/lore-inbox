Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319837AbSINASf>; Fri, 13 Sep 2002 20:18:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319838AbSINASe>; Fri, 13 Sep 2002 20:18:34 -0400
Received: from swan.mail.pas.earthlink.net ([207.217.120.123]:42667 "EHLO
	swan.mail.pas.earthlink.net") by vger.kernel.org with ESMTP
	id <S319837AbSINAS0>; Fri, 13 Sep 2002 20:18:26 -0400
Date: Fri, 13 Sep 2002 17:23:12 -0700
Subject: Re: Killing/balancing processes when overcommited
Content-Type: text/plain; charset=US-ASCII; format=flowed
Mime-Version: 1.0 (Apple Message framework v482)
Cc: riel@conectiva.com.br, linux-kernel@vger.kernel.org,
       thunder@lightweight.ods.org
To: wookie@osdl.org
From: Jim Sibley <JimSibley@earthlink.net>
In-Reply-To: <1031956299.2317.240.camel@wookie-t23.pdx.osdl.net>
Message-Id: <279AF69E-C778-11D6-BE27-0003936797C4@earthlink.net>
Content-Transfer-Encoding: 7bit
X-Mailer: Apple Mail (2.482)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Actually, the "offense is not asking for memory". The issue is 
gracefully responding to an exhausted resource in some kind of 
predetermined way - memory being just one example, but the that started 
this thread.

Any algorithm that bases the solution on the developer's notion of 
"niceness" and "offense" may not solve the problem the user installation 
is trying to solve - gracefully shutting  down work (or ungracefully if 
necessary) based on the installations priorities and needs rather than 
randomly killing. Hopefully, the system can survive past the peak that 
aggravating the problem or at least let someone add the resources 
needed. In the particular case of "out of memory", add swap spaces.

I'd rather be able to choose to lose the online cafeteria menu before I 
lose the emergency dispatch system. I'd much rather take action well 
before any of the critical system functions are sacrificed. To me, 
logging on by the wheel is going to fix the problem is quite high on my 
priority list. But with Tim's definition, he is the offended because he 
would be asking for memory.

I have to beg off this discussion for a week as I'll me out of country. 
I shall return.

