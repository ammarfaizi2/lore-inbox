Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130001AbRBKKmd>; Sun, 11 Feb 2001 05:42:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132152AbRBKKmZ>; Sun, 11 Feb 2001 05:42:25 -0500
Received: from [194.213.32.137] ([194.213.32.137]:4100 "EHLO bug.ucw.cz")
	by vger.kernel.org with ESMTP id <S130001AbRBKKmO>;
	Sun, 11 Feb 2001 05:42:14 -0500
Message-ID: <20010210225541.E7877@bug.ucw.cz>
Date: Sat, 10 Feb 2001 22:55:41 +0100
From: Pavel Machek <pavel@suse.cz>
To: Josh Myer <jbm@joshisanerd.com>, linux-kernel@vger.kernel.org
Subject: Re: [OT] Major Clock Drift
In-Reply-To: <Pine.LNX.4.21.0102032225240.8663-100000@grace>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.93i
In-Reply-To: <Pine.LNX.4.21.0102032225240.8663-100000@grace>; from Josh Myer on Sat, Feb 03, 2001 at 10:32:36PM -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> I know this _really_ isn't the forum for this, but a friend of mine has
> noticed major, persistent clock drift over time. After several weeks, the
> clock is several minutes slow (always slow). Any thoughts on the
> cause? (Google didn't show up anything worthwhile in the first couple of
> pages, so i gave up).

Vesafb can do this kind of stuff. Vesafb is evil to interrupt latency,
and at .5sec interrupt latency, clock will loose time.
								Pavel
-- 
I'm pavel@ucw.cz. "In my country we have almost anarchy and I don't care."
Panos Katsaloulis describing me w.r.t. patents at discuss@linmodems.org
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
