Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267836AbRHATeM>; Wed, 1 Aug 2001 15:34:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267986AbRHATeC>; Wed, 1 Aug 2001 15:34:02 -0400
Received: from [47.129.117.131] ([47.129.117.131]:32652 "HELO
	pcard0ks.ca.nortel.com") by vger.kernel.org with SMTP
	id <S267836AbRHATeA>; Wed, 1 Aug 2001 15:34:00 -0400
Message-ID: <3B6859B2.F1E2C95B@nortelnetworks.com>
Date: Wed, 01 Aug 2001 15:34:10 -0400
From: Chris Friesen <cfriesen@nortelnetworks.com>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.3-custom i686)
X-Accept-Language: en
MIME-Version: 1.0
To: george anzinger <george@mvista.com>, linux-kernel@vger.kernel.org
Subject: Re: No 100 HZ timer !
In-Reply-To: <3B683AC4.E0F2BF9E@mvista.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

george anzinger wrote:

> The testing I have done seems to indicate a lower overhead on a lightly
> loaded system, about the same overhead with some load, and much more
> overhead with a heavy load.  To me this seems like the wrong thing to

What about something that tries to get the best of both worlds?  How about a
tickless system that has a max frequency for how often it will schedule?  This
would give the tickless advantage for big iron running many lightly loaded
virtual instances, but have some kind of cap on the overhead under heavy load.

Does this sound feasable?

-- 
Chris Friesen                    | MailStop: 043/33/F10  
Nortel Networks                  | work: (613) 765-0557
3500 Carling Avenue              | fax:  (613) 765-2986
Nepean, ON K2H 8E9 Canada        | email: cfriesen@nortelnetworks.com
