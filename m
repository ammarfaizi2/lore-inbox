Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135780AbREIWiw>; Wed, 9 May 2001 18:38:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135788AbREIWim>; Wed, 9 May 2001 18:38:42 -0400
Received: from chromium11.wia.com ([207.66.214.139]:7436 "EHLO
	neptune.kirkland.local") by vger.kernel.org with ESMTP
	id <S135780AbREIWif>; Wed, 9 May 2001 18:38:35 -0400
Message-ID: <3AF9C7D2.1E2BD87C@chromium.com>
Date: Wed, 09 May 2001 15:42:26 -0700
From: Fabio Riccardi <fabio@chromium.com>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.2 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: mingo@elte.hu
CC: linux-kernel@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Christopher Smith <x@xman.org>, Andrew Morton <andrewm@uow.edu.au>,
        "Timothy D. Witham" <wookie@osdlab.org>, David_J_Morse@Dell.com
Subject: Re: X15 alpha release: as fast as TUX but in user space
In-Reply-To: <Pine.LNX.4.33.0105041028430.2178-100000@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I have uploaded a new release of X15 that hopefully solves all the RFC bugs.
I say hopefully because I haven't had the opportunity to fully test the
request pipelining. Is there anything to automatize such tests?

>From what I could measure X15 is still a good 5% faster than TUX.

You can find the file at: http://www.chromium.com/X15-Alpha-4.tgz

BTW: Next release (in a week or so) will be a beta and it will include source
code!

BTW2: I'll be away from my email in the next few days, so don't be amazed if
I'll be kind of slow replying to messages...

 - Fabio

Ingo Molnar wrote:

> yet another anomaly i noticed. X15 does not appear to handle pipelined
> HTTP/1.1 requests properly, it ignores the second request if two requests
> arrive in the same packet.
>
> SPECweb99 does not send pipelined requests, but a number of RL web clients
> do. (Mozilla, apt-get, etc.)
>
>         Ingo
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

