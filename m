Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272123AbRHVV0E>; Wed, 22 Aug 2001 17:26:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272121AbRHVVZy>; Wed, 22 Aug 2001 17:25:54 -0400
Received: from h131s117a129n47.user.nortelnetworks.com ([47.129.117.131]:6818
	"HELO pcard0ks.ca.nortel.com") by vger.kernel.org with SMTP
	id <S272123AbRHVVZn>; Wed, 22 Aug 2001 17:25:43 -0400
Message-ID: <3B8423B9.29B1293A@nortelnetworks.com>
Date: Wed, 22 Aug 2001 17:27:21 -0400
From: Chris Friesen <cfriesen@nortelnetworks.com>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.3-custom i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Ignacio Vazquez-Abrams <ignacio@openservices.net>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] (comments requested) adding finer-grained timing to PPC 
 add_timer_randomness()
In-Reply-To: <Pine.LNX.4.33.0108221702300.12521-100000@terbidium.openservices.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ignacio Vazquez-Abrams wrote:

> >From the patch:
> 
> --- linux-2.2.19-clean/arch/ppc/kernel/setup.c  Sun Mar 25 11:31:49 2001
> +++ linux-2.2.19/arch/ppc/kernel/setup.c        Wed Aug 22 16:34:51 2001
>   ...
> +extern int have_timebase = 1;
>   ...
> --- linux-2.2.19-clean/include/asm-ppc/processor.h      Sun Mar 25 11:31:08 2001
> +++ linux-2.2.19/include/asm-ppc/processor.h    Wed Aug 22 16:34:51 2001
>   ...
> +extern int have_timebase;
>   ...

> Am I missing something, or should at least one of these not be extern?


Okay, I feel dumb.  You're right of course. I guess I must have missed the
compiler warning.

Chris

-- 
Chris Friesen                    | MailStop: 043/33/F10  
Nortel Networks                  | work: (613) 765-0557
3500 Carling Avenue              | fax:  (613) 765-2986
Nepean, ON K2H 8E9 Canada        | email: cfriesen@nortelnetworks.com
