Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136982AbREJWvy>; Thu, 10 May 2001 18:51:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136984AbREJWvp>; Thu, 10 May 2001 18:51:45 -0400
Received: from pc7.prs.nunet.net ([199.249.167.77]:39688 "HELO
	pc7.prs.nunet.net") by vger.kernel.org with SMTP id <S136982AbREJWvf>;
	Thu, 10 May 2001 18:51:35 -0400
Message-ID: <20010510225133.3897.qmail@pc7.prs.nunet.net>
From: "Rico Tudor" <rico-linux-kernel@patrec.com>
Subject: Re: 2.4.3 Kernel Freeze with highmem BUG at highmem.c:155 - CRASH
To: kowalski@datrix.co.za
Date: Thu, 10 May 101 17:51:33 -0500 (CDT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <01051013425806.03256@webman> from "Marcin Kowalski" at May 10, 1 01:42:58 pm
X-Mailer: ELM [version 2.4 PL25]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> The symptons were an ever more sluggish machine over time, memory usage 
> looked pretty standard with the majority of memory assigned to cache... what 
> would happen is that at terminal it would go into semi-freeze states of about 
> 5-10 seconds (increasing with time), where no user interaction was possible. 
> By terminal I mean through a ssh remote terminal.... The load would also 
> occasionally just increase for no apparent reason to values of 7,8,9...

I reported the same sluggishness problem on Feb 25.  Capsule summary
is 64GB option does not work.  I was easily able to reproduce the
sluggishness in 2.4.2, but need to test again for 2.4.4.  See if your
problem goes away with the 4GB option.
