Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129736AbRAELdA>; Fri, 5 Jan 2001 06:33:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129757AbRAELcu>; Fri, 5 Jan 2001 06:32:50 -0500
Received: from colorfullife.com ([216.156.138.34]:44039 "EHLO colorfullife.com")
	by vger.kernel.org with ESMTP id <S129736AbRAELch>;
	Fri, 5 Jan 2001 06:32:37 -0500
Message-ID: <3A55B0E4.854AB8AD@colorfullife.com>
Date: Fri, 05 Jan 2001 12:32:52 +0100
From: Manfred <manfred@colorfullife.com>
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.0 i686)
X-Accept-Language: en, de
MIME-Version: 1.0
To: narancs1@externet.hu, linux-kernel@vger.kernel.org
Subject: Re: agpgart problem on 2.4.0-ac1
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> EIP: 0010:[<00000000>] 
> Call Trace: [<c8829bb0>] [<c8827000>] [<c8827068>] [<c8829d50>] 
>	[<c882aa00>] [<c8827000>] [<c01156cd>] 
>       [<c8820000>] [<c8827060>] [<c0108d5f>] 
>
> Code: Bad EIP value. 

Could you parse your oops through ksymoops?

Probably someone called an uninitialized function pointer, or there was
a stack overrun.

--
	Manfred
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
