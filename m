Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261501AbTCGK44>; Fri, 7 Mar 2003 05:56:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261505AbTCGK44>; Fri, 7 Mar 2003 05:56:56 -0500
Received: from mx2.elte.hu ([157.181.151.9]:6051 "HELO mx2.elte.hu")
	by vger.kernel.org with SMTP id <S261501AbTCGK4y>;
	Fri, 7 Mar 2003 05:56:54 -0500
Date: Fri, 7 Mar 2003 12:06:16 +0100 (CET)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: Helge Hafting <helgehaf@aitel.hist.no>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [patch] "HT scheduler", sched-2.5.63-B3
In-Reply-To: <3E687238.8030504@aitel.hist.no>
Message-ID: <Pine.LNX.4.44.0303071140420.8497-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 7 Mar 2003, Helge Hafting wrote:

> But we don't really need further kernel support for that, do we? I know
> a user currently cannot raise priority, but the user can run all his
> normal apps at slightly lower priority, except for xine. And the
> admin/distrubutor can set everything up for using the slightly lower
> priority by default.  Well, perhaps all this involves so much use of
> "nice" that kernel support is a good idea anyway...

true, but i think we could help by doing this automatically. This will
also make it easier to tune things as part of the scheduler proper.

	Ingo

