Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265369AbTBOWdk>; Sat, 15 Feb 2003 17:33:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265378AbTBOWdk>; Sat, 15 Feb 2003 17:33:40 -0500
Received: from [81.2.122.30] ([81.2.122.30]:6148 "EHLO darkstar.example.net")
	by vger.kernel.org with ESMTP id <S265369AbTBOWdi>;
	Sat, 15 Feb 2003 17:33:38 -0500
From: John Bradford <john@grabjohn.com>
Message-Id: <200302152244.h1FMidpW000307@darkstar.example.net>
Subject: Re: openbkweb-0.0
To: akpm@digeo.com (Andrew Morton)
Date: Sat, 15 Feb 2003 22:44:39 +0000 (GMT)
Cc: lm@bitmover.com, linux-kernel@vger.kernel.org
In-Reply-To: <20030215142455.7264ad36.akpm@digeo.com> from "Andrew Morton" at Feb 15, 2003 02:24:55 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > I always thought that that is what the bk-commit mailing lists were
> > for?  I could be wrong about that, not having used BitKeeper - if so,
> > what are they for, and would it not be possible to simply have a
> > mailing list which got sent a diff every time Linus' updated his tree?
> 
> The latest diff against the last-released kernel is always available
> at http://www.kernel.org/pub/linux/kernel/v2.5/testing/cset/
> 
> "Gzipped full patch from ..."

So it's perfectly possible to poll
http://www.kernel.org/pub/linux/kernel/v2.5/testing/cset/ every half
hour or so, run it through:

/HREF="(.*)">Gzippped full patch/

retrieve $1, download it, then gzip -dc /tmp/latest_changeset.gz patch
-p1

John.
