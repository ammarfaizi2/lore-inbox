Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280871AbRKGRZY>; Wed, 7 Nov 2001 12:25:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280865AbRKGRZN>; Wed, 7 Nov 2001 12:25:13 -0500
Received: from shed.alex.org.uk ([195.224.53.219]:28845 "HELO shed.alex.org.uk")
	by vger.kernel.org with SMTP id <S280871AbRKGRZD>;
	Wed, 7 Nov 2001 12:25:03 -0500
Date: Wed, 07 Nov 2001 17:24:58 -0000
From: Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>
Reply-To: Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>
To: "Albert D. Cahalan" <acahalan@cs.uml.edu>, linux-kernel@alex.org.uk
Cc: Alexander Viro <viro@math.psu.edu>, Ricky Beam <jfbeam@bluetopia.net>,
        Roy Sigurd Karlsbakk <roy@karlsbakk.net>,
        Linux Kernel Mail List <linux-kernel@vger.kernel.org>,
        Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>
Subject: Re: PROPOSAL: /proc standards (was dot-proc interface [was: /proc
Message-ID: <1832004393.1005153898@[10.132.113.67]>
In-Reply-To: <200111070720.fA77KZB486967@saturn.cs.uml.edu>
In-Reply-To: <200111070720.fA77KZB486967@saturn.cs.uml.edu>
X-Mailer: Mulberry/2.1.0 (Win32)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



--On Wednesday, November 07, 2001 2:20 AM -0500 "Albert D. Cahalan" <acahalan@cs.uml.edu> wrote:

> I can see that you are unfamiliar with the /proc filesystem.
>
> You can change kernels because app developers work hard to
> be tolerant of stupid /proc changes.
> Some of the crap that
> I've stumbled across, mostly while doing procps work:

My point is two-fold:

1. Sure, you (and no doubt others) had to do lots
   of work fixing userland, which
   you shouldn't have had to do. But that seems to be
   more down to lack of discipline in interface changes
   rather than because the interface isn't binary. I am
   sure it's easier to strip out a spurious 'kb' that
   gets added after a number, than to deal with (say)
   an extra inserted DWORD with no version traching.

2. The system survived. The interface was there. Bload
   sweat and tears were no doubt expended, possibly by
   the wrong people, but in practice the interface worked,
   (no, not optimally). I'd suggest even with it's badly
   managed changes, thouse have been less disruptive than
   many other non-ascii based conventions (I'm thinking
   back to Net-2E/2D). Sure, wtmp, utmp have been stable.
   Not sufficiently familiar with process accounting or
   quotas, though I have some possibly incorrect memory
   of the latter suffering some format change which was
   generated compatibility problems with user space tools?

--
Alex Bligh
