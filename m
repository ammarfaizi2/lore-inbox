Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132227AbRAHToG>; Mon, 8 Jan 2001 14:44:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132947AbRAHTn4>; Mon, 8 Jan 2001 14:43:56 -0500
Received: from [194.213.32.137] ([194.213.32.137]:6148 "EHLO bug.ucw.cz")
	by vger.kernel.org with ESMTP id <S132945AbRAHTno>;
	Mon, 8 Jan 2001 14:43:44 -0500
Message-ID: <20010105230950.B301@bug.ucw.cz>
Date: Fri, 5 Jan 2001 23:09:50 +0100
From: Pavel Machek <pavel@suse.cz>
To: David Lang <david.lang@digitalinsight.com>,
        David Woodhouse <dwmw2@infradead.org>
Cc: Daniel Phillips <phillips@innominate.de>,
        Helge Hafting <helgehaf@idb.hist.no>, linux-kernel@vger.kernel.org
Subject: Re: Journaling: Surviving or allowing unclean shutdown?
In-Reply-To: <10290.978630745@redhat.com> <Pine.LNX.4.31.0101040954040.10387-100000@dlang.diginsite.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.93i
In-Reply-To: <Pine.LNX.4.31.0101040954040.10387-100000@dlang.diginsite.com>; from David Lang on Thu, Jan 04, 2001 at 10:00:01AM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> 1. setup the power switch so it doesn't actually turn things off (it
> issues the shutdown command instead)

Evil. Devices that are powered off should stay powered off, and there
should be big mechanical switch to do that, so that no EMI or power
glitch can make them power up.

Also thing about cases where powerplant fails, or when electricity in
the house fails. I've seen places where electricity failed 5 times a
day, because someone put 10A fuse and we were using just about 2kW...

								Pavel
-- 
I'm pavel@ucw.cz. "In my country we have almost anarchy and I don't care."
Panos Katsaloulis describing me w.r.t. patents at discuss@linmodems.org
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
