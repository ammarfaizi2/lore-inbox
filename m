Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264419AbUA3X2y (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jan 2004 18:28:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264433AbUA3X2y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jan 2004 18:28:54 -0500
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:27332 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S264419AbUA3X2w
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jan 2004 18:28:52 -0500
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: wrlk@riede.org, Jens Axboe <axboe@suse.de>
Subject: Re: The survival of ide-scsi in 2.6.x
Date: Fri, 30 Jan 2004 23:56:59 +0100
User-Agent: KMail/1.5.3
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
References: <1072809890.2839.24.camel@mulgrave> <20040103190857.GY5523@suse.de> <20040128132400.GA23308@serve.riede.org>
In-Reply-To: <20040128132400.GA23308@serve.riede.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200401302356.59401.bzolnier@elka.pw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi!

Can you split your patch and drop cosmetic changes?

I have troubles with reading/understanding it,
I assume Jens has similar problems ;-).

BTW maybe we can move things forward:
fix ide-scsi.c and carefully remove Onstream support from ide-tape.c?

--bart

On Wednesday 28 of January 2004 14:24, Willem Riede wrote:
> On 2004.01.03 14:08, Jens Axboe wrote:
> > On Tue, Dec 30 2003, Willem Riede wrote:
> > > On 2003.12.30 13:44, James Bottomley wrote:
> > > >     If people will have me, I am prepared to take on that
> > > > responsibility. I am just concerned that I may not have enough of a
> > > > variety of devices to be able to thoroughly test it (unless the DI-30
> > > > is the only one :-)). What do people see as the requirements to be
> > > > able to maintain ide-scsi?
> > > >
> > > > Well...there's currently not a long line of people wanting to do
> > > > this, so feel free to send in patches (at least cc'd to linux-scsi so
> > > > I can pick them up easily), and we'll see how it goes.
> > >
> > > OK. You did see the patch that came with the original, right? I just
> > > sent it to linux-kernel because the audience there is broader.
> > >
> > > Linus wants Jens to look at it, so I'm waiting for his response.
> >
> > It's pending review, I'll get to it tomorrow...
>
> I guess it's been a long day :-), but can you let me know what
> realistically I can expect?
>
> Thanks, Willem Riede.

