Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261841AbSI2XS0>; Sun, 29 Sep 2002 19:18:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261842AbSI2XS0>; Sun, 29 Sep 2002 19:18:26 -0400
Received: from sccrmhc01.attbi.com ([204.127.202.61]:55448 "EHLO
	sccrmhc01.attbi.com") by vger.kernel.org with ESMTP
	id <S261841AbSI2XSZ>; Sun, 29 Sep 2002 19:18:25 -0400
From: "Buddy Lumpkin" <b.lumpkin@attbi.com>
To: "'Bill Davidsen'" <davidsen@tmr.com>,
       "'Peter Waechtler'" <pwaechtler@mac.com>
Cc: "'Larry McVoy'" <lm@bitmover.com>, <linux-kernel@vger.kernel.org>,
       "'ingo Molnar'" <mingo@redhat.com>
Subject: RE: [ANNOUNCE] Native POSIX Thread Library 0.1
Date: Sun, 29 Sep 2002 16:26:24 -0700
Message-ID: <000001c2680f$a13af930$0472e50c@peecee>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.2616
Importance: Normal
In-Reply-To: <Pine.LNX.3.96.1020923150331.13351A-100000@gatekeeper.tmr.com>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sun introduced a new thread library in Solaris 8 that is 1:1, but it did
not replace the default N:M version, you have to link against
/usr/lib/lwp.

http://supportforum.sun.com/freesolaris/techfaqs.html?techfaqs_2957
http://www.itworld.com/AppDev/1170/swol-1218-insidesolaris/

I was at a USENIX BOF on threads in Boston year before last and Bill
Lewis was ranting about how the N:M model sucks. Christopher Provenzano
was right there and didn't seem to add any feelings one way or the
other.

Regards,

--Buddy

-----Original Message-----
From: linux-kernel-owner@vger.kernel.org
[mailto:linux-kernel-owner@vger.kernel.org] On Behalf Of Bill Davidsen
Sent: Monday, September 23, 2002 12:15 PM
To: Peter Waechtler
Cc: Larry McVoy; linux-kernel@vger.kernel.org; ingo Molnar
Subject: Re: [ANNOUNCE] Native POSIX Thread Library 0.1

On Mon, 23 Sep 2002, Peter Waechtler wrote:

> Am Montag den, 23. September 2002, um 12:05, schrieb Bill Davidsen:
> 
> > On Sun, 22 Sep 2002, Larry McVoy wrote:
> >
> >> On Sun, Sep 22, 2002 at 08:55:39PM +0200, Peter Waechtler wrote:
> >>> AIX and Irix deploy M:N - I guess for a good reason: it's more
> >>> flexible and combine both approaches with easy runtime tuning if
> >>> the app happens to run on SMP (the uncommon case).
> >>
> >> No, AIX and IRIX do it that way because their processes are so
bloated
> >> that it would be unthinkable to do a 1:1 model.
> >
> > And BSD? And Solaris?
> 
> Don't know. I don't have access to all those Unices. I could try
FreeBSD.

At your convenience.
 
> According to http://www.kegel.com/c10k.html  Sun is moving to 1:1
> and FreeBSD still believes in M:N

Sun is total news to me, "moving to" may be in Solaris 9, Sol8 seems to
still be N:M. BSD is as I thought.
> 
> MacOSX 10.1 does not support PROCESS_SHARED locks, tried that 5
minutes 
> ago.

Thank you for the effort. Hum, that's a bit of a surprise, at least to
me. 

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel"
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/

