Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132957AbRAKVs5>; Thu, 11 Jan 2001 16:48:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135214AbRAKVss>; Thu, 11 Jan 2001 16:48:48 -0500
Received: from panic.ohr.gatech.edu ([130.207.47.194]:55312 "EHLO
	havoc.gtf.org") by vger.kernel.org with ESMTP id <S132957AbRAKVsf>;
	Thu, 11 Jan 2001 16:48:35 -0500
Message-ID: <3A5E29D4.1AA38368@mandrakesoft.com>
Date: Thu, 11 Jan 2001 16:47:00 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.1-pre1 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Frank de Lange <frank@unternet.org>
CC: Andrew Morton <andrewm@uow.edu.au>, linux-kernel@vger.kernel.org
Subject: Re: QUESTION: Network hangs with BP6 and 2.4.x kernels, hardware 
 related?
In-Reply-To: <20010110223015.B18085@unternet.org> <3A5D9D87.8A868F6A@uow.edu.au> <20010111220943.F3269@unternet.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Frank de Lange wrote:
> 
> OK, just one last addition to what has nearly become my own thread...
> 
> I now am fairly certain that the problem (network stalls on multiprocessor systems) is not BP6 or NE2K-PCI specific. I found several postings which relate to similar problems on dissimilar hardware. Another interesting one is:

>        I have reported it some time ago, and now all I get with
>        2.4.0-test11-pre4 and I think a additional patch is  NETDEV WATCHDOG:
>        eth0: transmit timed out, and something in the console about lost irq?



Are you judging based on the error message?  The 'netdev watchdog ...'
message is a generic error message that could have any number of
causes.  It's just saying, well, what it says :)  The kernel was unable
to transmit a packet in a certain amount of time.  You might get these
messages if you unplug a cable suddenly, or if your hardware isn't
delivering interrupts, or many other things...

	Jeff


-- 
Jeff Garzik       | "You see, in this world there's two kinds of
Building 1024     |  people, my friend: Those with loaded guns
MandrakeSoft      |  and those who dig. You dig."  --Blondie
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
