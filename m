Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131831AbQKJWzs>; Fri, 10 Nov 2000 17:55:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131873AbQKJWzi>; Fri, 10 Nov 2000 17:55:38 -0500
Received: from vger.timpanogas.org ([207.109.151.240]:50692 "EHLO
	vger.timpanogas.org") by vger.kernel.org with ESMTP
	id <S131831AbQKJWze>; Fri, 10 Nov 2000 17:55:34 -0500
Message-ID: <3A0C7BFA.7042E3CD@timpanogas.org>
Date: Fri, 10 Nov 2000 15:51:38 -0700
From: "Jeff V. Merkey" <jmerkey@timpanogas.org>
Organization: TRG, Inc.
X-Mailer: Mozilla 4.7 [en] (WinNT; I)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org, sendmail-bugs@sendmail.org
Subject: Re: sendmail fails to deliver mail with attachments in /var/spool/mqueue
In-Reply-To: <200011102251.eAAMp1I232107@saturn.cs.uml.edu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



[ ... named redacted by request ... ] wrote:
> 
> > Well, here's what the sendmail folks **REAL** opinion of Linux is and
> > the way load average is calculated (senders name removed)
> >
> > [... sendmail person ...]
> >
> >> Ok, here's my blunt answer: Linux sucks.  Why does it have a load
> >> average of 10 if there are two processes running? Let's check the
> >> man page:
> >>
> >>             and the three load averages for the system.  The load
> >>             averages  are  the average number of process ready to
> >>             run during the last 1, 5 and 15 minutes.   This  line
> >>             is  just  like  the  output of uptime(1).
> >>
> >> So: Linux load average on these systems is broken.
> 
> If that is _our_ man page, it is broken. (well, old) Otherwise,
> this is just a case of not mindlessly obeying the BSD "standard".
> 
> Linux 2.4.xx includes some blocked processes in the load average
> calculation. This is because the BSD load average calculation
> could give a load of 0.0 when the system is severely overloaded
> by IO. I think only uninterruptable processes got added in.
> 
> Maybe this isn't the best solution... there could have been
> a second load average for IO maybe.
> 
> Feel free to forward this to the sendmail people, to the BSD people
> in case they'd like to "standardize" the new calculation, or to the
> linux-kernel mailing list for discussion -- w/o my name please.

Forwarded at the request of a tier 1 Linux person after redacting their
name.

Jeff
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
