Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268252AbTCFSSr>; Thu, 6 Mar 2003 13:18:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268266AbTCFSSq>; Thu, 6 Mar 2003 13:18:46 -0500
Received: from mx2.elte.hu ([157.181.151.9]:13495 "HELO mx2.elte.hu")
	by vger.kernel.org with SMTP id <S268252AbTCFSSg>;
	Thu, 6 Mar 2003 13:18:36 -0500
Date: Thu, 6 Mar 2003 19:27:02 +0100 (CET)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: jvlists@ntlworld.com
Cc: Linus Torvalds <torvalds@transmeta.com>, Jeff Garzik <jgarzik@pobox.com>,
       Andrew Morton <akpm@digeo.com>, <rml@tech9.net>,
       <linux-kernel@vger.kernel.org>
Subject: Re: [patch] "HT scheduler", sched-2.5.63-B3
In-Reply-To: <g3of4owfex.fsf@bart.isltd.insignia.com>
Message-ID: <Pine.LNX.4.44.0303061925050.17038-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 6 Mar 2003 jvlists@ntlworld.com wrote:

> P.S. IMVHO the xine problem is completely different as has nothing to
> with interactivity but with the fact that it is soft real-time. i.e. you
> need to distingish xine from say a gimp filter or a 3D renderer with
> incremental live updates of the scene it is creating.

it is the same category of problems: xine and X are both applications,
which, if lagged, are noticed by users. xine can be a perfectly fine CPU
hog when playing back DVDs. It can also be a mostly interactive task
playing back music mostly. For xine it's not just that audio skipping that
gets noticed, it's also the video-playback jerkiness that can be noticed
by users.

	Ingo

