Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S133012AbRA1RyP>; Sun, 28 Jan 2001 12:54:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135459AbRA1RyF>; Sun, 28 Jan 2001 12:54:05 -0500
Received: from smtp-server.maine.rr.com ([204.210.65.66]:49341 "HELO
	smtp-server.maine.rr.com") by vger.kernel.org with SMTP
	id <S133012AbRA1Rx7>; Sun, 28 Jan 2001 12:53:59 -0500
Message-ID: <002901c08951$f751bfa0$b001a8c0@caesar>
From: "paradox3" <paradox3@maine.rr.com>
To: "Bruce Harada" <bruce@ask.ne.jp>, <linux-kernel@vger.kernel.org>
In-Reply-To: <003f01c088fb$a35c06e0$b001a8c0@caesar> <20010128174016.3fba71ad.bruce@ask.ne.jp>
Subject: Re: Poor SCSI drive performance on SMP machine, 2.2.16
Date: Sun, 28 Jan 2001 12:44:29 -0500
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

I don't get any messages relating to the drives in any syslog output.



----- Original Message -----
From: "Bruce Harada" <bruce@ask.ne.jp>
To: "paradox3" <paradox3@maine.rr.com>
Cc: <linux-kernel@vger.kernel.org>; <linux-smp@vger.kernel.org>
Sent: Sunday, January 28, 2001 3:40 AM
Subject: Re: Poor SCSI drive performance on SMP machine, 2.2.16


>
> Hi.
>
> Do you get messages like the ones below in /var/log/messages?
>
>   sym53c875-0-<0,0>: QUEUE FULL! 8 busy, 7 disconnected CCBs
>   sym53c875-0-<0,0>: tagged command queue depth set to 7
>
> In fact, do you get any messages in your log files that look like they
> might be related?
>
> --
> Bruce Harada
> bruce@ask.ne.jp
>
>
> On Sun, 28 Jan 2001 02:26:32 -0500
> "paradox3" <paradox3@maine.rr.com> wrote:
>
> > I have an SMP machine (dual PII 400s) running 2.2.16 with one 10,000 RPM
> > IBM
> > 10 GB SCSI drive
> > (AIC 7890 on motherboard, using aic7xxx.o), and four various IDE drives.
> > The
> > SCSI drive
> > performs the worst. In tests of writing 100 MB and sync'ing, one of my
> > IDE
> > drives takes 31 seconds. The SCSI drive (while doing nothing else) took
> > 2 minutes, 10 seconds. This is extremely noticable in file transfers
> > that
> > completely
> > monopolize the SCSI drive, and are much slower than when involving the
> > IDE
> > drives.
> > After a large data operation on the SCSI drive, the system will hang for
> > several minutes.
> > Anyone know what could be causing this? Thanks.
> >
> > Attached are some data to help.
> >
> >
> > Thanks,
> >     Para-dox (paradox3@maine.rr.com)
> >
> >
>

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
