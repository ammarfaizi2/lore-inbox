Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S143404AbRA1QPM>; Sun, 28 Jan 2001 11:15:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S143436AbRA1QPC>; Sun, 28 Jan 2001 11:15:02 -0500
Received: from colorfullife.com ([216.156.138.34]:51210 "EHLO colorfullife.com")
	by vger.kernel.org with ESMTP id <S143404AbRA1QO6>;
	Sun, 28 Jan 2001 11:14:58 -0500
Message-ID: <3A74456D.7AE44855@colorfullife.com>
Date: Sun, 28 Jan 2001 17:14:37 +0100
From: Manfred Spraul <manfred@colorfullife.com>
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.2.16-22 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: dwmw2@infradead.org, acme@conectiva.com.br, linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] Kernel Janitor's TODO list
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 
> Anything which uses sleep_on() has a 90% chance of being broken. Fix 
> them all, because we want to remove sleep_on() and friends in 2.5. 
>

Then you can add 'calling schedule() with disabled local interrupts()'
to your list.

--
	Manfred
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
