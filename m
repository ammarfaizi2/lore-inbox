Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130347AbQKRO03>; Sat, 18 Nov 2000 09:26:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130404AbQKRO0T>; Sat, 18 Nov 2000 09:26:19 -0500
Received: from mail11.verio.de ([213.198.0.60]:38501 "HELO mail11.verio.de")
	by vger.kernel.org with SMTP id <S130347AbQKRO0A>;
	Sat, 18 Nov 2000 09:26:00 -0500
Message-ID: <3A1697D1.468F5372@Meding.net>
Date: Sat, 18 Nov 2000 14:53:05 +0000
From: Michael Meding <Michael@Meding.net>
Reply-To: Michael@Meding.net
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.0-test10 i686)
X-Accept-Language: de-DE, de, en
MIME-Version: 1.0
CC: linux-kernel@vger.kernel.org
Subject: Re: Freeze on FPU exception with Athlon
In-Reply-To: <Pine.BSO.4.21.0011180215380.28819-100000@getafix.lostland.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org
X-Loop-Detect: 1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
I am using test10-pre5 on Duron.
> 
> I couldn't get it to freeze.  I tried it with asm("fldcw %0": :"m" (0))
> and with fesetenv() using gcc -lm to link it.  I have glibc-2.1.2,
> egcs 2.91.66, and 2.4.0-test10.
> 
> Regards,
> Adrian

Same here except gcc-2.95.2 and glibc 2.13. I got an floating point
expeption. No freeze here.

Greetings


Michael Meding
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
