Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284687AbRLZSJo>; Wed, 26 Dec 2001 13:09:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284676AbRLZSJe>; Wed, 26 Dec 2001 13:09:34 -0500
Received: from oe23.law14.hotmail.com ([64.4.20.80]:55819 "EHLO hotmail.com")
	by vger.kernel.org with ESMTP id <S284688AbRLZSJ3>;
	Wed, 26 Dec 2001 13:09:29 -0500
X-Originating-IP: [65.27.38.196]
From: "Idrigal \(Eric Rautenkranz\)" <darklordoflinux@hotmail.com>
To: "Calin A. Culianu" <calin@ajvar.org>,
        "Jelnin Andrey" <bsod@gs7.saminfo.ru>
Cc: <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.30.0112261147401.20982-100000@rtlab.med.cornell.edu>
Subject: Re: I have problem with SB-FMI16 radio
Date: Wed, 26 Dec 2001 12:09:27 -0600
Organization: Ion Networks, Inc.
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2600.0000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Message-ID: <OE23yJxArGvnCjnZS08000079b1@hotmail.com>
X-OriginalArrivalTime: 26 Dec 2001 18:09:24.0003 (UTC) FILETIME=[72E55730:01C18E38]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greet/mae govannen

----- Original Message -----
From: "Calin A. Culianu" <calin@ajvar.org>
To: "Jelnin Andrey" <bsod@gs7.saminfo.ru>
Cc: <linux-kernel@vger.kernel.org>
Sent: Wednesday, 26 December, 2001 10:49 AM
Subject: Re: I have problem with SB-FMI16 radio


> On Wed, 26 Dec 2001, Jelnin Andrey wrote:
>
> > Hi
> > I have problem with SB-FMI16 radio
NO!
> >
> > I use plain 2.4.5 kernel from Slackware 8.0
> > 1. I compile module for radio-sb16fmi  - that's ok
> > 2. I /sbin/modprobe radio-sb16fmi io=0x284  - that's ok
> > 3. When I try to control radio I hear nothing
> > What is this ???
> >
> > PS In RedHat 6.2 - it work's without problem ???
>
> This is a stupid suggestion, but try running something like aumix or
> something to turn the volume on the output channels on.  For some reason,
> on some soundcards, the driver somehow initializes the board to have 0%
> volume on all output channels!!
It's actually the way the card itself defaults.  Some, not all, cards
automatically default to 0% volume.  This is for no reason, except that
creative (not to name anyone in particular!) said so.
>
> It's possible that internally redhat compensates for this by doing that
> "applying mixer settings" thing you see at bootup... which would explain
> why it works in redhat and not in slackware...
Closed OSs (such as the dreaded windows) initialize, and then load last
mixer settings.  RedHat does this too, because it wants to be simple.  Slack
does not because it doesn't care.
>
Simple solution, edit your rc.sysinit or rc.local to load the mixer
settings. (You need aumix for this).  Check out your redhat scripts for the
command, I don't remember it at the moment.  somehting like <aumix -l
/etc/myaudiomix.conf> or such.
> -Calin
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>
Idrigal of Imladris

