Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261687AbSIXOqm>; Tue, 24 Sep 2002 10:46:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261688AbSIXOqm>; Tue, 24 Sep 2002 10:46:42 -0400
Received: from k7g317-2.kam.afb.lu.se ([130.235.57.218]:26253 "EHLO
	cheetah.psv.nu") by vger.kernel.org with ESMTP id <S261687AbSIXOqm>;
	Tue, 24 Sep 2002 10:46:42 -0400
Date: Tue, 24 Sep 2002 16:50:46 +0200 (CEST)
From: Peter Svensson <petersv@psv.nu>
To: Michael Sinz <msinz@wgate.com>
cc: "Bill Huey (Hui)" <billh@gnuppy.monkey.org>,
       Peter Waechtler <pwaechtler@mac.com>, <linux-kernel@vger.kernel.org>,
       ingo Molnar <mingo@redhat.com>
Subject: Offtopic: (was Re: [ANNOUNCE] Native POSIX Thread Library 0.1)
In-Reply-To: <3D90749D.50609@wgate.com>
Message-ID: <Pine.LNX.4.44.0209241646170.2383-100000@cheetah.psv.nu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 24 Sep 2002, Michael Sinz wrote:

> > Several raytracers can (could?) split the workload into multiple 
> > processes, some being started on other computers over rsh or similar.
> 
> And they exist - but the I/O overhead makes it "not a win" on a
> single machine.  (It hurts too much)

For raytracers (which was the example) you need almost no coordination at
all. Just partition the scene and you are done. This is going offtopic
fast. The point I was making is that there is really no great reward in
grouping threads. Either you need to educate your users and trust them to
behave, or you need per user scheduling.

Peter
--
Peter Svensson      ! Pgp key available by finger, fingerprint:
<petersv@psv.nu>    ! 8A E9 20 98 C1 FF 43 E3  07 FD B9 0A 80 72 70 AF
------------------------------------------------------------------------
Remember, Luke, your source will be with you... always...



