Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276448AbRI2H0e>; Sat, 29 Sep 2001 03:26:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276449AbRI2H0W>; Sat, 29 Sep 2001 03:26:22 -0400
Received: from mailout6-0.nyroc.rr.com ([24.92.226.125]:37117 "EHLO
	mailout6.nyroc.rr.com") by vger.kernel.org with ESMTP
	id <S276448AbRI2H0N>; Sat, 29 Sep 2001 03:26:13 -0400
Message-ID: <07f901c148b8$720a6230$1a01a8c0@allyourbase>
From: "Dan Maas" <dmaas@dcine.com>
To: "Mark Frazer" <mark@somanetworks.com>
Cc: <pavel@md5.ca>, <linux-kernel@vger.kernel.org>, <alan@lxorguk.ukuu.org.uk>
In-Reply-To: <fa.b97kd6v.8j2vhi@ifi.uio.no> <fa.hmvo4bv.l2gsaj@ifi.uio.no>
Subject: Re: kernel changes
Date: Sat, 29 Sep 2001 03:29:15 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4807.1700
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4807.1700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> The answer is to treat all linus/ac/aa/... kernels as development
> kernels.  Don't treat anything as stable until it's been through
> a real QA cycle.

I definitely have to second what you guys are saying here... 2.2.x is the
stable kernel series, 2.4.x is for caffeine-fueled developers who read the
LKML at least once every day...

e.g. I consider it extremely embarrassing that fundamental drivers like
aic7xxx, emu10k1, tulip, etc. are breaking regularly in the mainline
kernels. I haven't had any trouble with things like this in Windows for
several years now... Sure the Windows drivers are probably a few percent
slower, but as Nathan Myers once wrote, "It is meaningless to compare the
efficiency of a running system against one which might have done some
operations faster if it had not crashed."

I think we all owe major thanks to Alan Cox, who does his best to keep the
house in order amidst the chaos of kernel development (kudos to Mr. Cox for
holding on to Rik's VM design long enough for it to stabilize!). If anything
I wish there were a third primary maintainer who would take an even more
conservative stance, hanging maybe 2 minor versions behind Linus and -ac,
and only picking up changes that have been tested widely. Hmm, the people
working on distro kernels are probably just about doing this already...
Maybe if they could combine efforts somehow?

Regards,
Dan

