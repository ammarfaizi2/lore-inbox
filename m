Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289809AbSBEVJX>; Tue, 5 Feb 2002 16:09:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289813AbSBEVJN>; Tue, 5 Feb 2002 16:09:13 -0500
Received: from mx2.elte.hu ([157.181.151.9]:4052 "HELO mx2.elte.hu")
	by vger.kernel.org with SMTP id <S289809AbSBEVJI>;
	Tue, 5 Feb 2002 16:09:08 -0500
Date: Wed, 6 Feb 2002 00:06:47 +0100 (CET)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: <mingo@elte.hu>
To: Kristian <kristian.peters@korseby.net>
Cc: Brandon Low <lostlogic@lostlogicx.com>, <starfire@dplanet.ch>,
        <linux-kernel@vger.kernel.org>
Subject: Re: New scheduler in 2.4. series?
In-Reply-To: <20020205193856.7628dcb3.kristian.peters@korseby.net>
Message-ID: <Pine.LNX.4.33.0202060004230.21710-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 5 Feb 2002, Kristian wrote:

> [...] I still have some trouble with high priority nice levels (renice
> -20). For some seconds the system gets totally unresponsive for user
> requests while switching between those processes. [...]

if you are using nice -20 tasks then they might take CPU time away from
lower priority tasks. This is why bigger negative nice levels should only
be used sparingly. (and this is why it can only be done as root.)

> The last one I've tried was J2.

that's a pretty old patch, the current one is -K2.

	Ingo

