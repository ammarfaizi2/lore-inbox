Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267513AbRGXMwV>; Tue, 24 Jul 2001 08:52:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267514AbRGXMwL>; Tue, 24 Jul 2001 08:52:11 -0400
Received: from panic.ohr.gatech.edu ([130.207.47.194]:2783 "HELO havoc.gtf.org")
	by vger.kernel.org with SMTP id <S267513AbRGXMv5>;
	Tue, 24 Jul 2001 08:51:57 -0400
Message-ID: <3B5D6F95.E1080FFA@mandrakesoft.com>
Date: Tue, 24 Jul 2001 08:52:37 -0400
From: jgarzik@mandrakesoft.com
Organization: MandrakeSoft
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.7 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "Daniel A. Nobuto" <ramune@bigfoot.com>
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org,
        Manfred Spraul <manfred@colorfullife.com>
Subject: Re: natsemi.c patch
In-Reply-To: <20010724000313.A591@bigfoot.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

"Daniel A. Nobuto" wrote:
> 
> Hi Linus,
> 
>         Here's the patch Manfred Spraul made for natsemi.c
> in 2.4.6 to work around a gcc bug, updated for 2.4.7.
> Without this patch, my natsemi card just keeps spitting out
> errors into syslog and doesn't send packets.
> 
>         Can this be put in for 2.4.8?

Linus please DO NOT apply this patch.  There are other fixes queued in
addition, and this patch appears to be corrupted from a whitespace
perspective as well.  There should be a better patch coming to you late
this week.

-- 
Jeff Garzik      | "I use Mandrake Linux for the same reason I turn
Building 1024    |  the light switch on and off 17 times before leaving
MandrakeSoft     |  the room.... If I don't my family will die."
                 |            -- slashdot.org comment
