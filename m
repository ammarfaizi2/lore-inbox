Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S143901AbRA1UCe>; Sun, 28 Jan 2001 15:02:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S143978AbRA1UCQ>; Sun, 28 Jan 2001 15:02:16 -0500
Received: from smtp-server.maine.rr.com ([204.210.65.66]:35022 "HELO
	smtp-server.maine.rr.com") by vger.kernel.org with SMTP
	id <S143901AbRA1UB7>; Sun, 28 Jan 2001 15:01:59 -0500
Message-ID: <001401c08963$da160e20$b001a8c0@caesar>
From: "paradox3" <paradox3@maine.rr.com>
To: "Bruce Harada" <bruce@ask.ne.jp>, <linux-kernel@vger.kernel.org>
In-Reply-To: <003f01c088fb$a35c06e0$b001a8c0@caesar> <20010128174016.3fba71ad.bruce@ask.ne.jp><002901c08951$f751bfa0$b001a8c0@caesar> <20010129043143.3ac5fd99.bruce@ask.ne.jp>
Subject: Re: Poor SCSI drive performance on SMP machine, 2.2.16
Date: Sun, 28 Jan 2001 14:52:31 -0500
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

I did this:

date
dd if=/dev/zero of=TESTFILE bs=1024 count=102400
date
sync
date


and I gave the time differences from the first to the last timestamp.

Regards, Para-dox (paradox3@maine.rr.com)



----- Original Message -----
From: "Bruce Harada" <bruce@ask.ne.jp>
To: "paradox3" <paradox3@maine.rr.com>
Cc: <linux-kernel@vger.kernel.org>
Sent: Sunday, January 28, 2001 2:31 PM
Subject: Re: Poor SCSI drive performance on SMP machine, 2.2.16


>
> Hm. As a point of comparison, I use a similar system to yours (full SCSI,
> though, no IDE) and I can copy a 100MB file from disk-to-disk, or on the
> same disk, in around 13 seconds. Where are you copying to the SCSI drive
> from - the same drive, an IDE disk, CDROM? If IDE, what are its
> particulars? (Check with hdparm -iI /dev/hd?)
>
> --
> Bruce Harada
> bruce@ask.ne.jp
>
>
>
> On Sun, 28 Jan 2001 12:44:29 -0500
> "paradox3" <paradox3@maine.rr.com> wrote:
> >
> > I don't get any messages relating to the drives in any syslog output.
> >
> > >
> > > Do you get messages like the ones below in /var/log/messages?
> > >
> > >   sym53c875-0-<0,0>: QUEUE FULL! 8 busy, 7 disconnected CCBs
> > >   sym53c875-0-<0,0>: tagged command queue depth set to 7
> > >
> > > In fact, do you get any messages in your log files that look like they
> > > might be related?
> > >
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> Please read the FAQ at http://www.tux.org/lkml/
>

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
