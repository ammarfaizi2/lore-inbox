Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129431AbRALKqE>; Fri, 12 Jan 2001 05:46:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129401AbRALKpy>; Fri, 12 Jan 2001 05:45:54 -0500
Received: from isis.its.uow.edu.au ([130.130.68.21]:15280 "EHLO
	isis.its.uow.edu.au") by vger.kernel.org with ESMTP
	id <S129383AbRALKpo>; Fri, 12 Jan 2001 05:45:44 -0500
Message-ID: <3A5EE1EC.C12F15CF@uow.edu.au>
Date: Fri, 12 Jan 2001 21:52:28 +1100
From: Andrew Morton <andrewm@uow.edu.au>
X-Mailer: Mozilla 4.7 [en] (X11; I; Linux 2.4.0 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: pwc@speakeasy.net
CC: linux-kernel@vger.kernel.org, linux-net@vger.kernel.org
Subject: Re: 2.4.0-ac3 write() to tcp socket returning errno of -3 (ESRCH:"No 
 such process")
In-Reply-To: <Pine.LNX.4.21.0101111023090.716-100000@localhost> (message from
		Paul Cassella on Thu, 11 Jan 2001 10:45:13 -0600 (CST)),
		<Pine.LNX.4.21.0101111023090.716-100000@localhost> <200101111718.JAA03092@pizda.ninka.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"David S. Miller" wrote:
> 
>    Date: Thu, 11 Jan 2001 10:45:13 -0600 (CST)
>    From: Paul Cassella <pwc@speakeasy.net>
> 
>    I'm not familiar enough with the tcp code to know if this patch
>    (against -ac6) is a solution, band-aid, or, in fact, wrong, but
>    I've run with it (on -ac3) and haven't seen the errors for over
>    twelve hours, which is three times longer than it had been able to
>    go without it coming up.
> 
> See the fix I put in 2.4.1-pre2, which is:

The -pre2 fix exists exclusively because of Paul's
exhaustive debugging efforts.  Thanks!

-
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
