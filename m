Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280831AbRKONjJ>; Thu, 15 Nov 2001 08:39:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280832AbRKONjA>; Thu, 15 Nov 2001 08:39:00 -0500
Received: from hanoi.cronyx.ru ([144.206.181.53]:14596 "EHLO hanoi.cronyx.ru")
	by vger.kernel.org with ESMTP id <S280831AbRKONit>;
	Thu, 15 Nov 2001 08:38:49 -0500
Message-ID: <3BF3C47C.2030400@cronyx.ru>
Date: Thu, 15 Nov 2001 16:34:52 +0300
From: Roman Kurakin <rik@cronyx.ru>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:0.9.2) Gecko/20010726 Netscape6/6.1
X-Accept-Language: en-us
MIME-Version: 1.0
To: Russell King <rmk@arm.linux.org.uk>
CC: linux-kernel@vger.kernel.org
Subject: Re: Serial.c Bug
In-Reply-To: <3BF24147.9030508@cronyx.ru> <20011114235908.B19575@flint.arm.linux.org.uk>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks

Russell King wrote:

>On Wed, Nov 14, 2001 at 01:02:47PM +0300, Roman Kurakin wrote:
>
>>    I have found a bug. It is in support of serial cards which uses 
>>memory for I/O insted of ports. I made a patch for serial.c and fix
>>one place, but probably the problem like this one could be somewhere
>>else.
>>
>
>I've got this fish caught in the my serial driver rewrite - the driver
>always handles the requesting and freeing of the resources.  If it is
>unable to request the resources, then you will receive a suitable error
>when trying to configure two ports.
>
>Please note that I'm not about to take on maintainence of the current
>serial.c driver, except where I spot obvious bugs.
>
>I'd recommend that you pass this one to Marcelo to incorporate (only
>after he's got his feet on the ground again. 8))  It looks sensible.
>
>--
>Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
>             http://www.arm.linux.org.uk/personal/aboutme.html
>
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/
>
>




