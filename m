Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275003AbRJYPZA>; Thu, 25 Oct 2001 11:25:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274964AbRJYPYu>; Thu, 25 Oct 2001 11:24:50 -0400
Received: from news.cistron.nl ([195.64.68.38]:26377 "EHLO ncc1701.cistron.net")
	by vger.kernel.org with ESMTP id <S275067AbRJYPYa>;
	Thu, 25 Oct 2001 11:24:30 -0400
From: "Rob Turk" <r.turk@chello.nl>
Subject: Re: [RFC] New Driver Model for 2.5
Date: Thu, 25 Oct 2001 17:22:18 +0200
Organization: Cistron Internet Services B.V.
Message-ID: <9r9asg$7jr$1@ncc1701.cistron.net>
In-Reply-To: <9r8icv$ukh$1@ncc1701.cistron.net> <20011025082001.B764@hq2>
X-Trace: ncc1701.cistron.net 1004023505 7803 213.46.44.164 (25 Oct 2001 15:25:05 GMT)
X-Complaints-To: abuse@cistron.nl
X-Priority: 3
X-MSMail-Priority: Normal
X-Newsreader: Microsoft Outlook Express 5.50.4522.1200
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4522.1200
To: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


"Victor Yodaiken" <yodaiken@fsmlabs.com> wrote in message
news:cistron.20011025082001.B764@hq2...
> On Thu, Oct 25, 2001 at 10:27:11AM +0200, Rob Turk wrote:
> > > The act of "suspend" should basically be: shut off the SCSI controller,
> > > screw all devices, reset the bus on resume.
> > >
> >
> > Doing so will create havoc on sequential devices, such as tape drives. If
>
> I'm failing  to imagine a good case for suspending a system that has a
> tape drive on it.
>

Well, maybe the tape example wasn't all that good. The state information
(wide/sync negotiation) still needs to be retained for all SCSI devices though.

Rob




