Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293347AbSCJWRV>; Sun, 10 Mar 2002 17:17:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293349AbSCJWRA>; Sun, 10 Mar 2002 17:17:00 -0500
Received: from konza.flinthills.com ([64.39.200.1]:8640 "EHLO
	konza.flinthills.com") by vger.kernel.org with ESMTP
	id <S293347AbSCJWQ5>; Sun, 10 Mar 2002 17:16:57 -0500
Message-ID: <007f01c1c881$2eb51400$d3c02740@flinthills.com>
From: "Derek J Witt" <djw@flinthills.com>
To: <linux-kernel@vger.kernel.org>
Cc: <djw@flinthills.com>
In-Reply-To: <200203100823.JAA14203@cave.bitwizard.nl>
Subject: Re: Suspend support for IDE
Date: Sun, 10 Mar 2002 16:16:09 -0600
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2600.0000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Does the IDE blacklist include those drives that malfunction if they're not
using the correct connector on the IDE ribbon cable?

I found out a few weeks ago that my Caviar WD36400 is  that particular.
Upon putting that drive back on the middle connector on secondary, my box
was then able to suspend and resume without the drive disconnecting on me.

-- Derek Witt.

----- Original Message -----
From: "Rogier Wolff" <R.E.Wolff@BitWizard.nl>
To: "Alan Cox" <alan@lxorguk.ukuu.org.uk>
Cc: "Pavel Machek" <pavel@ucw.cz>; <dalecki@evision-ventures.com>; "kernel
list" <linux-kernel@vger.kernel.org>
Sent: Sunday, March 10, 2002 2:23 AM
Subject: Re: Suspend support for IDE


> Alan Cox wrote:
> > Also there is the some fun about buggy drives and power up happenings.
On no
> > account can you issue any command that might touch the platter unless
you
> > know the drive is at full running speed when spinning up certain old
drives
> > because the firmware in some cases forgets to check the drive is at
speed
> > and you physically destroy the disk over time. Thankfully thats old old
> > drives (540Mb quantum if I remember rightly)
>
> That could be 1.6G or 2.5G WD drives. AC31600, AC32500.
>
> Roger.
>
> --
> ** R.E.Wolff@BitWizard.nl ** http://www.BitWizard.nl/ ** +31-15-2137555 **
> *-- BitWizard writes Linux device drivers for any device you may have! --*
> * There are old pilots, and there are bold pilots.
> * There are also old, bald pilots.
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

