Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129388AbRBHDJw>; Wed, 7 Feb 2001 22:09:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129578AbRBHDJm>; Wed, 7 Feb 2001 22:09:42 -0500
Received: from assigned.162.54.206.in-addr.arpa ([206.54.162.175]:47418 "EHLO
	mail.roland.net") by vger.kernel.org with ESMTP id <S129631AbRBHDJb>;
	Wed, 7 Feb 2001 22:09:31 -0500
Message-ID: <000401c0917c$85326ae0$bda236ce@vegroup.com>
From: "Jim Roland" <jroland@roland.net>
To: "David Woodhouse" <dwmw2@infradead.org>
Cc: "J. Dow" <jdow@earthlink.net>, <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.05.10102062344490.31995-100000@ns.roland.net>  <16718.981535065@redhat.com>
Subject: Re: RedHat kernel RPM 2.2.16 
Date: Wed, 7 Feb 2001 21:09:14 -0600
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4133.2400
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

AH HA!  Thanks!


----- Original Message -----
From: "David Woodhouse" <dwmw2@infradead.org>
To: "Jim Roland" <jroland@roland.net>
Cc: "J. Dow" <jdow@earthlink.net>; <linux-kernel@vger.kernel.org>
Sent: Wednesday, February 07, 2001 2:37 AM
Subject: Re: RedHat kernel RPM 2.2.16


>
> jroland@roland.net said:
> >  FWIW, the rpm -i did unpack the kernel to the /usr/src/redhat/SOURCES
> > directory, however, I had to manually untar the sources to /usr/src to
> > get my kernel, move over the appropriate .config file, and manually
> > run the patches to patch the sources.  Forcing RPM to be very
> > talkative (via -vv) gave me a bunch of "action unknown" errors, and
> > the rpm's install scripts did not execute.  This occurs on an RH7
> > system as well.  Seems to be something wrong with RH's kernel rpm?
>
> Install the kernel-source binary RPM, which contains the build tree
already
> extracted and set up as you desire, instead of the master SRPM which
> contains build instructions for all the kernel versions.
>
> i.e. kernel-source-2.2.16-3.i386.rpm, not kernel-2.2.16-3.src.rpm
>
> --
> dwmw2
>
>

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
