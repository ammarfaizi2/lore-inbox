Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268145AbRHaQ5e>; Fri, 31 Aug 2001 12:57:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268286AbRHaQ5Y>; Fri, 31 Aug 2001 12:57:24 -0400
Received: from relay1.zonnet.nl ([62.58.50.37]:22707 "EHLO relay1.zonnet.nl")
	by vger.kernel.org with ESMTP id <S268217AbRHaQ5P>;
	Fri, 31 Aug 2001 12:57:15 -0400
Message-ID: <3B8FC1E7.44B72F2E@linux-m68k.org>
Date: Fri, 31 Aug 2001 18:57:11 +0200
From: Roman Zippel <zippel@linux-m68k.org>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.8 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: ctm@ardi.com
CC: Linus Torvalds <torvalds@transmeta.com>,
        Daniel Phillips <phillips@bonn-fries.net>,
        David Lang <david.lang@digitalinsight.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [IDEA+RFC] Possible solution for min()/max() war
In-Reply-To: <fa.ehba65v.10i6abc@ifi.uio.no> <fa.odqvefv.g4k4j6@ifi.uio.no> <vy1d75c2pxy.fsf@w2k.ardi.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

ctm@ardi.com wrote:

> I don't maintain any linux kernel code, so I'm not lobbying for this
> particular solution.  I just don't think Linus's example is _good_
> code.  I think it's correct, but misleading, code.

True, but the only argument I heard from Linus lately is, how bad
Wsign-compare is. It's not that difficult to prove that gcc produces
false warnings, even if it has the information to know better. That's
not the point.
What started the discussion is that Linus introduced a new version of
min/max macros. I brought up arguments, why I think these macros are
unsafe and I got no response to this. I made the mistake of mentioning
-Wsign-compare and I get a long explanation instead, how bad it is.
In the meantime people are trying to fix bugs without defining them,
ignoring the fact that there are already tools, which can help finding
real bugs. If the tool is too coarse, use it only from time to time or
use a different tool.

bye, Roman
