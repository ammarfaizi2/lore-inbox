Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276923AbRJHO7N>; Mon, 8 Oct 2001 10:59:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276920AbRJHO7E>; Mon, 8 Oct 2001 10:59:04 -0400
Received: from shed.alex.org.uk ([195.224.53.219]:32698 "HELO shed.alex.org.uk")
	by vger.kernel.org with SMTP id <S276912AbRJHO6y>;
	Mon, 8 Oct 2001 10:58:54 -0400
Date: Mon, 08 Oct 2001 16:01:05 +0100
From: Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>
Reply-To: Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>
To: "Eric W. Biederman" <ebiederman@uswest.net>,
        Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>
Cc: Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz>,
        Rik van Riel <riel@conectiva.com.br>,
        Krzysztof Rusocki <kszysiu@main.braxis.co.uk>, linux-xfs@oss.sgi.com,
        linux-kernel@vger.kernel.org,
        Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>
Subject: Re: %u-order allocation failed
Message-ID: <1231218688.1002556865@[10.132.113.67]>
In-Reply-To: <m1wv27wber.fsf@frodo.biederman.org>
In-Reply-To: <m1wv27wber.fsf@frodo.biederman.org>
X-Mailer: Mulberry/2.1.0 (Win32)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



--On Sunday, October 07, 2001 12:30 PM -0600 "Eric W. Biederman" 
<ebiederman@uswest.net> wrote:

>> Note also that something (not sure what) has made fragmentation
>> increasingly prevalent over the years since the buddy allocator
>> was originally put in.
>
> Actually it seems to be situations like the stack now being two pages

Instrumentation posted here before appears to corellate fragmentation
being /caused/ with I/O activity (single bonnie process and thus a
single 8k stack frame). My own guess is that it is due to
a different persistence of various caches.

I haven't seen anyone before blaming stack frame allocation
as a /cause/ of fragmenation - I've heard people say they
notice fragmentation more as stack frame allocs start to
fail - but that's a symptom.

--
Alex Bligh
