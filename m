Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129439AbRBAVZY>; Thu, 1 Feb 2001 16:25:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131168AbRBAVZO>; Thu, 1 Feb 2001 16:25:14 -0500
Received: from [194.213.32.137] ([194.213.32.137]:16132 "EHLO bug.ucw.cz")
	by vger.kernel.org with ESMTP id <S131860AbRBAVZD>;
	Thu, 1 Feb 2001 16:25:03 -0500
Message-ID: <20010201134005.A119@bug.ucw.cz>
Date: Thu, 1 Feb 2001 13:40:05 +0100
From: Pavel Machek <pavel@suse.cz>
To: David Woodhouse <dwmw2@infradead.org>, Joe deBlaquiere <jadb@redhat.com>
Cc: yodaiken@fsmlabs.com, Andrew Morton <andrewm@uow.edu.au>,
        Nigel Gamble <nigel@nrg.org>, linux-kernel@vger.kernel.org,
        linux-audio-dev@ginette.musique.umontreal.ca
Subject: Re: [linux-audio-dev] low-latency scheduling patch for 2.4.0
In-Reply-To: <200101220150.UAA29623@renoir.op.net> <Pine.LNX.4.05.10101211754550.741-100000@cosmic.nrg.org>, <Pine.LNX.4.05.10101211754550.741-100000@cosmic.nrg.org>; <20010128061428.A21416@hq.fsmlabs.com> <3A742A79.6AF39EEE@uow.edu.au> <3A74462A.80804@redhat.com> <20010129084410.B32652@hq.fsmlabs.com> <30672.980867280@redhat.com> <3A76E155.2030905@redhat.com> <5797.980871554@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.93i
In-Reply-To: <5797.980871554@redhat.com>; from David Woodhouse on Tue, Jan 30, 2001 at 04:19:14PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> >  I wasn't thinking of running the kernel XIP from writable, but even
> > trying to do that from the filesystem is a mess. If you're going to be
> >  that way about it...
> 
> Heh. I am. Read-only XIP is going to be doable, but writable XIP means that
> any time you start to write to the flash chip, you have to find all
> the

I thought that Vtech Helio folks already have XIP supported...
								Pavel

-- 
I'm pavel@ucw.cz. "In my country we have almost anarchy and I don't care."
Panos Katsaloulis describing me w.r.t. patents at discuss@linmodems.org
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
