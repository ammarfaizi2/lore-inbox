Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261425AbRFTPkz>; Wed, 20 Jun 2001 11:40:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261558AbRFTPkp>; Wed, 20 Jun 2001 11:40:45 -0400
Received: from be02.imake.com ([151.200.87.11]:46601 "EHLO be02.tfsm.com")
	by vger.kernel.org with ESMTP id <S261425AbRFTPkb>;
	Wed, 20 Jun 2001 11:40:31 -0400
Message-ID: <3B30C4D2.30915E4@247media.com>
Date: Wed, 20 Jun 2001 11:44:19 -0400
From: Russell Leighton <russell.leighton@247media.com>
X-Mailer: Mozilla 4.51 [en] (Win98; I)
X-Accept-Language: en
MIME-Version: 1.0
To: Ben Greear <greearb@candelatech.com>, linux-kernel@vger.kernel.org
Subject: Re: [OT] Threads, inelegance, and Java
In-Reply-To: <20010620042544.E24183@vitelus.com> <3B30BD5D.153A5FE9@candelatech.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ben Greear wrote:
<snip>

> System-design and elegance are easy to get
> in Java, and in fact are independent of language.  Good c code will beat
> Java in most cases, performance wise, but lately the difference has become
> small enough not to matter for most applications.

Rather a sweeping statement.

I don't buy it...depends what you mean by "most applications".
I bet 90% of the  "most"  would be better served by
being written in Visual Basic (or Perl, or Python, or PHP pick your poison
for a very high level language)...and if you really care about
resource usage and/or performance you don't
want a very high high level language and Java does not leap to mind
as part of the set of credible alternatives.

I had a company that gaves us a tech briefing of their system.
They dumped mega-bucks into multiple Sun E10000s they needed to run their Java apps...
the were proud of their scalable design, just add more hardware!
True, the high level design was fine and trivially scalable w/more hw BUT
what a waste, if their app was done in C they could have
had it run faster and it would have cost them significantly less (in the millions of $$).
The lack of a good operating system _dependent_ interface
makes running fast hard in Java when you need to do IO...
yes, there is always JNI so you can add a little C to mmap a file or whatever,
but if you are doing that, you slide down the slippery slope of justifying Java.
That's just one aspect, don't get me started (e.g., memory mangement, method call
overhead, type checking, yuk).

> Speed is not the most
> important feature in a great many programs, otherwise we'd all be using
> assembly still.

Agreed.

It's a judgement call.

I just think that Java is not particularly good at anything (jack of all trades master of none).


--
---------------------------------------------------
Russell Leighton    russell.leighton@247media.com
---------------------------------------------------


