Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268102AbTBMVn5>; Thu, 13 Feb 2003 16:43:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268104AbTBMVn5>; Thu, 13 Feb 2003 16:43:57 -0500
Received: from [81.2.122.30] ([81.2.122.30]:14596 "EHLO darkstar.example.net")
	by vger.kernel.org with ESMTP id <S268102AbTBMVn4>;
	Thu, 13 Feb 2003 16:43:56 -0500
From: John Bradford <john@grabjohn.com>
Message-Id: <200302132154.h1DLs3ar012874@darkstar.example.net>
Subject: Re: 2.5.60 cheerleading...
To: jgarzik@pobox.com (Jeff Garzik)
Date: Thu, 13 Feb 2003 21:54:03 +0000 (GMT)
Cc: plars@linuxtestproject.org, davej@codemonkey.org.uk, edesio@ieee.org,
       linux-kernel@vger.kernel.org, torvalds@transmeta.com,
       edesio@task.com.br
In-Reply-To: <20030213213850.GA22037@gtf.org> from "Jeff Garzik" at Feb 13, 2003 04:38:50 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > Ideally, there should be no waiting around for replies.  The message is
> > sent, he starts whatever build/boot test cycle, checks for replies when
> > he's done and ready to release.  If nothing looks urgent enough to hold
> > it up, then he pushes the release.  I still don't see how this adds any
> > kind of terrible delay.
> 
> Outside suggestions to "improve" Linus's workflow usually fall upon deaf
> ears...

The only suggestions really worth making, in my opinion, are whether
it's easier to work with more frequent, smaller releases, or less
frequent larger releases.

Infact, it's more or less directly analogous to packet size in a file
transfer protocol - fewer larger packets are more efficient, unless
there is a problem, when you have to re-transmit a whole, large,
packet.

Likewise with kernel releases - fewer, larger releases work fine and
mean less effort for developers, unless something breaks, in which
case there is a lot to go through to locate the problem, and people
who can't boot the broken kernel have to wait longer to test other
things that were newly merged in that release.

John.
