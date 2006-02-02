Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751016AbWBBMqX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751016AbWBBMqX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Feb 2006 07:46:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751017AbWBBMqX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Feb 2006 07:46:23 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:32395 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S1751014AbWBBMqW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Feb 2006 07:46:22 -0500
Date: Thu, 2 Feb 2006 13:46:21 +0100
From: Martin Mares <mj@ucw.cz>
To: Joerg Schilling <schilling@fokus.fraunhofer.de>
Cc: matthias.andree@gmx.de, linux-kernel@vger.kernel.org, bzolnier@gmail.com
Subject: Re: CD writing in future Linux (stirring up a hornets' nest)
Message-ID: <mj+md-20060202.121514.24403.atrey@ucw.cz>
References: <43DDFBFF.nail16Z3N3C0M@burner> <1138642683.7404.31.camel@juerg-pd.bitron.ch> <43DF3C3A.nail2RF112LAB@burner> <58cb370e0601310410r46210e8dvc66f631f208e9b8d@mail.gmail.com> <43DF678E.nail3B431CUWJ@burner> <58cb370e0601310623ic220d27q3bfd4642cd0538fb@mail.gmail.com> <Pine.LNX.4.61.0602011630440.22529@yvahk01.tjqt.qr> <43E1D5AD.nail4MI2R8NR2@burner> <20060202102058.GB10554@merlin.emma.line.org> <43E1ECF1.nail4SJ15SNCH@burner>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43E1ECF1.nail4SJ15SNCH@burner>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Joerg!

> > > BTW: Introducing an orthogonal SCSI based implementation would save a lot of
> > > code. The model currently used on Linux is duplicating a lot of unneeded code 
> > > in target drivers and the SCSI glue code is only a few KB (less than 30k on 
> > > Solaris). 
> >
> > You've been stating this oft enough now. It won't change in a day even
> > if you post this every hour. Please cease posting the same stuff over
> > and over again.
> 
> Why do you repeat posting false claims over and over?

This is getting ridiculous. Point to a single false claim in the mail
you were replying to.

The only claim there was that you are posting the same stuff again and
again, and it is obviously true, as can be demostrated by anybody who
can use grep.

> Unless I see any move towards a more realistic way of looking at things
> it does not make sense to repeat things and short time later I will see
> the same unadequate replies as I did see days before.

Yes. You have been repeatedly asked to produce any sound arguments why the
current interface is bad.

So far, you have produced none. You have only written about Linux not
following your personal model of virtual SCSI buses, which is maybe
a good argument for supporting your dislike for Linux, but nothing else.

Also, you mentioned several phantoms like IDE tapes, which nobody seems
to care about, a couple of bugs which the driver developers were willing
to fix if you tell how to reproduce them.

Finally, you mentioned problems with scanning and you were told that:
(1) the current scanning code in libscg works at least for all currently
existing transports, if a trivial bug is fixed,
(2) for a complete view of the available HW, you should use the HAL,
(3) most people prefer either using a GUI interface which converges to
using HAL anyway, or refer to devices by their names.

The rest was just hand-waving.

The interface preferred by Linux has changed for very good reasons,
and a number of such reasons has been demonstrated. Also, it's not
changing daily, the switchover from emulating SCSI to performing SG_IO
directly on /dev/hd* was the only big change in last 10 years.

So unless anybody has any new arguments for either approach, let's end
this thread.

				Have a nice fortnight
-- 
Martin `MJ' Mares   <mj@ucw.cz>   http://atrey.karlin.mff.cuni.cz/~mj/
Faculty of Math and Physics, Charles University, Prague, Czech Rep., Earth
Outside of a dog, a book is man's best friend. Inside a dog, it's too dark to read.
