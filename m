Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263556AbTCUJKm>; Fri, 21 Mar 2003 04:10:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263561AbTCUJKl>; Fri, 21 Mar 2003 04:10:41 -0500
Received: from 81-2-122-30.bradfords.org.uk ([81.2.122.30]:38404 "EHLO
	81-2-122-30.bradfords.org.uk") by vger.kernel.org with ESMTP
	id <S263556AbTCUJKk>; Fri, 21 Mar 2003 04:10:40 -0500
From: John Bradford <john@grabjohn.com>
Message-Id: <200303210923.h2L9NciG000393@81-2-122-30.bradfords.org.uk>
Subject: Re: Release of 2.4.21
To: bernd@gams.at (Bernd Petrovitsch)
Date: Fri, 21 Mar 2003 09:23:38 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <15812.1048236045@frodo.gams.co.at> from "Bernd Petrovitsch" at Mar 21, 2003 09:40:45 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> >>Why can't we just make all releases smaller and more frequent?
> >
> >Why do we need 2.4.x-pre at all, anyway - why can't we just test
> >things in the -[a-z][a-z] trees, and _start_ with -rc1?
> >
> >Why can't we just do bugfixes for 2.4, and speed up 2.5 development?
> 
> Because 2.4 is used on (real) production systems - even my desktop PC
> on my workplace is considered a production system - which (at least)
> should run and therefore trying 2.5 is not an option (and no, no way).
> And then it takes 1.5 years for the next stable kernel release which 
> implies that quite new hardware (without an existing driver) cannot be
> used for any production-like system.

I would include support for new chipsets in with bugfixes.

> IOW you would just loose a lot real use and testing of backported 
> stuff and new hardware drivers.

If nobody tests 2.5.x on a specific piece of hardware, 2.6.0 will be
released without being tested on that piece of hardware.

Incrementing the version number from 2.5.$bignum to 2.6.0 does _not_
magically fix all the bugs in it.

> And no, I don't think that someone wants that.

Production systems should be backed up.  No question about that.

Unless the system has to run 24/7, which a desktop machine usually
doesn't have to, I don't see why testing 2.5 on it isn't a
possibility.

John.
