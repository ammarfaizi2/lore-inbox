Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269134AbRHGQiL>; Tue, 7 Aug 2001 12:38:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269002AbRHGQiC>; Tue, 7 Aug 2001 12:38:02 -0400
Received: from [64.38.173.150] ([64.38.173.150]:24068 "EHLO chicago.cheek.com")
	by vger.kernel.org with ESMTP id <S269001AbRHGQh6>;
	Tue, 7 Aug 2001 12:37:58 -0400
Message-ID: <3B7018C8.30101@cheek.com>
Date: Tue, 07 Aug 2001 09:35:20 -0700
From: Joseph Cheek <joseph@cheek.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.2) Gecko/20010712
X-Accept-Language: en-us
MIME-Version: 1.0
To: Andrey Savochkin <saw@saw.sw.com.sg>
CC: linux-kernel@vger.kernel.org
Subject: Re: eepro100 (PCI ID 82820) lockups/failure
In-Reply-To: <20010806022727.A25793@saw.sw.com.sg> <Pine.LNX.4.10.10108060846230.14815-100000@chicago.cheek.com> <20010807034810.A10311@saw.sw.com.sg>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

once i changed the udelay() to 10 i was able to see the wait_for_timeout 
errors others have reported.  with the udelay at 1 i saw nothing on the 
screen before the lockup.

thanks!

joe

Andrey Savochkin wrote:

>On Mon, Aug 06, 2001 at 08:48:22AM -0700, Joseph Cheek wrote:
>
>>i applied the usleep(1) patch and i still get lockups on 2.4.7-ac5.  not
>>sure how i could get you the info you need, but i would certainly be
>>willing to help.
>>
>>my machine locks hard before anything gets to syslog.
>>
>
>Are you able to check the screen?
>Had the driver printed anything before the lockup?
>
>	Andrey
>


