Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S131349AbQKWKTO>; Thu, 23 Nov 2000 05:19:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S131100AbQKWKTE>; Thu, 23 Nov 2000 05:19:04 -0500
Received: from [194.213.32.137] ([194.213.32.137]:3332 "EHLO bug.ucw.cz")
        by vger.kernel.org with ESMTP id <S131349AbQKWKSw>;
        Thu, 23 Nov 2000 05:18:52 -0500
Message-ID: <20001122002205.B219@bug.ucw.cz>
Date: Wed, 22 Nov 2000 00:22:05 +0100
From: Pavel Machek <pavel@suse.cz>
To: "Stephen Gutknecht (linux-kernel)" <linux-kernel@i405.com>,
        "'David Lang'" <david.lang@digitalinsight.com>,
        David Riley <oscar@the-rileys.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Better testing of hardware (was: Defective Read Hat)
In-Reply-To: <0066CB04D783714B88D83397CCBCA0CD49AF@spike2.i405.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.93i
In-Reply-To: <0066CB04D783714B88D83397CCBCA0CD49AF@spike2.i405.net>; from Stephen Gutknecht (linux-kernel) on Tue, Nov 21, 2000 at 01:39:17PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> You will find that most Overlockers run their favorite game in a loop for 10
> or 20 minutes as the best test they have found.  This often does
> Video+Ram+CPU+Sound board (PCI) at full tilt. What is needed is a
> _standardized test_ that really goes after everything (including network).

You don't need to test network that much: if your network card garbles
packets under high load, it is ok. TCP checksums should catch that.

(OTOH, on really broken serial cable (no flow control and machines
definitely miss characters sometimes), I can occassionaly see
corruption even with TCP. Ouch.)
								Pavel
-- 
I'm pavel@ucw.cz. "In my country we have almost anarchy and I don't care."
Panos Katsaloulis describing me w.r.t. patents at discuss@linmodems.org
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
