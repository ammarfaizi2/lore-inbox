Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271633AbRHPUqX>; Thu, 16 Aug 2001 16:46:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271636AbRHPUqE>; Thu, 16 Aug 2001 16:46:04 -0400
Received: from e2.ny.us.ibm.com ([32.97.182.102]:17819 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S271633AbRHPUqB> convert rfc822-to-8bit;
	Thu, 16 Aug 2001 16:46:01 -0400
Importance: Normal
Subject: Re: Re: limit cpu
To: Eduardo =?iso-8859-1?Q?Cort=E9s?= <the_beast@softhome.net>
Cc: linux-kernel@vger.kernel.org
X-Mailer: Lotus Notes Release 5.0.3 (Intl) 21 March 2000
Message-ID: <OF83B3DC6D.E0F03776-ON85256AAA.0070C275@pok.ibm.com>
From: "Shailabh Nagar" <nagar@us.ibm.com>
Date: Thu, 16 Aug 2001 16:46:06 -0400
X-MIMETrack: Serialize by Router on D01ML233/01/M/IBM(Release 5.0.8 |June 18, 2001) at
 08/16/2001 04:46:07 PM
MIME-Version: 1.0
Content-type: text/plain; charset=iso-8859-1
Content-transfer-encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org




Restricting CPU usage alone can be done relatively easily during
recalculate . Before renewing the counter for a task, a quick check could
be made against a newly added user-specific limit. If very precise
accounting is not needed, the check could be done by one of the periodic
daemons.....

But a bigger question remains : will doing this achieve the objective of
isolating a malicious/errant process ? There are a number of other system
resources that the process/user could overuse to the detriment of other
users/processes.

Shailabh


Eduardo Cortés <the_beast@softhome.net>@vger.kernel.org on 08/16/2001
03:22:55 PM

Sent by:  linux-kernel-owner@vger.kernel.org


To:   linux-kernel@vger.kernel.org
cc:
Subject:  Re: Re: limit cpu



On Thursday 16 August 2001 20:54, you wrote:
> > If somebody want to develope it, a lot of thanks. I see scheduler could
> > be better with this feature, opinions?
>
> one excellent reason noone has bothered with it is that hardware
> is dirt cheap.  it's extremely unusual these days to find a machine
> where hostile users are given shell accounts.  for non-hostile
> situations (my lab, for instance), or for servers, the feature is
> useless.
at server level, this feature will be used for virtual hosts (a lot of
ISP's). Could be used at home for security reason limitting any user
95-97%,
and box will be more secure. A lot of people use applications (for XFree)
that could crash the box for this reason.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/



