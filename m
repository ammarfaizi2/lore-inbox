Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314133AbSDLSIK>; Fri, 12 Apr 2002 14:08:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314134AbSDLSIJ>; Fri, 12 Apr 2002 14:08:09 -0400
Received: from relay03.valueweb.net ([216.219.253.237]:38152 "EHLO
	relay03.valueweb.net") by vger.kernel.org with ESMTP
	id <S314133AbSDLSII>; Fri, 12 Apr 2002 14:08:08 -0400
Message-ID: <3CB721A8.F6C772C9@opersys.com>
Date: Fri, 12 Apr 2002 14:04:24 -0400
From: Karim Yaghmour <karym@opersys.com>
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.16-TRACE i686)
X-Accept-Language: en, French/Canada, French/France, fr-FR, fr-CA
MIME-Version: 1.0
To: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
CC: Mark Hahn <hahn@physics.mcmaster.ca>,
        Zoltan Menyhart <Zoltan.Menyhart@bull.net>,
        linux-kernel@vger.kernel.org
Subject: Re: Event logging vs enhancing printk
In-Reply-To: <Pine.LNX.4.33.0204120836060.22605-100000@coffee.psychology.mcma
			 ster.ca> <2238694662.1018597136@[10.10.2.3]>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


"Martin J. Bligh" wrote:
> > frankly, evlog is a solution in search of a problem.  I see no reason
> > printk can't do TSC timestamping, more robust and/or efficient buffering,
> > auto-classification in klogd, realtime filtering/notification in
> > userspace, even delaying of formatting, and logging of binary data.
> 
> Of course you could. You could just take the existing mechanism
> that's been written for event logging and call it printk, for one.

True,

I've been following this debate for some time and it seems to me that
there's been a lot of arguments for or against an "enhanced printk".
As Michel Dagenais pointed out, we can give it the name we would like,
it is the technical merits of the evlog proposal which should be looked
at carefully.

Since everyone seems to agree that printk needs to be changed and since
the evlog folks have already worked extensively on this issue, it would
seem that their work should be weighed in and, at the very least, tested
out by the folks who insist on an "enhanced printk".

Cheers,

Karim

===================================================
                 Karim Yaghmour
               karym@opersys.com
      Embedded and Real-Time Linux Expert
===================================================
