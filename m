Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131788AbRBMPNm>; Tue, 13 Feb 2001 10:13:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131888AbRBMPNc>; Tue, 13 Feb 2001 10:13:32 -0500
Received: from relay.dera.gov.uk ([192.5.29.49]:52317 "HELO relay.dera.gov.uk")
	by vger.kernel.org with SMTP id <S131810AbRBMPNU>;
	Tue, 13 Feb 2001 10:13:20 -0500
Message-ID: <XFMail.20010213150816.gale@syntax.dera.gov.uk>
X-Mailer: XFMail 1.4.4 on Linux
X-Priority: 3 (Normal)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
MIME-Version: 1.0
In-Reply-To: <21887.982075420@redhat.com>
Date: Tue, 13 Feb 2001 15:08:16 -0000 (GMT)
From: Tony Gale <gale@syntax.dera.gov.uk>
To: David Woodhouse <dwmw2@infradead.org>
Subject: Re: 2.4.x SMP blamed for Xfree 4.0 crashes
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 13-Feb-2001 David Woodhouse wrote:
> The crashes got less frequent when I started running X against
> glibc-2.1
> (note _running_ against glibc-2.1, not just compiling against it
> and running
> against glibc-2.2). But they were still happening. 

I'm running RH6.2 with glibc-2.1.3-22

> 
> In the week or so since killing xscreensaver, neither of the boxen
> on which
> I was seeing this have fallen over. Another box on which I killed 
> xscreensaver but didn't run X against glibc-2.1 is still suffering,
> albeit 
> less frequently. 

Yes, a number of the xscreensaver modules cause XFree to crash - they
always have. I have previously tested them all and disabled the ones
that crash Xfree.

But, under 2.4 I have had X crash whilst I've been using it - which
didn't happen under 2.2.

> 
> Looks like two separate bugs - I see no reason to expect that
> there's only 
> one such bug causing X to fall over :)

It's a good premise :-)

-tony


---
E-Mail: Tony Gale <gale@syntax.dera.gov.uk>
I base my fashion taste on what doesn't itch.
		-- Gilda Radner

The views expressed above are entirely those of the writer
and do not represent the views, policy or understanding of
any other person or official body.
