Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315760AbSHAQjH>; Thu, 1 Aug 2002 12:39:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315762AbSHAQjG>; Thu, 1 Aug 2002 12:39:06 -0400
Received: from zcars04e.nortelnetworks.com ([47.129.242.56]:46045 "EHLO
	zcars04e.ca.nortel.com") by vger.kernel.org with ESMTP
	id <S315760AbSHAQjF>; Thu, 1 Aug 2002 12:39:05 -0400
Message-ID: <3D4964AE.891F9878@nortelnetworks.com>
Date: Thu, 01 Aug 2002 12:41:18 -0400
X-Sybari-Space: 00000000 00000000 00000000
From: Chris Friesen <cfriesen@nortelnetworks.com>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.18 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Benjamin LaHaise <bcrl@redhat.com>,
       Pavel Machek <pavel@elf.ucw.cz>, Andrea Arcangeli <andrea@suse.de>,
       linux-kernel@vger.kernel.org, linux-aio@kvack.org
Subject: Re: [rfc] aio-core for 2.5.29 (Re: async-io API registration for2.5.29)
References: <Pine.LNX.4.44.0208010924050.14765-100000@home.transmeta.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:

> The only thing that I think makes it less than wonderful is really the
> fact that we cannot give an accurate measure for it. We can _say_ that
> what we count in microseconds, but it might turn out that instead of the
> perfect 1000000 ticks a second ther would really be 983671 ticks.

Would there be any benefit to using processor timestamps (rdtsc and friends) for
this if they are available?  I don't know the complexities of the interaction
with power management, that might make it infeasable.

Chris

-- 
Chris Friesen                    | MailStop: 043/33/F10  
Nortel Networks                  | work: (613) 765-0557
3500 Carling Avenue              | fax:  (613) 765-2986
Nepean, ON K2H 8E9 Canada        | email: cfriesen@nortelnetworks.com
