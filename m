Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131519AbQKRWbr>; Sat, 18 Nov 2000 17:31:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131761AbQKRWbh>; Sat, 18 Nov 2000 17:31:37 -0500
Received: from [194.213.32.137] ([194.213.32.137]:7428 "EHLO bug.ucw.cz")
	by vger.kernel.org with ESMTP id <S131519AbQKRWbE>;
	Sat, 18 Nov 2000 17:31:04 -0500
Message-ID: <20001118220214.E382@bug.ucw.cz>
Date: Sat, 18 Nov 2000 22:02:14 +0100
From: Pavel Machek <pavel@suse.cz>
To: "John D. Kim" <johnkim@aslab.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Dax Kelson <dax@gurulabs.com>, linux-kernel@vger.kernel.org
Subject: Re: APM oops with Dell 5000e laptop
In-Reply-To: <E13wTbc-0008BC-00@the-village.bc.nu> <Pine.LNX.4.04.10011161254110.2078-100000@mail.aslab.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.93i
In-Reply-To: <Pine.LNX.4.04.10011161254110.2078-100000@mail.aslab.com>; from John D. Kim on Thu, Nov 16, 2000 at 01:04:41PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > Is there a way to uniquely identify the affected BIOSes at boot time and
> 
> > Im looking at one with some pointers from Dell. It won't be in 2.2.18 so its
> > quite likely a fixed BIOS will be out first anyway.
> 
> Wherever the fix comes from, I sure hope it comes soon, because it's
> getting harder and harder to find cpus for the original 5000 series.  And
> this new model's been sitting on my desk for couple of weeks now
> collecting dust.

Disable apm and be done with that!

I do not see why this is a problem. Just add comment to apm.c, there
are more comments about b0rken machines in there.
								Pavel
-- 
I'm pavel@ucw.cz. "In my country we have almost anarchy and I don't care."
Panos Katsaloulis describing me w.r.t. patents at discuss@linmodems.org
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
