Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275778AbRJYRsk>; Thu, 25 Oct 2001 13:48:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275813AbRJYRs3>; Thu, 25 Oct 2001 13:48:29 -0400
Received: from [209.195.52.30] ([209.195.52.30]:35348 "HELO [209.195.52.30]")
	by vger.kernel.org with SMTP id <S275778AbRJYRsS>;
	Thu, 25 Oct 2001 13:48:18 -0400
From: David Lang <david.lang@digitalinsight.com>
To: Victor Yodaiken <yodaiken@fsmlabs.com>
Cc: Rob Turk <r.turk@chello.nl>, linux-kernel@vger.kernel.org
Date: Thu, 25 Oct 2001 09:26:58 -0700 (PDT)
Subject: Re: [RFC] New Driver Model for 2.5
In-Reply-To: <20011025082001.B764@hq2>
Message-ID: <Pine.LNX.4.40.0110250926380.15014-100000@dlang.diginsite.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

let alone a reason for a suspend to be triggered while running the tape.

David Lang

On Thu, 25 Oct 2001, Victor Yodaiken wrote:

> Date: Thu, 25 Oct 2001 08:20:01 -0600
> From: Victor Yodaiken <yodaiken@fsmlabs.com>
> To: Rob Turk <r.turk@chello.nl>
> Cc: linux-kernel@vger.kernel.org
> Subject: Re: [RFC] New Driver Model for 2.5
>
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
>
>
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>
